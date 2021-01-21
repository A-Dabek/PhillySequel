import re
import string
from typing import List, Optional, Union, KeysView
import random
import uuid


class DataGenerator:
    def generate(self):
        return None


class VarcharGenerator(DataGenerator):
    def __init__(self, maxsize: str):
        self.maxsize = int(maxsize)

    def generate(self):
        size = random.randint(0, self.maxsize)
        return ''.join(random.choices(string.digits + string.ascii_letters + ' ', k=size))


class UUIDGenerator(DataGenerator):
    def __init__(self, args):
        pass

    def generate(self):
        return uuid.uuid4()


class GeneratorFactory:
    def __init__(self):
        self.generators = {
            'varchar': VarcharGenerator,
            'uuid': UUIDGenerator
        }
        pass

    def supported_types(self) -> KeysView[str]:
        return self.generators.keys()

    def create(self, type: str, arg: Optional[int]) -> DataGenerator:
        return self.generators[type](arg)


class Column:
    def __init__(self, name: str, generator: DataGenerator, required):
        self.name = name
        self.generator = generator
        self.required = required
        pass


class Relation:
    def __init__(self, name):
        self.name = name
        self.columns = []
        pass


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
                        column = self.__parse_column_ddl(line.split())
                        if column is not None:
                            columns.append(column)
                            if not line.endswith(',\n'):
                                stage = STAGE_COLUMN_READING
                    elif stage == STAGE_COLUMN_READING:
                        if definition_of_column_end_regex.search(line):
                            stage = STAGE_READING
                line = file.readline()
        return relations

    def __parse_column_ddl(self, ddl: List[str]) -> Optional[Column]:
        if len(ddl) < 2:
            return None

        name_test = re.compile("[a-z0-9_]+", re.IGNORECASE)
        if name_test.match(ddl[0]) is None:
            return None

        type_test = re.compile("([a-z]+)(\(([0-9]+)\))?", re.IGNORECASE)
        type_match = type_test.match(ddl[1])

        if type_match is None:
            return None

        name = ddl[0]
        type = type_match.group(1).lower()
        type_argument = type_match.group(3)

        factory = GeneratorFactory()
        SUPPORTED_TYPES = factory.supported_types()

        if type not in SUPPORTED_TYPES:
            print('UNSUPPORTED', type)
            return None

        data_generator = factory.create(type, type_argument)
        return Column(name, data_generator, False)


parser = FileParser()
relations = parser.parse("data1.sql")
for r in relations:
    print()
    print("relation", r.name)
    for c in r.columns:
        print(c.name, c.generator.generate())
