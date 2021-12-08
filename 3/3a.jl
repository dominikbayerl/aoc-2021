import Statistics

lines = readlines("input.txt")
matrix = parse.(Bool, hcat(collect.(lines)...))

gamma = Statistics.mean(eachcol(matrix)) .>= 0.5
epsilon = @. !gamma

function bitarr_to_int(arr)
    return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
end

println(bitarr_to_int(gamma) * bitarr_to_int(epsilon))