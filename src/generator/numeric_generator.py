import random
import math
from typing import List

from generator.data_generator import DataGenerator


class NumericGenerator(DataGenerator):
    def __init__(self, args: List[str]):
        self.precision = int(args[1])
        self.maxsize = int(args[0])

    def generate(self):
        order_of_magnitude = random.randint(0, self.maxsize)
        return round(random.random() * math.pow(10, order_of_magnitude), self.precision)
