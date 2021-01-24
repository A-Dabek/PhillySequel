from generator.date_generator import DateGenerator
from generator.numeric_generator import NumericGenerator
from generator.uuid_generator import UUIDGenerator
from generator.varchar_generator import VarcharGenerator

GENERATORS = {
    'varchar': VarcharGenerator,
    'uuid': UUIDGenerator,
    'numeric': NumericGenerator,
    'date': DateGenerator
}

SUPPORTED_TYPES = GENERATORS.keys()
