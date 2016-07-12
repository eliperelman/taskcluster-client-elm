const request = require('superagent-promise')(require('superagent'), Promise);
const fs = require('fs');
const path = require('path');

const MANIFEST_URL = process.env.npm_package_config_taskcluster_manifestUrl;

function fetch(url) {
  return request
    .get(url)
    .end()
    .then(r => r.body);
}

function fetchAndMutateReference(entry, direction) {
  return fetch(entry[direction])
    .then(data => {
      entry[direction] = data;

      if (data.type !== 'array' || !data.items || !data.items.$ref) {
        return;
      }

      return fetch(data.items.$ref)
        .then(itemData => {
          entry[direction].items = itemData;
        });
    });
}

function fetchNamespace(namespace, url) {
  return fetch(url)
    .then(namespace => {
      return new Promise((resolve) => {
        if (!namespace.entries) {
          return resolve(namespace);
        }

        Promise
          .all(namespace.entries.map(entry => {
            if (entry.type !== 'function') {
              return Promise.resolve();
            }

            let promises = [];

            if (entry.input) {
              promises.push(fetchAndMutateReference(entry, 'input'));
            }

            if (entry.output) {
              promises.push(fetchAndMutateReference(entry, 'output'));
            }

            return Promise.all(promises);
          }))
          .then(() => resolve(namespace));
      });
    })
    .then(schema => [namespace, schema]);
}

module.exports = function() {
  // this.data = require(path.join(process.cwd(), 'TaskCluster.json'));
  let done = this.async();

  Promise
    .resolve(fetch(MANIFEST_URL))
    .then(manifest => {
      let promises = Object
        .keys(manifest)
        .map(namespace => fetchNamespace(namespace, manifest[namespace]));

      return Promise.all(promises);
    })
    .then(schemas => {
      return schemas.reduce((obj, [namespace, schema]) => {
        obj[namespace] = schema;

        return obj;
      }, {});
    })
    .then(schemas => {
      this.data = schemas;
      // fs.writeFileSync(path.join(process.cwd(), 'TaskCluster.json'), JSON.stringify(schemas, null, 2), { encoding: 'utf8' });
    })
    .then(done);
};
