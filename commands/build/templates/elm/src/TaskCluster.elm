module TaskCluster exposing (..)



type alias Index =
  { description : String
  ,

  }

"Index": {
    "version": 0,
    "$schema": "http://schemas.taskcluster.net/base/v1/api-reference.json#",
    "title": "Task Index API Documentation",
    "description": "The task index, typically available at `index.taskcluster.net`, is\nresponsible for indexing tasks. In order to ensure that tasks can be\nlocated by recency and/or arbitrary strings. Common use-cases includes\n\n * Locate tasks by git or mercurial `<revision>`, or\n * Locate latest task from given `<branch>`, such as a release.\n\n**Index hierarchy**, tasks are indexed in a dot `.` separated hierarchy\ncalled a namespace. For example a task could be indexed in\n`<revision>.linux-64.release-build`. In this case the following\nnamespaces is created.\n\n 1. `<revision>`, and,\n 2. `<revision>.linux-64`\n\nThe inside the namespace `<revision>` you can find the namespace\n`<revision>.linux-64` inside which you can find the indexed task\n`<revision>.linux-64.release-build`. In this example you'll be able to\nfind build for a given revision.\n\n**Task Rank**, when a task is indexed, it is assigned a `rank` (defaults\nto `0`). If another task is already indexed in the same namespace with\nthe same lower or equal `rank`, the task will be overwritten. For example\nconsider a task indexed as `mozilla-central.linux-64.release-build`, in\nthis case on might choose to use a unix timestamp or mercurial revision\nnumber as `rank`. This way the latest completed linux 64 bit release\nbuild is always available at `mozilla-central.linux-64.release-build`.\n\n**Indexed Data**, when a task is located in the index you will get the\n`taskId` and an additional user-defined JSON blob that was indexed with\ntask. You can use this to store additional information you would like to\nget additional from the index.\n\n**Entry Expiration**, all indexed entries must have an expiration date.\nTypically this defaults to one year, if not specified. If you are\nindexing tasks to make it easy to find artifacts, consider using the\nexpiration date that the artifacts is assigned.\n\n**Valid Characters**, all keys in a namespace `<key1>.<key2>` must be\nin the form `/[a-zA-Z0-9_!~*'()%-]+/`. Observe that this is URL-safe and\nthat if you strictly want to put another character you can URL encode it.\n\n**Indexing Routes**, tasks can be indexed using the API below, but the\nmost common way to index tasks is adding a custom route on the following\nform `index.<namespace>`. In-order to add this route to a task you'll\nneed the following scope `queue:route:index.<namespace>`. When a task has\nthis route, it'll be indexed when the task is **completed successfully**.\nThe task will be indexed with `rank`, `data` and `expires` as specified\nin `task.extra.index`, see example below:\n\n```js\n{\n  payload:  { /* ... */ },\n  routes: [\n    // index.<namespace> prefixed routes, tasks CC'ed such a route will\n    // be indexed under the given <namespace>\n    \"index.mozilla-central.linux-64.release-build\",\n    \"index.<revision>.linux-64.release-build\"\n  ],\n  extra: {\n    // Optional details for indexing service\n    index: {\n      // Ordering, this taskId will overwrite any thing that has\n      // rank <= 4000 (defaults to zero)\n      rank:       4000,\n\n      // Specify when the entries expires (Defaults to 1 year)\n      expires:          new Date().toJSON(),\n\n      // A little informal data to store along with taskId\n      // (less 16 kb when encoded as JSON)\n      data: {\n        hgRevision:   \"...\",\n        commitMessae: \"...\",\n        whatever...\n      }\n    },\n    // Extra properties for other services...\n  }\n  // Other task properties...\n}\n```\n\n**Remark**, when indexing tasks using custom routes, it's also possible\nto listen for messages about these tasks. Which is quite convenient, for\nexample one could bind to `route.index.mozilla-central.*.release-build`,\nand pick up all messages about release builds. Hence, it is a\ngood idea to document task index hierarchies, as these make up extension\npoints in their own.",
    "baseUrl": "https://index.taskcluster.net/v1",
    "entries": [
      {
        "type": "function",
        "method": "get",
        "route": "/task/<namespace>",
        "query": [],
        "args": [
          "namespace"
        ],
        "name": "findTask",
        "stability": "experimental",
        "title": "Find Indexed Task",
        "description": "Find task by namespace, if no task existing for the given namespace, this\nAPI end-point respond `404`.",
        "output": {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "title": "Indexed Task Response",
          "description": "Representation of an indexed task.\n",
          "type": "object",
          "properties": {
            "namespace": {
              "title": "Namespace",
              "description": "Namespace of the indexed task, used to find the indexed task in the index.\n",
              "type": "string",
              "maxLength": 255
            },
            "taskId": {
              "title": "Task Identifier",
              "description": "Unique task identifier, this is UUID encoded as\n[URL-safe base64](http://tools.ietf.org/html/rfc4648#section-5) and\nstripped of `=` padding.\n",
              "type": "string",
              "pattern": "^[A-Za-z0-9_-]{8}[Q-T][A-Za-z0-9_-][CGKOSWaeimquy26-][A-Za-z0-9_-]{10}[AQgw]$"
            },
            "rank": {
              "title": "Rank",
              "description": "If multiple tasks are indexed with the same `namespace` the task with the\nhighest `rank` will be stored and returned in later requests. If two tasks\nhas the same `rank` the latest task will be stored.\n",
              "type": "number"
            },
            "data": {
              "title": "Task Specific Data",
              "description": "Data that was reported with the task. This is an arbitrary JSON object.\n",
              "type": "object"
            },
            "expires": {
              "title": "Expiration",
              "description": "Date at which this entry expires from the task index.\n",
              "type": "string",
              "format": "date-time"
            }
          },
          "additionalProperties": false,
          "required": [
            "namespace",
            "taskId",
            "rank",
            "data",
            "expires"
          ],
          "id": "http://schemas.taskcluster.net/index/v1/indexed-task-response.json#"
        }
      },
      {
        "type": "function",
        "method": "post",
        "route": "/namespaces/<namespace>",
        "query": [],
        "args": [
          "namespace"
        ],
        "name": "listNamespaces",
        "stability": "experimental",
        "title": "List Namespaces",
        "description": "List the namespaces immediately under a given namespace. This end-point\nlist up to 1000 namespaces. If more namespaces are present a\n`continuationToken` will be returned, which can be given in the next\nrequest. For the initial request, the payload should be an empty JSON\nobject.\n\n**Remark**, this end-point is designed for humans browsing for tasks, not\nservices, as that makes little sense.",
        "input": {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "title": "List Namespaces Request",
          "description": "Request to list namespaces within a given namespace.\n",
          "type": "object",
          "properties": {
            "limit": {
              "title": "Result limit",
              "type": "integer",
              "minimum": 1,
              "maximum": 1000,
              "default": 1000,
              "description": "Maximum number of results per page. If there are more results than this\na continuation token will be return.\n"
            },
            "continuationToken": {
              "title": "Continuation Token",
              "type": "string",
              "description": "A continuation token previously returned in a response to this list\nrequest. This property is optional and should not be provided for first\nrequests.\n"
            }
          },
          "additionalProperties": false,
          "id": "http://schemas.taskcluster.net/index/v1/list-namespaces-request.json#"
        },
        "output": {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "title": "List Namespaces Response",
          "description": "Response from a request to list namespaces within a given namespace.\n",
          "type": "object",
          "properties": {
            "namespaces": {
              "title": "Namespaces",
              "description": "List of namespaces.\n",
              "type": "array",
              "items": {
                "title": "Namespace",
                "description": "Representation of a namespace that contains indexed tasks.\n",
                "type": "object",
                "properties": {
                  "namespace": {
                    "title": "Namespace",
                    "description": "Fully qualified name of the namespace, you can use this to list\nnamespaces or tasks under this namespace.\n",
                    "type": "string",
                    "maxLength": 255
                  },
                  "name": {
                    "title": "Name",
                    "type": "string",
                    "description": "Name of namespace within it's parent namespace.\n"
                  },
                  "expires": {
                    "title": "Expiration",
                    "description": "Date at which this entry, and by implication all entries below it,\nexpires from the task index.\n",
                    "type": "string",
                    "format": "date-time"
                  }
                },
                "additionalProperties": false,
                "required": [
                  "namespace",
                  "name",
                  "expires"
                ]
              }
            },
            "continuationToken": {
              "title": "Continuation Token",
              "type": "string",
              "description": "A continuation token is returned if there are more results than listed\nhere. You can optionally provide the token in the request payload to\nload the additional results.\n"
            }
          },
          "additionalProperties": false,
          "required": [
            "namespaces"
          ],
          "id": "http://schemas.taskcluster.net/index/v1/list-namespaces-response.json#"
        }
      },
      {
        "type": "function",
        "method": "post",
        "route": "/tasks/<namespace>",
        "query": [],
        "args": [
          "namespace"
        ],
        "name": "listTasks",
        "stability": "experimental",
        "title": "List Tasks",
        "description": "List the tasks immediately under a given namespace. This end-point\nlist up to 1000 tasks. If more tasks are present a\n`continuationToken` will be returned, which can be given in the next\nrequest. For the initial request, the payload should be an empty JSON\nobject.\n\n**Remark**, this end-point is designed for humans browsing for tasks, not\nservices, as that makes little sense.",
        "input": {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "title": "List Tasks Request",
          "description": "Request to list tasks within a given namespace.\n",
          "type": "object",
          "properties": {
            "limit": {
              "title": "Result limit",
              "type": "integer",
              "minimum": 1,
              "maximum": 1000,
              "default": 1000,
              "description": "Maximum number of results per page. If there are more results than this\na continuation token will be return.\n"
            },
            "continuationToken": {
              "title": "Continuation Token",
              "type": "string",
              "description": "A continuation token previously returned in a response to this list\nrequest. This property is optional and should not be provided for first\nrequests.\n"
            }
          },
          "additionalProperties": false,
          "id": "http://schemas.taskcluster.net/index/v1/list-tasks-request.json#"
        },
        "output": {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "title": "List Tasks Response",
          "description": "Representation of an indexed task.\n",
          "type": "object",
          "properties": {
            "tasks": {
              "title": "Tasks",
              "description": "List of tasks.\n",
              "type": "array",
              "items": {
                "title": "Task",
                "description": "Representation of a task.\n",
                "type": "object",
                "properties": {
                  "namespace": {
                    "title": "Namespace",
                    "description": "Namespace of the indexed task, used to find the indexed task in the\nindex.\n",
                    "type": "string",
                    "maxLength": 255
                  },
                  "taskId": {
                    "title": "Task Identifier",
                    "description": "Unique task identifier, this is UUID encoded as\n[URL-safe base64](http://tools.ietf.org/html/rfc4648#section-5) and\nstripped of `=` padding.\n",
                    "type": "string",
                    "pattern": "^[A-Za-z0-9_-]{8}[Q-T][A-Za-z0-9_-][CGKOSWaeimquy26-][A-Za-z0-9_-]{10}[AQgw]$"
                  },
                  "rank": {
                    "title": "Rank",
                    "description": "If multiple tasks are indexed with the same `namespace` the task\nwith the highest `rank` will be stored and returned in later\nrequests. If two tasks has the same `rank` the latest task will be\nstored.\n",
                    "type": "number"
                  },
                  "data": {
                    "title": "Task Specific Data",
                    "description": "Data that was reported with the task. This is an arbitrary JSON\nobject.\n",
                    "type": "object"
                  },
                  "expires": {
                    "title": "Expiration",
                    "description": "Date at which this entry expires from the task index.\n",
                    "type": "string",
                    "format": "date-time"
                  }
                },
                "additionalProperties": false,
                "required": [
                  "namespace",
                  "taskId",
                  "rank",
                  "data",
                  "expires"
                ]
              }
            },
            "continuationToken": {
              "title": "Continuation Token",
              "type": "string",
              "description": "A continuation token is returned if there are more results than listed\nhere. You can optionally provide the token in the request payload to\nload the additional results.\n"
            }
          },
          "additionalProperties": false,
          "required": [
            "tasks"
          ],
          "id": "http://schemas.taskcluster.net/index/v1/list-tasks-response.json#"
        }
      },
      {
        "type": "function",
        "method": "put",
        "route": "/task/<namespace>",
        "query": [],
        "args": [
          "namespace"
        ],
        "name": "insertTask",
        "stability": "experimental",
        "title": "Insert Task into Index",
        "description": "Insert a task into the index. Please see the introduction above, for how\nto index successfully completed tasks automatically, using custom routes.",
        "scopes": [
          [
            "index:insert-task:<namespace>"
          ]
        ],
        "input": {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "title": "Insert Task Request",
          "description": "Representation of an a task to be indexed.\n",
          "type": "object",
          "properties": {
            "taskId": {
              "title": "Task Identifier",
              "description": "Unique task identifier, this is UUID encoded as\n[URL-safe base64](http://tools.ietf.org/html/rfc4648#section-5) and\nstripped of `=` padding.\n",
              "type": "string",
              "pattern": "^[A-Za-z0-9_-]{8}[Q-T][A-Za-z0-9_-][CGKOSWaeimquy26-][A-Za-z0-9_-]{10}[AQgw]$"
            },
            "rank": {
              "title": "Rank",
              "description": "If multiple tasks are indexed with the same `namespace` the task with the\nhighest `rank` will be stored and returned in later requests. If two tasks\nhas the same `rank` the latest task will be stored.\n",
              "type": "number"
            },
            "data": {
              "title": "Task Specific Data",
              "description": "This is an arbitrary JSON object. Feel free to put whatever data you want\nhere, but do limit it, you'll get errors if you store more than 32KB.\nSo stay well, below that limit.\n",
              "type": "object"
            },
            "expires": {
              "title": "Expiration",
              "description": "Date at which this entry expires from the task index.\n",
              "type": "string",
              "format": "date-time"
            }
          },
          "additionalProperties": false,
          "required": [
            "taskId",
            "rank",
            "data",
            "expires"
          ],
          "id": "http://schemas.taskcluster.net/index/v1/insert-task-request.json#"
        },
        "output": {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "title": "Indexed Task Response",
          "description": "Representation of an indexed task.\n",
          "type": "object",
          "properties": {
            "namespace": {
              "title": "Namespace",
              "description": "Namespace of the indexed task, used to find the indexed task in the index.\n",
              "type": "string",
              "maxLength": 255
            },
            "taskId": {
              "title": "Task Identifier",
              "description": "Unique task identifier, this is UUID encoded as\n[URL-safe base64](http://tools.ietf.org/html/rfc4648#section-5) and\nstripped of `=` padding.\n",
              "type": "string",
              "pattern": "^[A-Za-z0-9_-]{8}[Q-T][A-Za-z0-9_-][CGKOSWaeimquy26-][A-Za-z0-9_-]{10}[AQgw]$"
            },
            "rank": {
              "title": "Rank",
              "description": "If multiple tasks are indexed with the same `namespace` the task with the\nhighest `rank` will be stored and returned in later requests. If two tasks\nhas the same `rank` the latest task will be stored.\n",
              "type": "number"
            },
            "data": {
              "title": "Task Specific Data",
              "description": "Data that was reported with the task. This is an arbitrary JSON object.\n",
              "type": "object"
            },
            "expires": {
              "title": "Expiration",
              "description": "Date at which this entry expires from the task index.\n",
              "type": "string",
              "format": "date-time"
            }
          },
          "additionalProperties": false,
          "required": [
            "namespace",
            "taskId",
            "rank",
            "data",
            "expires"
          ],
          "id": "http://schemas.taskcluster.net/index/v1/indexed-task-response.json#"
        }
      },
      {
        "type": "function",
        "method": "get",
        "route": "/task/<namespace>/artifacts/<name>",
        "query": [],
        "args": [
          "namespace",
          "name"
        ],
        "name": "findArtifactFromTask",
        "stability": "experimental",
        "title": "Get Artifact From Indexed Task",
        "description": "Find task by namespace and redirect to artifact with given `name`,\nif no task existing for the given namespace, this API end-point respond\n`404`.",
        "scopes": [
          [
            "queue:get-artifact:<name>"
          ]
        ]
      },
      {
        "type": "function",
        "method": "get",
        "route": "/ping",
        "query": [],
        "args": [],
        "name": "ping",
        "stability": "experimental",
        "title": "Ping Server",
        "description": "Documented later...\n\n**Warning** this api end-point is **not stable**."
      }
    ]
  },