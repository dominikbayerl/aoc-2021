import Statistics

lines = readlines("input.txt")
matrix = parse.(Bool, hcat(collect.(lines)...))

oxygen = co2 = matrix'
for idx = axes(matrix, 1)
    if size(oxygen, 1) > 1
        mean = Statistics.mean(oxygen[:,idx]) .>= 0.5
        global oxygen = oxygen[findall(x -> x[idx] == mean, eachrow(oxygen)), :]
    end

    if size(co2, 1) > 1
        mean = Statistics.mean(co2[:,idx]) .>= 0.5
        global co2 = co2[findall(x -> x[idx] != mean, eachrow(co2)), :]
    end
end

function bitarr_to_int(arr)
    return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
end

println(bitarr_to_int(oxygen') * bitarr_to_int(co2'))