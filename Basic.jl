size = 1000000

aa = linspace(0.0, 1.0, size)
bb = linspace(0.0, 1.0, size)

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
