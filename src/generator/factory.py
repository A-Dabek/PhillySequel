from typing import List

from generator import GENERATORS
from generator.data_generator import DataGenerator
from model import Column


class GeneratorFactory:
    def create(self, column: Column, configuration: dict) -> DataGenerator:
        sql_configuration = self._parse_type_arguments(column.type, column.type_arguments) \
            if len(column.type_arguments) > 0 \
            else dict()
        return GENERATORS[column.type](**(sql_configuration | configuration))

    def _parse_type_arguments(self, type: str, type_arguments: List[str]) -> dict:
        if type in ['varchar', 'char']:
            return {
                'size': type_arguments[0]
            }
        if type == 'numeric':
            return {
                'size': type_arguments[0],
                'precision': type_arguments[1]
            }
        return {}
