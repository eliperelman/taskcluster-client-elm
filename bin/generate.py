from __future__ import print_function, unicode_literals

import json
import sys

from type_alias import create_type_alias, find_type_aliases, find_union_types
from decoder import create_decoder, create_encoder, create_union_type_decoder, create_union_type_encoder
from helpers import *

def print_everything(some_json, alias_name):
    stuff = json.loads(some_json)
    aliases = create_type_alias(stuff, type_alias_name=alias_name)
    decoders = [ create_decoder(alias, has_snakecase=True, prefix='decode') for alias in aliases ]
    encoders = [ create_encoder(alias, has_snakecase=True, prefix='encode') for alias in aliases ]

    print('import Json.Decode')
    print('import Json.Encode')
    print('\n'.join(aliases))
    print('\n'.join(decoders))
    print('\n'.join(encoders))

def main():
    for arg in sys.argv[1:]:
        if arg.endswith('.json'):
            with open(arg) as f:
                arg = arg.split('/')[-1]
                name = arg.split('.')[0]
                print_everything(f.read(), name)

if __name__ == '__main__':
    main()
