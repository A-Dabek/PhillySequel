import functools
from typing import List

from generator.data_generator import DataGenerator
from generator.nullable_generator import NullableGenerator
from model import Relation, Column


class SqlScriptBuilder:

    def generate(self, relations: List[Relation]):
        for r in relations:
            column_names = functools.reduce(self._concat, map(lambda x: x.name, r.columns.values()))
            insert_clause = f'insert into {r.name} ({column_names}) values'
            generators = list(map(self._get_generator, r.columns.values()))
            for i in range(0, r.count):
                column_values = functools.reduce(self._concat, map(lambda g: g.generate(), generators))
                print(f'{insert_clause} ({column_values});')

    def _concat(self, x: str, y: str) -> str:
        return f'{x}, {y}'

    def _get_generator(self, c: Column) -> DataGenerator:
        return c.generator if c.required else NullableGenerator(c.nullability, c.generator)
