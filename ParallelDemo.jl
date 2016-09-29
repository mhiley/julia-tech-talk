# adapted from julia docs
# http://docs.julialang.org/en/release-0.5/manual/parallel-computing/

# invoke like this:
# time julia -p 4 ParallelDemo.jl

@everywhere include("count_heads.jl")

n = 100000000
a = @spawn count_heads(n)
b = @spawn count_heads(n)
c = @spawn count_heads(n)
d = @spawn count_heads(n)
println("Percent heads: ", (fetch(a)+fetch(b)+fetch(c)+fetch(d)) / (n*4.))
