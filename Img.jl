using NetCDF
using PyPlot
using Images

function convolve_slow(image, kernel)
    result = copy(image)
    d = image
    for i = 2:size(d, 1) - 1
        for j = 2:size(d, 2) - 1
            cur = [ d[i-1, j-1] d[i, j-1] d[i+1, j-1];
                    d[i-1,   j] d[i,   j] d[i+1,   j];
                    d[i-1, j+1] d[i, j+1] d[i+1, j+1]
                  ]
            result[i, j] = sum(cur .* kernel)
        end
    end
    result
end

function convolve_fast(image, kernel)
    # just use the Tim Holy library function
    imfilter(image, kernel)
end

function run_img()
    filename = "./data/patmosx_v05r03-preliminary_NOAA-19_asc_d20150929_c20151003.nc"
    data = ncread(filename, "temp_11_0um_nom")
    data = data[:, :, 1] # first time step
    data = flipdim(data', 1) # orient things to get north-up on image
    data = data[1:4:end, 1:4:end] # every 4th element
    # Avoid InexactError's when converting large Float32 to Int16:
    data = convert(Array{Float32,2}, data)

    blur_kernel = ones(Float32, 3, 3)/9.0

    println("Running convolved_fast")
    @time convolved_fast = convolve_fast(data, blur_kernel)
    println("Running convolved_slow")
    @time convolved_slow = convolve_slow(data, blur_kernel)

    cmap = "gray_r"
    imshow(data, cmap=cmap)
    savefig("julia_img.png")

    imshow(convolved_slow, cmap=cmap)
    savefig("julia_img_convolved_slow.png")

    imshow(convolved_fast, cmap=cmap)
    savefig("julia_img_convolved_fast.png")
end
