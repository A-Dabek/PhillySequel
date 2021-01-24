from file_parser import FileParser
from sql_script_builder import SqlScriptBuilder

parser = FileParser()
relations = parser.parse("data1.sql")
builder = SqlScriptBuilder()
builder.generate(relations)
