import warnings

import scipy.ndimage
import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset

from util import timeit

np.seterr('ignore')
warnings.filterwarnings('ignore')


def get_var(filename, name):
    root = Dataset(filename, 'r')
    return root.variables[name]


@timeit
def convolve_slow(image, kernel):
    result = image.copy()
    d = image
    for i in range(d.shape[0]):
        for j in range(d.shape[1]):
            try:
                cur = np.array(
                        [ [d[i-1, j-1], d[i, j-1], d[i+1, j-1]],
                          [d[i-1,   j], d[i,   j], d[i+1,   j]],
                          [d[i-1, j+1], d[i, j+1], d[i+1, j+1]],
                        ])
                result[i, j] = (cur * kernel).sum()
            except IndexError:
                pass # skip boundaries

    return result


@timeit
def convolve_fast(image, kernel):
    return scipy.ndimage.convolve(image, kernel)


def main():
    filename = './data/patmosx_v05r03-preliminary_NOAA-19_asc_d20150929_c20151003.nc'
    data = get_var(filename, 'temp_11_0um_nom')[0] # 1st time step

    data = data[::-1, :]  # put north on top of image result

    edge_kernel = np.array([ [-1., -1., -1.],
                             [-1.,  8., -1.],
                             [-1., -1., -1.],
                           ])

    blur_kernel = np.ones((3, 3)) * (1. / 9.)

    convolved_fast = convolve_fast(data[::4, ::4], blur_kernel)
    
    # slow implementation is so slow we only do every 4th point!
    convolved_slow = convolve_slow(data[::4, ::4], blur_kernel)

    cmap = "gray_r"
    plt.imshow(data, cmap=cmap, vmin=180, vmax=320)
    plt.savefig('python_img.png')

    plt.imshow(convolved_slow, cmap=cmap, vmin=180, vmax=320)
    plt.savefig('python_img_convolved_slow.png')

    plt.imshow(convolved_fast, cmap=cmap, vmin=180, vmax=320)
    plt.savefig('python_img_convolved_fast.png')


if __name__ == '__main__':
    main()
