lines = readlines("input.txt")
numbers = parse.(Int, lines)

sums = sum.(zip(numbers[1:end-2], numbers[2:end-1], numbers[3:end]))
println(sum(sums[2:end] .> sums[1:end-1]))