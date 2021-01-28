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
            }
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
        if column.column_type == 'boolean':
            return self._config(relation, column)

    def _resolve_nullability(self, relation: str, column: Column):
        try:
            return self.custom_configuration.get(relation).get(column.name)
        except AttributeError:
            pass
        try:
            return self.default_configuration.get('boolean')[self.nullability_key]
        except AttributeError:
            pass
        try:
            return self.global_configuration.get(self.nullability_key)
        except AttributeError:
            return 0

    def _config(self, relation: str, column: Column):
        custom_config = self.custom_configuration.get(relation, dict()).get(column.name, dict())
        return self.default_configuration.get(column.column_type) | custom_config
