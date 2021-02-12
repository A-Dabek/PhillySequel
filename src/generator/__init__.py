from generator.boolean_generator import BooleanGenerator
from generator.date_generator import DateGenerator
from generator.numeric_generator import NumericGenerator
from generator.timestamp_generator import TimestampGenerator
from generator.uuid_generator import UUIDGenerator
from generator.varchar_generator import VarcharGenerator

GENERATORS = {
    'boolean': BooleanGenerator,
    'uuid': UUIDGenerator,
    'numeric': NumericGenerator,
    'smallint': NumericGenerator,
    'bigint': NumericGenerator,
    'varchar': VarcharGenerator,
    'date': DateGenerator,
    'timestamp': TimestampGenerator,
}

SUPPORTED_TYPES = GENERATORS.keys()
