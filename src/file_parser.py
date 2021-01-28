import re
from typing import List

from model import Relation, Column


class FileParser:
    def parse(self, filepath: str) -> List[Relation]:
        relations = []
        definition_start_regex = re.compile("create table ([a-z0-9_]+)", re.IGNORECASE)
        definition_end_regex = re.compile("\);")
        definition_of_column_end_regex = re.compile(",\s+")
        stage = 0
        STAGE_SEARCHING = 0
        STAGE_READING = 1
        STAGE_COLUMN_READING = 2
        columns = []

        with open(filepath, "r") as file:
            line = file.readline()
            while line:
                if stage == STAGE_SEARCHING:
                    match = definition_start_regex.match(line)
                    if match is not None:
                        r = Relation(match.group(1))
                        relations.append(r)
                        stage = STAGE_READING
                else:
                    if definition_end_regex.search(line) is not None:
                        relations[-1].columns = columns
                        columns = []
                        stage = STAGE_SEARCHING
                    if stage == STAGE_READING:
                        column = Column.parse(line.replace(', ', ','))
                        if column is not None:
                            columns.append(column)
                            if not line.endswith(',\n'):
                                stage = STAGE_COLUMN_READING
                    elif stage == STAGE_COLUMN_READING:
                        if definition_of_column_end_regex.search(line):
                            stage = STAGE_READING
                line = file.readline()
        return relations
