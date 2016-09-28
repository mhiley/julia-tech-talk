import numpy

from util import timeit

@timeit
def array_sum_slow(a):
    total = 0
    for i in range(len(a)):
        total += a[i]
    return total


@timeit
def array_add_slow(a, b):
    added = []
    for i in range(len(a)):
        added.append(a[i] + b[i])
    return added


@timeit
def array_sum_fast(a):
    return a.sum()


@timeit
def array_add_fast(a, b):
    return a + b


if __name__ == '__main__':

    # declare arrays w/ a million elements each
    aa = numpy.linspace(0.0, 1.0, 1000000)
    bb = numpy.linspace(1.0, 2.0, 1000000)

    array_sum_slow(aa)
    array_add_slow(aa, bb)

    array_sum_fast(aa)
    array_add_fast(aa, bb)
