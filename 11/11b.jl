lines = readlines("input.txt")
octomap = parse.(Int, reduce(hcat, collect.(lines)))
idx = CartesianIndices(octomap)
minval = typemin(Int)

o = CartesianIndex(1,1)
V = CartesianIndices((-1:1, -1:1))
padded = fill(minval, size(octomap) .+ 2)
padded[idx .+ o] = octomap[idx]

for step = 1:1000
    padded .+= 1
    flashmap = fill(false, size(padded))
    while (yxs = findall(padded .>= 10)) |> length > 0
        flashmap[yxs] .= true
        padded[yxs] .= minval # Prevent any further flashing for this step
        [padded[yx .+ V] .+= 1 for yx = yxs]
    end
    padded[findall(flashmap)] .= 0

    if sum(flashmap) == 100
        println(step)
        break
    end
end
