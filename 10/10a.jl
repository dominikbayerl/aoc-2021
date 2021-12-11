lines = readlines("input.txt")

function main()
    Σ = 0
    pairs = Dict('(' => ')', '[' => ']', '{' => '}', '<' => '>')
    revpairs = Dict(v => k for (k,v) = pairs)
    penalties = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
    for line = lines
        stack = []
        for char = collect(line)
            if char in ['(', '[', '{', '<']
                pushfirst!(stack, char)
            else
                if popfirst!(stack) != revpairs[char]
                    Σ += penalties[char]
                    break
                end
            end
        end
    end
    println(Σ)
end

main()