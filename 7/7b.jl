import Statistics

line = read("input.txt", String)
numbers = parse.(Int, split(line, ','))

function sumto(n)
    return (n * (n + 1)) ÷ 2
end

# argmin x ∑i=1-N (∑j=1-|s_i−x| j) = 1/2n ∑i=1-N -sign(x_i-x) - mean(x)
position = convert(Int, floor(Statistics.mean(numbers)))
println(sum(@. sumto(abs(numbers - position))))

