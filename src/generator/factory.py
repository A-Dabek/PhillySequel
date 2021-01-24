from typing import List

from generator import GENERATORS
from generator.data_generator import DataGenerator


class GeneratorFactory:

    def create(self, type: str, args: List[str]) -> DataGenerator:
        return GENERATORS[type](args)
