# don't forget to restart repl to show JIT warm up!
function array_sum_slow(a)
    total = 0
    for i = 1:length(a)
        total += a[i]
    end
    total
end

function array_sum_fast(a)
    sum(a)
end

function array_add_slow(a, b)
    result = copy(a)
    for i = 1:length(a)
        result = a[i] + b[i]
    end
    result
end

function array_add_fast(a, b)
    a + b
end

function run_basic()
    n = 1000000

    # Don't use linspace .. lazy computation will result in zeroed times
    #aa = linspace(0.0, 1.0, n)
    #bb = linspace(0.0, 1.0, n)

    aa = zeros(n)
    bb = zeros(n)
    for i = 1:n
        aa[i] = 1.0 / n
        bb[i] = 2.0 / n
    end

    println("Running array_sum_slow")
    @time array_sum_slow(aa)

    println("Running array_sum_fast")
    @time array_sum_fast(aa)

    println("Running array_add_slow")
    @time array_add_slow(aa, bb)

    println("Running array_add_fast")
    @time array_add_fast(aa, bb)
end
