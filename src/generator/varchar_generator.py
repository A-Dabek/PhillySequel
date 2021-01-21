import string
import random

from generator.data_generator import DataGenerator


class VarcharGenerator(DataGenerator):
    def __init__(self, maxsize: str):
        self.maxsize = int(maxsize)

    def generate(self):
        size = random.randint(0, self.maxsize)
        return ''.join(random.choices(string.digits + string.ascii_letters + ' ', k=size))
