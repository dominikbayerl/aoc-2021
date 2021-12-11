line = read("input.txt", String)
numbers = parse.(Int, split(line, ','))
counts = zeros(Int, 9)

for n = numbers
    counts[n+1] += 1
end

days = 256
for _ = 1:days
    newfish = counts[1]
    for i = 1:8
        counts[i] = counts[i+1]
    end
    counts[7] += newfish
    counts[9] = newfish
end
println(sum(counts))