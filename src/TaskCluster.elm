-- Trying to create type alias for Index, Index
-- Trying to create type alias for GithubEvents, Githubevents
-- Trying to create type alias for Github, Github
-- Trying to create type alias for PurgeCache, Purgecache
-- Trying to create type alias for Secrets, Secrets
-- Trying to create type alias for Hooks, Hooks
-- Trying to create type alias for AwsProvisionerEvents, Awsprovisionerevents
-- Trying to create type alias for Auth, Auth
-- Trying to create type alias for Queue, Queue
-- Trying to create type alias for PurgeCacheEvents, Purgecacheevents
-- Trying to create type alias for AuthEvents, Authevents
-- Trying to create type alias for QueueEvents, Queueevents
-- Trying to create type alias for Scheduler, Scheduler
-- Trying to create type alias for Login, Login
-- Trying to create type alias for AwsProvisioner, Awsprovisioner
-- Trying to create type alias for TreeherderEvents, Treeherderevents
-- Trying to create type alias for SchedulerEvents, Schedulerevents
import Json.Decode
import Json.Encode

type alias Index =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias GithubEvents =
    { entries : entries
    , version : version
    , exchangePrefix : exchangePrefix
    , description : description
    , title : title
    }


type alias Github =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias PurgeCache =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias Secrets =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias Hooks =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias AwsProvisionerEvents =
    { entries : entries
    , version : version
    , exchangePrefix : exchangePrefix
    , description : description
    , title : title
    }


type alias Auth =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias Queue =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias PurgeCacheEvents =
    { entries : entries
    , version : version
    , exchangePrefix : exchangePrefix
    , description : description
    , title : title
    }


type alias AuthEvents =
    { entries : entries
    , version : version
    , exchangePrefix : exchangePrefix
    , description : description
    , title : title
    }


type alias QueueEvents =
    { entries : entries
    , version : version
    , exchangePrefix : exchangePrefix
    , description : description
    , title : title
    }


type alias Scheduler =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias Login =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias AwsProvisioner =
    { baseUrl : baseUrl
    , entries : entries
    , version : version
    , description : description
    , title : title
    }


type alias TreeherderEvents =
    { entries : entries
    , version : version
    , exchangePrefix : exchangePrefix
    , description : description
    , title : title
    }


type alias SchedulerEvents =
    { entries : entries
    , version : version
    , exchangePrefix : exchangePrefix
    , description : description
    , title : title
    }


type alias TaskCluster =
    { Index : Index
    , GithubEvents : GithubEvents
    , Github : Github
    , PurgeCache : PurgeCache
    , Secrets : Secrets
    , Hooks : Hooks
    , AwsProvisionerEvents : AwsProvisionerEvents
    , Auth : Auth
    , Queue : Queue
    , PurgeCacheEvents : PurgeCacheEvents
    , AuthEvents : AuthEvents
    , QueueEvents : QueueEvents
    , Scheduler : Scheduler
    , Login : Login
    , AwsProvisioner : AwsProvisioner
    , TreeherderEvents : TreeherderEvents
    , SchedulerEvents : SchedulerEvents
    }

decodeIndex : Json.Decode.Decoder Index
decodeIndex =
    Json.Decode.succeed Index
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeGithubEvents : Json.Decode.Decoder GithubEvents
decodeGithubEvents =
    Json.Decode.succeed GithubEvents
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("exchange_prefix" := decodeExchangeprefix)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeGithub : Json.Decode.Decoder Github
decodeGithub =
    Json.Decode.succeed Github
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodePurgeCache : Json.Decode.Decoder PurgeCache
decodePurgeCache =
    Json.Decode.succeed PurgeCache
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeSecrets : Json.Decode.Decoder Secrets
decodeSecrets =
    Json.Decode.succeed Secrets
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeHooks : Json.Decode.Decoder Hooks
decodeHooks =
    Json.Decode.succeed Hooks
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeAwsProvisionerEvents : Json.Decode.Decoder AwsProvisionerEvents
decodeAwsProvisionerEvents =
    Json.Decode.succeed AwsProvisionerEvents
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("exchange_prefix" := decodeExchangeprefix)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeAuth : Json.Decode.Decoder Auth
decodeAuth =
    Json.Decode.succeed Auth
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeQueue : Json.Decode.Decoder Queue
decodeQueue =
    Json.Decode.succeed Queue
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodePurgeCacheEvents : Json.Decode.Decoder PurgeCacheEvents
decodePurgeCacheEvents =
    Json.Decode.succeed PurgeCacheEvents
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("exchange_prefix" := decodeExchangeprefix)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeAuthEvents : Json.Decode.Decoder AuthEvents
decodeAuthEvents =
    Json.Decode.succeed AuthEvents
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("exchange_prefix" := decodeExchangeprefix)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeQueueEvents : Json.Decode.Decoder QueueEvents
decodeQueueEvents =
    Json.Decode.succeed QueueEvents
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("exchange_prefix" := decodeExchangeprefix)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeScheduler : Json.Decode.Decoder Scheduler
decodeScheduler =
    Json.Decode.succeed Scheduler
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeLogin : Json.Decode.Decoder Login
decodeLogin =
    Json.Decode.succeed Login
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeAwsProvisioner : Json.Decode.Decoder AwsProvisioner
decodeAwsProvisioner =
    Json.Decode.succeed AwsProvisioner
        |: ("base_url" := decodeBaseurl)
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeTreeherderEvents : Json.Decode.Decoder TreeherderEvents
decodeTreeherderEvents =
    Json.Decode.succeed TreeherderEvents
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("exchange_prefix" := decodeExchangeprefix)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeSchedulerEvents : Json.Decode.Decoder SchedulerEvents
decodeSchedulerEvents =
    Json.Decode.succeed SchedulerEvents
        |: ("entries" := decodeEntries)
        |: ("version" := decodeVersion)
        |: ("exchange_prefix" := decodeExchangeprefix)
        |: ("description" := decodeDescription)
        |: ("title" := decodeTitle)
decodeTaskCluster : Json.Decode.Decoder TaskCluster
decodeTaskCluster =
    Json.Decode.succeed TaskCluster
        |: ("index" := decodeIndex)
        |: ("github_events" := decodeGithubevents)
        |: ("github" := decodeGithub)
        |: ("purge_cache" := decodePurgecache)
        |: ("secrets" := decodeSecrets)
        |: ("hooks" := decodeHooks)
        |: ("aws_provisioner_events" := decodeAwsprovisionerevents)
        |: ("auth" := decodeAuth)
        |: ("queue" := decodeQueue)
        |: ("purge_cache_events" := decodePurgecacheevents)
        |: ("auth_events" := decodeAuthevents)
        |: ("queue_events" := decodeQueueevents)
        |: ("scheduler" := decodeScheduler)
        |: ("login" := decodeLogin)
        |: ("aws_provisioner" := decodeAwsprovisioner)
        |: ("treeherder_events" := decodeTreeherderevents)
        |: ("scheduler_events" := decodeSchedulerevents)
encodeIndex : Index -> Json.Encode.Value
encodeIndex record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeGithubEvents : GithubEvents -> Json.Encode.Value
encodeGithubEvents record =
    Json.Encode.object
        [ ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("exchange_prefix", encodeExchangeprefix record.exchangePrefix)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeGithub : Github -> Json.Encode.Value
encodeGithub record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodePurgeCache : PurgeCache -> Json.Encode.Value
encodePurgeCache record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeSecrets : Secrets -> Json.Encode.Value
encodeSecrets record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeHooks : Hooks -> Json.Encode.Value
encodeHooks record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeAwsProvisionerEvents : AwsProvisionerEvents -> Json.Encode.Value
encodeAwsProvisionerEvents record =
    Json.Encode.object
        [ ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("exchange_prefix", encodeExchangeprefix record.exchangePrefix)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeAuth : Auth -> Json.Encode.Value
encodeAuth record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeQueue : Queue -> Json.Encode.Value
encodeQueue record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodePurgeCacheEvents : PurgeCacheEvents -> Json.Encode.Value
encodePurgeCacheEvents record =
    Json.Encode.object
        [ ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("exchange_prefix", encodeExchangeprefix record.exchangePrefix)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeAuthEvents : AuthEvents -> Json.Encode.Value
encodeAuthEvents record =
    Json.Encode.object
        [ ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("exchange_prefix", encodeExchangeprefix record.exchangePrefix)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeQueueEvents : QueueEvents -> Json.Encode.Value
encodeQueueEvents record =
    Json.Encode.object
        [ ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("exchange_prefix", encodeExchangeprefix record.exchangePrefix)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeScheduler : Scheduler -> Json.Encode.Value
encodeScheduler record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeLogin : Login -> Json.Encode.Value
encodeLogin record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeAwsProvisioner : AwsProvisioner -> Json.Encode.Value
encodeAwsProvisioner record =
    Json.Encode.object
        [ ("base_url", encodeBaseurl record.baseUrl)
        , ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeTreeherderEvents : TreeherderEvents -> Json.Encode.Value
encodeTreeherderEvents record =
    Json.Encode.object
        [ ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("exchange_prefix", encodeExchangeprefix record.exchangePrefix)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeSchedulerEvents : SchedulerEvents -> Json.Encode.Value
encodeSchedulerEvents record =
    Json.Encode.object
        [ ("entries", encodeEntries record.entries)
        , ("version", encodeVersion record.version)
        , ("exchange_prefix", encodeExchangeprefix record.exchangePrefix)
        , ("description", encodeDescription record.description)
        , ("title", encodeTitle record.title)
        ]
encodeTaskCluster : TaskCluster -> Json.Encode.Value
encodeTaskCluster record =
    Json.Encode.object
        [ ("index", encodeIndex record.Index)
        , ("github_events", encodeGithubevents record.GithubEvents)
        , ("github", encodeGithub record.Github)
        , ("purge_cache", encodePurgecache record.PurgeCache)
        , ("secrets", encodeSecrets record.Secrets)
        , ("hooks", encodeHooks record.Hooks)
        , ("aws_provisioner_events", encodeAwsprovisionerevents record.AwsProvisionerEvents)
        , ("auth", encodeAuth record.Auth)
        , ("queue", encodeQueue record.Queue)
        , ("purge_cache_events", encodePurgecacheevents record.PurgeCacheEvents)
        , ("auth_events", encodeAuthevents record.AuthEvents)
        , ("queue_events", encodeQueueevents record.QueueEvents)
        , ("scheduler", encodeScheduler record.Scheduler)
        , ("login", encodeLogin record.Login)
        , ("aws_provisioner", encodeAwsprovisioner record.AwsProvisioner)
        , ("treeherder_events", encodeTreeherderevents record.TreeherderEvents)
        , ("scheduler_events", encodeSchedulerevents record.SchedulerEvents)
        ]
