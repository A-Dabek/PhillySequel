import random

import numpy

from generator.data_generator import DataGenerator


class NumericGenerator(DataGenerator):
    def __init__(self, size=1, precision=0, negatives=True):
        self.size = size
        self.precision = precision
        self.mean = 0
        self.std = 0.39
        self.negatives = negatives

    def generate(self):
        power = (self.size - self.precision) * abs(numpy.random.normal(loc=0, scale=0.39))
        result = 10 ** power
        if self.negatives and random.random() <= 0.5:
            result = -result
        return numpy.format_float_positional(result, precision=self.precision, trim='-')
