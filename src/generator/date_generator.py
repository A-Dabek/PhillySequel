import random
import datetime

from generator.data_generator import DataGenerator


class DateGenerator(DataGenerator):
    def __init__(self, args):
        pass

    def generate(self):
        return self.randomtimes('1900-01-01', '3000-01-01')

    def randomtimes(self, start, end):
        frmt = '%Y-%m-%d'
        stime = datetime.datetime.strptime(start, frmt)
        etime = datetime.datetime.strptime(end, frmt)
        time_delta = etime - stime
        random_date = (random.random() * time_delta + stime).strftime(frmt)
        return f"'{random_date}'"
