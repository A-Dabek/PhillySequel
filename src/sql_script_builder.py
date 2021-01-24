import functools
from typing import List

from model import Relation


class SqlScriptBuilder:

    def generate(self, relations: List[Relation], **kwargs):
        for r in relations:
            column_names = functools.reduce(self._concat, map(lambda x: x.name, r.columns))
            insert_clause = f'insert into {r.name} ({column_names}) values'
            generators = map(lambda x: x.generator.generate(), r.columns)
            for i in range(0, kwargs.get('size', 1)):
                column_values = functools.reduce(self._concat, generators)
                print(f'{insert_clause} ({column_values})')

    def _concat(self, x, y):
        return f'{x}, {y}'
