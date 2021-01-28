import random

from generator.data_generator import DataGenerator


class BooleanGenerator(DataGenerator):
    def __init__(self, odds=0.5):
        self.odds = odds

    def generate(self):
        return 'true' if random.random() < self.odds else 'false'
