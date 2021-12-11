lines = readlines("input.txt")

function main()
    pairs = Dict('(' => ')', '[' => ']', '{' => '}', '<' => '>')
    revpairs = Dict(v => k for (k,v) = pairs)
    penalties = Dict(')' => 1, ']' => 2, '}' => 3, '>' => 4)
    Σs = []
    for line = lines
        Σ = 0
        stack = []
        for char = collect(line)
            if char in ['(', '[', '{', '<']
                pushfirst!(stack, char)
            else
                if popfirst!(stack) != revpairs[char]
                    stack = []
                    break
                end
            end
        end
        if length(stack) > 0
            for char = stack
                Σ = Σ * 5 + penalties[pairs[char]]
            end
            append!(Σs, Σ)
        end
    end
    println(sort(Σs)[1+length(Σs)÷2])
end

main()