from generator.boolean_generator import BooleanGenerator
from generator.date_generator import DateGenerator
from generator.numeric_generator import NumericGenerator
from generator.uuid_generator import UUIDGenerator
from generator.varchar_generator import VarcharGenerator

GENERATORS = {
    'boolean': BooleanGenerator,
    'uuid': UUIDGenerator,
    'numeric': NumericGenerator,
    # 'varchar': VarcharGenerator,
    # 'date': DateGenerator,
}

SUPPORTED_TYPES = GENERATORS.keys()
