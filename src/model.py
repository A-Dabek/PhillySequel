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

        # resolve name
        name = ddl_words[0]
        name_match = re.compile("[a-z0-9_]+", re.IGNORECASE).match(name)
        if name_match is None:
            return None

        # resolve type
        type_match = re.compile("([a-z]+)(\\(([0-9,\\s]+)\\))?", re.IGNORECASE) \
            .match(ddl_words[1])
        if type_match is None:
            return None
        column_type = type_match.group(1).lower()
        raw_type_arguments = type_match.group(3)
        type_arguments = raw_type_arguments.split(',') if raw_type_arguments is not None else []

        # resolve foreign key
        reference_match = re.search("references ([a-z0-9_]+)\\s*(\\(([a-z0-9_]+)\\))?", ddl, re.IGNORECASE)
        reference_relation = reference_match.group(1) if reference_match else None
        reference_attribute = reference_match.group(3) if reference_match else None

        required = ddl.find("not null") >= 0
        is_primary_key = ddl.find("primary key") >= 0

        if column_type not in SUPPORTED_TYPES:
            print('UNSUPPORTED', column_type)
            return None

        return Column(name, column_type, type_arguments, required, is_primary_key, reference_relation,
                      reference_attribute)

    def __init__(self, name: str,
                 column_type: str,
                 type_arguments: List[str],
                 required: bool,
                 is_primary_key: bool = False,
                 reference_relation: Optional[str] = None,
                 reference_attribute: Optional[str] = None):
        self.is_primary_key = is_primary_key
        self.name = name
        self.column_type = column_type
        self.type_arguments = type_arguments
        self.required = required
        self.nullability: float = 0
        self.generator: DataGenerator = None
        self.reference_relation = reference_relation
        self.reference_attribute = reference_attribute
        self.reference: Optional[Column] = None


class Relation:
    def __init__(self, name: str):
        self.name = name
        self.columns: dict[str, Column] = dict()
        self.size: int = 1

    @property
    def primary_key(self):
        return next((c for c in self.columns.values() if c.is_primary_key), None)
