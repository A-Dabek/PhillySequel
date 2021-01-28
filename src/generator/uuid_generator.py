import uuid

from generator.data_generator import DataGenerator


class UUIDGenerator(DataGenerator):

    def generate(self):
        return uuid.uuid4()
