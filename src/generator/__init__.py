from generator.uuid_generator import UUIDGenerator
from generator.varchar_generator import VarcharGenerator

GENERATORS = {
    'varchar': VarcharGenerator,
    'uuid': UUIDGenerator
}

SUPPORTED_TYPES = GENERATORS.keys()
