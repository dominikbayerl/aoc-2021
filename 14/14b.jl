start,rules = split(read("input.txt", String), "\n\n")
re = r"(\w+) -> (\w)"
rules = Dict(k => v for (k,v) = ([match(re, rule) for rule = eachline(IOBuffer(rules))]))
freq(X) = Dict([(x, count(==(x), X)) for x = unique(X)])
ngram(s::AbstractString,n) = [SubString(s,i:i+n-1) for i=1:length(s)-n+1]
reactionmap = 

counts = Dict(keys(rules) .=> 0)
[counts[xx] += 1 for xx = ngram(start,2)]
for _ = 1:40
    next = Dict(keys(counts) .=> 0)
    for (k,v) = counts
        next[string(first(k), rules[k])] += v
        next[string(rules[k], last(k))] += v
    end
    global counts = next
end

# Aggregate
elements = Dict([first(k) => 0 for k = unique(values(rules))])
for (k,v) = counts
    elements[first(k)] += v
    elements[last(k)] += v
end
elements = Dict([k => v ÷ 2 for (k,v) = elements])
elements[first(start)] += 1
elements[last(start)] += 1
elements = sort(collect(elements), by=last)
println(last(elements).second - first(elements).second)
