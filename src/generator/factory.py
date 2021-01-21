from typing import Optional

from generator import GENERATORS
from generator.data_generator import DataGenerator


class GeneratorFactory:

    def create(self, type: str, arg: Optional[int]) -> DataGenerator:
        return GENERATORS[type](arg)
