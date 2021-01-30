from model import Column, Relation


class ConfigurationProvider:
    def __init__(self):
        self.key_nullability = 'nullability'
        self.key_size = 'size'
        self.global_configuration = {
            self.key_nullability: 0.5,
            self.key_size: 2,
        }
        self.default_configuration = {
            'boolean': {
                'odds': 0.5
            },
        }
        self.custom_configuration = {
            'financial_loss_risk': {
                'size': 3,
                'isActive': {
                    'odds': 0.6
                },
            }
        }

    def provide(self, relation: Relation, column: Column) -> dict:
        relation.size = self._resolve_size(relation.name)
        if column.required is False:
            column.nullability = self._resolve_nullability(relation.name, column)
        return self._config(relation.name, column)

    def _resolve_size(self, relation: str) -> float:
        try:
            return self.custom_configuration[relation][self.key_size]
        except KeyError:
            pass
        try:
            return self.global_configuration[self.key_size]
        except KeyError:
            return 1

    def _resolve_nullability(self, relation: str, column: Column) -> float:
        try:
            return self.custom_configuration[relation][column.name][self.key_nullability]
        except KeyError:
            pass
        try:
            return self.default_configuration['boolean'][self.key_nullability]
        except KeyError:
            pass
        try:
            return self.global_configuration[self.key_nullability]
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
