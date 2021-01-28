from model import Column


class ConfigurationProvider:
    def __init__(self):
        self.nullability_key = 'nullability'
        self.global_configuration = {
            self.nullability_key: 0.5
        }
        self.default_configuration = {
            'boolean': {
                'odds': 0.5
            },
        }
        self.custom_configuration = {
            'financial_loss_risk': {
                'isActive': {
                    'odds': 0.6
                }
            }
        }

    def provide(self, relation: str, column: Column) -> dict:
        if column.required is False:
            column.nullability = self._resolve_nullability(relation, column)
        return self._config(relation, column)

    def _resolve_nullability(self, relation: str, column: Column) -> float:
        try:
            return self.custom_configuration[relation][column.name][self.nullability_key]
        except KeyError:
            pass
        try:
            return self.default_configuration['boolean'][self.nullability_key]
        except KeyError:
            pass
        try:
            return self.global_configuration[self.nullability_key]
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
