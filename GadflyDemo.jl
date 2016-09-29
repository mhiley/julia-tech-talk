using Gadfly, RDatasets

# simple line plot
#x = linspace(0., 2.0*pi, 1000)
#plot(layer(x=x, y=sin(x), Geom.line),
#     layer(x=x, y=cos(x), Geom.line), Guide.title("waves"))


# Histogram
#plot(dataset("car", "SLID"), x="Wages", color="Language", Geom.histogram)


# contours and color bar
volcano = float(convert(Array, dataset("datasets", "volcano")))
plot(z=volcano, Geom.contour, Guide.colorkey("Elevation"))
