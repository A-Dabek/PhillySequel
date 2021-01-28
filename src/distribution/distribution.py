import math
import random
import scipy.stats


class Distribution:
    def sample(self, min: int, max: int):
        return min


class NormalDistribution:
    def _get_truncated_normal(self, mean=0, sd=1.0, low=0, upp=10):
        return scipy.stats.truncnorm((low - mean) / sd, (upp - mean) / sd, loc=mean, scale=sd).rvs()

    def sample(self, min: int, max: int):
        return self._get_truncated_normal(low=min, upp=max, sd=math.sqrt(max-min))


class IntegerDistribution:
    def sample(self, min: int, max: int):
        return random.randint(min, max)


class UniformDistribution:
    def sample(self, min: int, max: int):
        return random.random() * (max - min) + min
