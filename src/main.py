from file_parser import FileParser

parser = FileParser()
relations = parser.parse("data1.sql")
for r in relations:
    print()
    print("relation", r.name)
    for c in r.columns:
        print(c.name, c.generator.generate())
