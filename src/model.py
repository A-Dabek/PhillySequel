from generator.data_generator import DataGenerator


class Column:
    def __init__(self, name: str, generator: DataGenerator, required):
        self.name = name
        self.generator = generator
        self.required = required


class Relation:
    def __init__(self, name):
        self.name = name
        self.columns = []
