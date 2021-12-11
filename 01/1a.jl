lines = readlines("input.txt")
numbers = parse.(Int, lines)

println(sum(numbers[2:end] .> numbers[1:end-1]))