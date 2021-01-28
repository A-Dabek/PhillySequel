import string
import random
from typing import List

from distribution import DISTRIBUTIONS
from generator.data_generator import DataGenerator


class VarcharGenerator(DataGenerator):
    def __init__(self, args: List):
        self.maxsize = int(args[0])
        self.distribution = DISTRIBUTIONS.get('normal')

    def generate(self):
        sample = self.distribution.sample(1, self.maxsize)
        size = round(abs(sample))
        print(self.maxsize, sample, size)
        return ''.join(random.choices(string.digits + string.ascii_letters + ' ', k=size))
