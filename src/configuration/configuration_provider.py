from model import Column, Relation
import json

KEY_NULLABILITY = 'nullability'
KEY_SIZE = 'size'


class ConfigurationProvider:
    def __init__(self):
        self.global_configuration = json.load(open('./configuration/config-global.json'))
        self.default_configuration = json.load(open('./configuration/config-default.json'))
        self.custom_configuration = json.load(open('./configuration/config.json'))

    def provide(self, relation: Relation, column: Column) -> dict:
        relation.size = self._resolve_size(relation.name)
        if column.required is False:
            column.nullability = self._resolve_nullability(relation.name, column)
        raw_config = self._config(relation.name, column)
        if column.column_type == 'varchar':
            return self._parse_varchar_config(raw_config)
        return raw_config

    def _resolve_size(self, relation: str) -> float:
        try:
            return self.custom_configuration[relation][KEY_SIZE]
        except KeyError:
            pass
        try:
            return self.global_configuration[KEY_SIZE]
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
