start,rules = split(read("input.txt", String), "\n\n")
re = r"(\w+) -> (\w)"
rules = Dict(k => v for (k,v) = ([match(re, rule) for rule = eachline(IOBuffer(rules))]))
freq(X) = Dict([(x, count(==(x), X)) for x = unique(X)])
repeatf(f, x, n) = n > 1 ? f(repeatf(f, x, n-1)) : f(x)
reaction(str,c) = str * (haskey(rules, string(str[end], c)) ? rules[string(str[end], c)] : "") * c

str = repeatf(s -> foldl(reaction, s), start, 10)
elements = sort(collect(freq(str)), by=x->x[2])
println(last(elements).second - first(elements).second)
