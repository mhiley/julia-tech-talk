import numpy

# declare arrays w/ a million elements each
a = numpy.linspace(0.0, 1.0, 1000000)
b = numpy.linspace(1.0, 2.0, 1000000)

# sum elements of array
total = 0
for i in range(len(a)):
    total += a[i]

# add arrays together
added = []
for i in range(len(a)):
    added.append(a[i] + b[i])



# declare arrays w/ a million elements each
a = numpy.linspace(0.0, 1.0, 1000000)
b = numpy.linspace(1.0, 2.0, 1000000)

# sum elements of array
total = a.sum()



# add arrays together
added  = a + b




