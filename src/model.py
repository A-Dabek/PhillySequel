import re
from typing import List, Optional

from generator import SUPPORTED_TYPES
from generator.data_generator import DataGenerator


class Column:
    @staticmethod
    def parse(ddl: str) -> Optional['Column']:

        ddl_words = ddl.split()
        if len(ddl_words) < 2:
            return None

        name_test = re.compile("[a-z0-9_]+", re.IGNORECASE)
        if name_test.match(ddl_words[0]) is None:
            return None

        type_test = re.compile("([a-z]+)(\(([0-9,\s]+)\))?", re.IGNORECASE)
        type_match = type_test.match(ddl_words[1])

        if type_match is None:
            return None

        name = ddl_words[0]
        required = ddl.find("not null") >= 0
        column_type = type_match.group(1).lower()
        raw_type_arguments = type_match.group(3)
        type_arguments = raw_type_arguments.split(',') if raw_type_arguments is not None else []

        if column_type not in SUPPORTED_TYPES:
            print('UNSUPPORTED', column_type)
            return None

        return Column(name, column_type, type_arguments, required)

    def __init__(self, name: str, column_type: str, type_arguments: List[str], required: bool):
        self.name = name
        self.column_type = column_type
        self.type_arguments = type_arguments
        self.required = required
        self.nullability: float = 0
        self.generator: DataGenerator = None


class Relation:
    def __init__(self, name: str):
        self.name = name
        self.columns: List[Column] = []
        self.size: int = 1
