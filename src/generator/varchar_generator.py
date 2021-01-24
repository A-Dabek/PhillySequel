import string
import random
from typing import List

from generator.data_generator import DataGenerator


class VarcharGenerator(DataGenerator):
    def __init__(self, args: List):
        self.maxsize = int(args[0])

    def generate(self):
        size = random.randint(0, self.maxsize)
        return ''.join(random.choices(string.digits + string.ascii_letters + ' ', k=size))
