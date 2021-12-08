lines = readlines("input.txt")
re = r"(\w+)"

function main()
    #=
    Solve using frequency analysis (i.e.: for digits 0 to 9, we see segment 'a' 8 times)
    For 1: we need c and f, i.e. 8 + 9 = 17. for 7, a + c + f = 8 + 8 + 9 = 25
    This works, because the distribution for the number of times each segment lights
    up for digits 0 to 9 is unique
    =#
    segmentmap = Dict(
        0 => collect("abcefg"),
        1 => collect("cf"),
        2 => collect("acdeg"),
        3 => collect("acdfg"),
        4 => collect("bcdf"),
        5 => collect("abdfg"),
        6 => collect("abdefg"),
        7 => collect("acf"),
        8 => collect("abcdefg"),
        9 => collect("abcdfg")
    )
    freq = X -> Dict([(x, count(==(x), X)) for x = unique(X)])
    X = freq(reduce(vcat, values(segmentmap)))
    numbers = Dict([(i,sum([X[c] for c = set])) for (i,set) = pairs(segmentmap)])
    inverse = Dict(value => key for (key, value) = numbers)
    sumdigits = N -> sum(n * 10^e for (n,e) = zip(N, length(N)-1:-1:0))
    
    Σ = 0
    for line = lines
        input, output = split(line, '|')
        signals = [m.match for m = eachmatch(re, input)]
        X = freq(reduce(vcat, collect.(signals)))

        Y = [m.match for m = eachmatch(re, output)]
        Σ_Y = map(s -> sum([X[c] for c = collect(s)]), Y)
        N = map(n -> inverse[n], Σ_Y)
        Σ += sumdigits(N)
        println(sumdigits(N))
    end
    println("====")
    println(Σ)
end

main()
