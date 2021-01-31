import re
from typing import List

from model import Relation, Column


def get_table_name(tokens):
    for token in reversed(tokens):
        if token.ttype is None:
            return token.value
    return " "


class FileParser:
    def __init__(self):
        self.relations_index: dict[str, Relation] = dict()

    def parse(self, filepath: str) -> List[Relation]:
        relations = []
        definition_start_regex = re.compile("create table ([a-z0-9_]+)", re.IGNORECASE)
        definition_end_regex = re.compile("\);")
        stage = 0
        STAGE_SEARCHING = 0
        STAGE_READING = 1

        attribute_lines = []
        with open(filepath, "r") as file:
            line = file.readline()
            while line:
                if stage == STAGE_SEARCHING:
                    match = definition_start_regex.match(line)
                    if match is not None:
                        r = Relation(match.group(1))
                        relations.append(r)
                        stage = STAGE_READING
                        file.readline()
                        self.relations_index[r.name] = r
                else:
                    if definition_end_regex.search(line) is not None:
                        ddl_lines = re.split(',\n', ''.join(attribute_lines).replace(', ', ','))
                        columns_list = list(filter(lambda x: x is not None, map(lambda x: Column.parse(x), ddl_lines)))
                        self._resolve_foreign_keys(columns_list)
                        columns_dict = {c.name: c for c in columns_list}
                        relations[-1].columns = columns_dict
                        stage = STAGE_SEARCHING
                        continue
                    attribute_lines.append(line)
                line = file.readline()
        return relations

    def _resolve_foreign_keys(self, columns: List[Column]):
        for c in filter(lambda c: c.reference_relation is not None, columns):
            relation = self.relations_index.get(c.reference_relation)
            if relation is None:
                return
            if c.reference_attribute is None:
                c.reference = relation.primary_key
            else:
                c.reference = relation.columns.get(c.reference_attribute)
