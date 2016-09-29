import time

# https://www.andreas-jung.com/contents/a-python-decorator-for-measuring-the-execution-time-of-methods
def timeit(method):

    def timed(*args, **kw):
        ts = time.time()
        result = method(*args, **kw)
        te = time.time()

        print 'Running %s :\n  %.4f sec' % \
              (method.__name__, te-ts)
        return result

    return timed
