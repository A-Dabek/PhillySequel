import random

from generator.data_generator import DataGenerator


class NullableGenerator(DataGenerator):
    def __init__(self, odds: float, generator: DataGenerator):
        self.odds = odds
        self.generator = generator

    def generate(self):
        return 'null' \
            if random.random() < self.odds \
            else self.generator.generate()
