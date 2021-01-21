import re
import string
from typing import List, Optional, Union, KeysView
import random
import uuid

INPUT_DATA = """
alter table
create table client_details
(
	type varchar(31) not null,
	id uuid not null
		constraint client_details_pkey
			primary key,
	cif varchar(255),
	krs varchar(255),
	name varchar(255),
	nip varchar(255),
	pesel varchar(255),
	regon varchar(255),
	surname varchar(255),
	attorney varchar(255)
);
add index
"""

single_table_definition = INPUT_DATA


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


def process_input_file(ddl: str):
    ddl_lines = ddl.splitlines()
    relations = []
    table_name_regex = re.compile("create table ([a-z0-9_]+)", re.IGNORECASE)
    columns = []

    for line in ddl_lines:
        match = table_name_regex.match(line)
        if match is not None:
            relations.append(Relation(match.group(0)))
        if len(relations) > 0:
            column = parse_column_dd(line.split())
            if column is not None:
                columns.append(column)
    relations[-1].columns = columns
    return relations


def parse_column_dd(ddl: List[str]) -> Optional[Column]:
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
        return None

    data_generator = factory.create(type, type_argument)
    return Column(name, data_generator, False)


relations = process_input_file(INPUT_DATA)
for r in relations:
    for c in r.columns:
        print(c.name, c.generator.generate())
