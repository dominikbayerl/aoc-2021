lines = readlines("input.txt")
re = r"(\w+)"

function main()
    uniq = 0
    for line = lines
        input, output = split(line, '|')
        signals = [m.match for m = eachmatch(re, output)]
        for signal = signals
            if length(signal) == 2 # one
                uniq += 1
            elseif length(signal) == 3 # seven
                uniq += 1
            elseif length(signal) == 4 # four
                uniq += 1
            elseif length(signal) == 7 # eight
                uniq += 1
            end
        end
    end
    println(uniq)
end

main()
