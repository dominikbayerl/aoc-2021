import Statistics

line = read("input.txt", String)
numbers = parse.(Int, split(line, ','))

# argmin x ∑i=1-N |s_i−x| = ∑i=1-N sign(s_i − x) -> hence, equal number of positive and negative elements = median
position = convert(Int, round(Statistics.median(numbers)))
println(sum(@. abs(numbers - position)))

