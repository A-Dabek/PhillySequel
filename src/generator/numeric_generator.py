import random

import numpy
from generator.data_generator import DataGenerator


class NumericGenerator(DataGenerator):
    def __init__(self, size=1, max_size=None, precision=0, max_precision=None, negatives=True):
        self.maxsize = max_size if max_size else size
        self.precision = precision
        self.negatives = negatives

    def generate(self):
        power = (self.maxsize - self.precision) * abs(numpy.random.normal(loc=0, scale=0.39))
        result = 10 ** power
        if self.negatives and random.random() <= 0.5:
            result = -result
        return numpy.format_float_positional(result, precision=self.precision, trim='-')
