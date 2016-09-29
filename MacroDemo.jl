# parse a string into a julia expression
ex = parse("(4 + 4) / 2")

# display it as an s-expression! cool!
Meta.show_sexpr(ex)

println()

# colons do quoting. just like lisp!
ex = :(a+b*c+1)
Meta.show_sexpr(ex)

println()

# Macros are fundamentally different: they let you execute code at *parse* time!
macro twostep(arg)
    println("I execute at parse time. The argument is: ", arg)

    return :(println("I execute at runtime. The argument is: ", $arg))
end

# now do:
# ex = macroexpand( :(@twostep :(1, 2, 3)) );
# ex
# eval(ex)
