# Parallel Map (pmap) example

# a list of four 1000x1000 matrices
M = Matrix{Float64}[rand(1000,1000) for i=1:4]

# pmap lets us easily call a function in parallel on ten matrices.
# (svd is singular value decomposition)
pmap(svd, M)
