import time


def performance(method):
    def timed(*args, **kw):
        ts = time.perf_counter()
        result = method(*args, **kw)
        te = time.perf_counter()
        print(f'{method.__name__}: {(te - ts) * 1000:.3f}')
        return result

    return timed
