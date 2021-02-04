import json
from datetime import datetime
from typing import Optional

from model import Column, Relation

KEY_NULLABILITY = 'nullability'
KEY_COUNT = 'count'


class ConfigurationProvider:
    def __init__(self):
        self.global_configuration = json.load(open('./configuration/config-global.json'))
        self.default_configuration = json.load(open('./configuration/config-default.json'))
        self.custom_configuration = json.load(open('./configuration/config.json'))

    def provide(self, relation: Relation, column: Column) -> dict:
        relation.count = self._resolve_count(relation.name)
        if column.required is False:
            column.nullability = self._resolve_nullability(relation.name, column)
        raw_config = self._config(relation.name, column)
        if column.column_type == 'varchar':
            return self._parse_varchar_config(raw_config)
        if column.column_type == 'date':
            return self._parse_date_config(raw_config)
        return raw_config

    def _resolve_count(self, relation: str) -> int:
        try:
            return self.custom_configuration[relation][KEY_COUNT]
        except KeyError:
            pass
        try:
            return self.global_configuration[KEY_COUNT]
        except KeyError:
            return 1

    def _resolve_nullability(self, relation: str, column: Column) -> float:
        try:
            return self.custom_configuration[relation][column.name][KEY_NULLABILITY]
        except KeyError:
            pass
        try:
            return self.default_configuration['boolean'][KEY_NULLABILITY]
        except KeyError:
            pass
        try:
            return self.global_configuration[KEY_NULLABILITY]
        except KeyError:
            return 0

    def _config(self, relation: str, column: Column) -> dict:
        try:
            custom_config = self.custom_configuration[relation][column.name]
        except KeyError:
            custom_config = dict()
        try:
            return self.default_configuration[column.column_type] | custom_config
        except KeyError:
            return custom_config

    def _parse_varchar_config(self, config: dict) -> dict:
        return {**config, 'word_bank': self._resolve_word_bank(config.get('word_bank'))}

    def _resolve_word_bank(self, word_bank_name: str) -> list:
        words = []
        with open(f'./dictionaries/{word_bank_name}.txt', 'r') as file:
            line = file.readline()
            while line:
                words.append(line.rstrip('\n'))
                line = file.readline()
        return words

    def _parse_date_config(self, config: dict) -> dict:
        config = {
            'min_date': self._resolve_min_date(config.get('min_date'), config.get('past')),
            'max_date': self._resolve_max_date(config.get('max_date'), config.get('future')),
        }
        return config

    def _resolve_min_date(self, min_date: Optional[str], past: bool) -> datetime:
        date_format = '%Y-%m-%d'
        today = datetime.today()
        century_before = today.replace(year=today.year - 100)
        if past:
            if min_date:
                minimum = datetime.strptime(min_date, date_format)
                return min(minimum, today)
            else:
                return century_before
        else:
            return today

    def _resolve_max_date(self, max_date: Optional[str], future: bool) -> datetime:
        date_format = '%Y-%m-%d'
        today = datetime.today()
        century_after = today.replace(year=today.year + 100)
        if future:
            if max_date:
                maximum = datetime.strptime(max_date, date_format)
                return max(maximum, today)
            else:
                return century_after
        else:
            return today
