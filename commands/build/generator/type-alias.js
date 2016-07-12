const R = require('ramda');
const camelcase = require('camelcase');
const { stripIndent, oneline } = require('common-tags');

const capitalize = (string) => {
  return string.charAt(0).toUpperCase() + string.slice(1);
};

/**
 * isNumberInt :: a -> Boolean
 */
const isNumberInt = R.pipe(R.modulo(1), R.equals(0));

/**
 * isInt :: a -> Boolean
 */
const isInt = R.both(R.is(Number), isNumberInt);

/**
 * isFloat :: a -> Boolean
 */
const isFloat = R.both(R.is(Number), R.complement(isNumberInt));

/**
 * isEmptyArray :: a -> Boolean
 */
const isEmptyArray = R.both(R.isArrayLike, R.isEmpty);

/**
 * isNonEmptyArray :: a -> Boolean
 */
const isNonEmptyArray = R.both(R.isArrayLike, R.complement(R.isEmpty));

/**
 * makeGuessAtType :: a -> String
 */
const makeGuessAtType = R.cond([
  [R.isNil, R.always('Maybe _Unknown')],
  [R.is(Boolean), R.always('Bool')],
  [R.is(String), R.always('String')],
  [isInt, R.always('Int')],
  [isFloat, R.always('Float')],
  [isEmptyArray, R.always('List a')],
  [isNonEmptyArray, (value) => `List ${makeGuessAtType(R.head(value))}`],
  [R.is(Object), R.always('Something')],
  [R.T, 'Unknown']
]);


/*
TaskCluster =
{
  Auth: Auth,
  AuthEvents: {}.
  ...
}
 */

const createTypeAlias = (item, typeAliasName) => {
  let fields = [];
  let extraAliases = [];
  let prefix = typeAliasName === 'TaskCluster' ? '' : typeAliasName;

  Object
    .keys(item)
    .forEach(name => {
      if (name === '$schema') {
        return;
      }

      let value = item[name];
      let type = makeGuessAtType(value);

      if (type === 'Something') {
        name = prefix + capitalize(name);
        type = name;
        extraAliases = extraAliases.concat(createTypeAlias(value, name))
        // extraAliases.push(...createTypeAlias(value, capitalize(name)));
      } else if (type === 'List Something') {
        name = prefix + capitalize(name);
        type = 'List ' + name;
        extraAliases = extraAliases.concat(createTypeAlias(value[0], name))
        // extraAliases.push(...createTypeAlias(value, capitalize(name)));
      }

      if (name === 'type') {
        name = 'api_type';
      }

      // name = camelcase(name);
      fields.push(`${name} : ${type}`);
    });

  let joinedFields = R.join('\n  , ', fields);

  extraAliases
    .push(`
type alias ${typeAliasName} = 
  { ${joinedFields}
  }
`);

  return extraAliases;
};

const findTypeAliases = (string) => {
  string = oneline`${string}`;
  let grabTypeAliases = string.match(/type alias(.+?)=(.+?)}/g);

  if (!grabTypeAliases || !grabTypeAliases.length) {
    return [];
  }

  return grabTypeAliases;
};

const findUnionTypes = (string) => {
  let matches = [];

  string = string.replace('type alias', 'asdf');
  let grabUnionTypes = string.match(/type (.+?)=(.+?)/g);

  for (let match of grabUnionTypes) {
    let buffer = [];

    for (let line of match.input.split('\n')) {
      if (buffer.length > 1 && !line.startsWith(' ')) {
        break;
      }

      buffer.append(line);
    }

    matches.push(buffer.join(''));
  }

  return matches;
};

module.exports = {
  isNumberInt,
  isInt,
  isFloat,
  isEmptyArray,
  isNonEmptyArray,
  makeGuessAtType,
  createTypeAlias,
  findTypeAliases,
  findUnionTypes
};
