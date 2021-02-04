import random

from generator.data_generator import DataGenerator


class VarcharGenerator(DataGenerator):
    def __init__(self, word_bank: list, size=1, max_size=None, max_word_count=None):
        self.maxsize = max_size if max_size else size
        self.word_bank = word_bank
        self.max_word_count = max_word_count

    def generate(self):
        words = []
        remaining_size = self.maxsize
        while remaining_size > 0:
            index = random.randint(0, len(self.word_bank) - 1)
            new_word = self.word_bank[index]
            new_word_len = len(new_word)
            if new_word_len <= remaining_size:
                words.append(new_word)
                remaining_size -= new_word_len
                if len(words) == self.max_word_count:
                    break
            if len(words) > 0 and random.random() > 0.75:
                break
        return f"'{' '.join(words)}'"
