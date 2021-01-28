import re
from typing import List, Optional

from generator import SUPPORTED_TYPES


class Column:
    @staticmethod
    def parse(ddl: List[str]) -> Optional['Column']:
        if len(ddl) < 2:
            return None

        name_test = re.compile("[a-z0-9_]+", re.IGNORECASE)
        if name_test.match(ddl[0]) is None:
            return None

        type_test = re.compile("([a-z]+)(\(([0-9,\s]+)\))?", re.IGNORECASE)
        type_match = type_test.match(ddl[1])

        if type_match is None:
            return None

        name = ddl[0]
        type = type_match.group(1).lower()
        raw_type_arguments = type_match.group(3)
        type_arguments = raw_type_arguments.split(',') if raw_type_arguments is not None else []

        if type not in SUPPORTED_TYPES:
            print('UNSUPPORTED', type)
            return None

        return Column(name, type, type_arguments, False)

    def __init__(self, name: str, type: str, type_arguments: List[str], required: bool):
        self.name = name
        self.type = type
        self.type_arguments = type_arguments
        self.required = required
        self.nullability = 0


class Relation:
    def __init__(self, name):
        self.name = name
        self.columns = []
