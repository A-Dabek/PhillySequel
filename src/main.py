from typing import List

from configuration.configuration_provider import ConfigurationProvider
from file_parser import FileParser
from generator.factory import GeneratorFactory
from model import Relation
from performance import performance
from sql_script_builder import SqlScriptBuilder

parser = FileParser()
configuration_provider = ConfigurationProvider()
generator_factory = GeneratorFactory()
builder = SqlScriptBuilder()


@performance
def parse(filepath: str) -> List[Relation]:
    return parser.parse(filepath)


@performance
def configure(relations: List[Relation]):
    for relation in relations:
        for column in relation.columns.values():
            config = configuration_provider.provide(relation, column)
            column.generator = generator_factory.create(column, config)


@performance
def generate(relations: List[Relation]):
    builder.generate(relations)


relations = parse("data1.sql")
configure(relations)
generate(relations)
