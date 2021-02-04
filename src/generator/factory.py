from typing import List

from generator import GENERATORS
from generator.data_generator import DataGenerator
from model import Column


class GeneratorFactory:
    def create(self, column: Column, configuration: dict) -> DataGenerator:
        sql_configuration = self._parse_type_arguments(column.column_type, column.type_arguments) \
            if len(column.type_arguments) > 0 \
            else dict()
        return GENERATORS[column.column_type](**(sql_configuration | configuration))

    def _parse_type_arguments(self, column_type: str, type_arguments: List[str]) -> dict:
        if column_type in ['varchar', 'char']:
            return {
                'size': int(type_arguments[0])
            }
        if column_type == 'numeric':
            return {
                'size': int(type_arguments[0]),
                'precision': int(type_arguments[1])
            }
        return {}
