const R = require('ramda');
const decamelize = require('decamelize');
const { stripIndent } = require('common-tags');

const KNOWN_DECODERS = [
  'maybe',
  'list',
  'int',
  'float',
  'bool',
  'string'
];

const JSON_DECODE = 'Json.Decode.';
const JSON_ENCODE = 'Json.Encode.';

const capitalize = (string) => {
  return string.charAt(0).toUpperCase() + string.slice(1);
};

const getTypeAliasName = (string) => {
  let grabTypeName = /type alias (.+) =/.exec(string);

  if (!grabTypeName || !grabTypeName.length) {
    throw new Error('Cannot find type alias declaration');
  }

  return grabTypeName[1].trim();
};

const getUnionTypeName = (string) => {
  let grabTypeName = /type (.+) =/.exec(string);

  if (!grabTypeName || !grabTypeName.length) {
    throw new Error('Cannot find type declaration');
  }

  return grabTypeName[1].trim();
};

const getFields = (string) => {
  let grabFields = /{([^}]*)}/.exec(string);

  if (!grabFields || !grabFields.length) {
    throw new Error('Please give me a field I can work with');
  }

  return grabFields[1].split(',');
};

const getConstructors = (string) => {
  string = string.substr(string.indexOf('=') + 1);

  return string.split('|').map(part => part.trim());
};

const fieldNameAndType = (string, index) => {
  let splitted = string.split(':');

  return {
    name: splitted[0].trim(),
    type: splitted[1].trim()
  };
};

const makeGuessAtCodec = (string) => {
  return string.toLowerCase();
};

const prefixCodec = (prefix, value, defaultModule = JSON_DECODE) => {
  let parts = value.split(' ');

  return parts.map(value => {
    if (value in KNOWN_DECODERS) {
      return defaultModule + value;
    } else {
      return prefix + capitalize(value);
    }
  }).join(' ');
};

const suffixCodec = (suffix, value) => {
  let parts = value.split(' ');

  parts.map(value => {
    if (value in KNOWN_DECODERS) {
      return value;
    } else {
      return value + suffix;
    }
  }).join(' ');
};

const createDecoder = (string, hasSnakeCase = false, prefix = null, suffix = null) => {
  string = string.replace(/[\n\r]/, '');
  let typeName = getTypeAliasName(string);
  let fields = getFields(string)
    .filter(s => s.indexOf(':') !== -1)
    .map(fieldNameAndType);

  // if (hasSnakeCase) {
  //   fields = fields.map(({ name, type }) => ({ name: decamelize(name), type }));
  // }

  fields = fields.map(({ name, type }) => ({ name, type: makeGuessAtCodec(type) }));

  if (prefix !== null) {
    fields = fields.map(({ name, type }) => ({ name, type: prefixCodec(prefix, type) }));
  }

  if (suffix !== null) {
    fields = fields.map(({ name, type }) => ({ name, type: suffixCodec(prefix, type) }));
  }

  let formattedFields = fields.map(({ name, type }) => {
    return `|: ("${name}" := ${type})`;
  }).join('\n  ');

  return `
decode${typeName} : Json.Decode.Decoder ${typeName}
decode${typeName} =
Json.Decode.succeed ${typeName}
  ${formattedFields}`;
};

const createEncoder = (string, hasSnakeCase = false, prefix = null, suffix = null) => {
  string = string.replace(/[\n\r]/, '');
  let typeName = getTypeAliasName(string);
  let fields = getFields(string)
    .filter(s => s.indexOf(':') !== -1)
    .map(fieldNameAndType);
  let originalFields = fields.slice();

  // if (hasSnakeCase) {
  //   fields = fields.map(({ name, type }) => ({ name: decamelize(name), type }));
  // }

  fields = fields.map(({ name, type }) => ({ name, type: makeGuessAtCodec(type) }));

  if (prefix !== null) {
    fields = fields.map(({ name, type }) => ({ name, type: prefixCodec(prefix, type, JSON_ENCODE) }));
  }

  if (suffix !== null) {
    fields = fields.map(({ name, type }) => ({ name, type: suffixCodec(prefix, type) }));
  }

  let formattedFields = R.zip(fields, originalFields)
    .map(([{ name, type }, original]) => {
      return `("${name}", ${type.split(' ').join(' <| ')} record.${original.name})`;
    }).join('\n    , ');

  return `
encode${typeName} : ${typeName} -> Json.Encode.Value
encode${typeName} record =
  Json.Encode.object
    [ ${formattedFields}
    ]`;
};

const createUnionTypeDecoder = (string, hasSnakeCase = false) => {
  string = string.replace(/[\n\r]/, '');
  let typeName = getUnionTypeName(string);
  let constructors = getConstructors(string);
  let formattedConstructors = constructors.map(c => {
    return `"${c}" -> Result.Ok ${c}`;
  }).join('\n                ');

  let output = `
decode${typeName} : Json.Decode.Decoder ${typeName}
decode${typeName} = 
  let
    decodeToType string =
      case string of
        ${formattedConstructors}
        _ -> Result.Err ("Not valid pattern for decoder to ${typeName}. Pattern: ${string}
  in
    Json.Decode.customDecoder Json.Decode.string decodeToType

`;

  return output.trim();
};

const createUnionTypeEncoder = (string, hasSnakeCase = false) => {
  string = string.replace(/[\n\r]/, '');
  let typeName = getUnionTypeName(string);
  let constructors = getConstructors(string);
  let formattedConstructors = constructors.map(c => {
    return `${c} -> Json.Encode.string "${c}"`;
  }).join('\n        ');

  let output = `
encode${typeName} : ${typeName} -> Json.Encode.Value
encode${typeName} item =
  case item of
    ${formattedConstructors}

`;

  return output.trim();
};

module.exports = {
  fieldNameAndType,
  makeGuessAtCodec,
  prefixCodec,
  suffixCodec,
  createDecoder,
  createEncoder,
  createUnionTypeDecoder,
  createUnionTypeEncoder
};
