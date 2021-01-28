from configuration.configuration_provider import ConfigurationProvider
from file_parser import FileParser
from generator.factory import GeneratorFactory
from sql_script_builder import SqlScriptBuilder

parser = FileParser()
relations = parser.parse("data1.sql")

configuration_provider = ConfigurationProvider()
generator_factory = GeneratorFactory()

for relation in relations:
    for column in relation.columns:
        config = configuration_provider.provide(relation.name, column)
        column.generator = generator_factory.create(column, config)

builder = SqlScriptBuilder()
builder.generate(relations)
