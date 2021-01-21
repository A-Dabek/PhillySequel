import uuid

from generator.data_generator import DataGenerator


class UUIDGenerator(DataGenerator):
    def __init__(self, args):
        pass

    def generate(self):
        return uuid.uuid4()
