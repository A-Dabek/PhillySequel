from datetime import datetime

import numpy

from generator.data_generator import DataGenerator


class TimestampGenerator(DataGenerator):
    def __init__(self, min_date: datetime, max_date: datetime):
        self.min_date = min_date
        self.max_date = max_date

    def generate(self):
        datetime_format = '%Y-%m-%d %H:%M:%S'
        random_factor = abs(numpy.random.normal(loc=0, scale=0.39))
        time_delta = self.max_date - self.min_date
        random_date = (random_factor * time_delta + self.min_date).strftime(datetime_format)
        return f"'{random_date}'"
