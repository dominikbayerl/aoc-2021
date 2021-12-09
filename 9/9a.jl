lines = readlines("input.txt")
heightmap = parse.(Int, reduce(hcat, collect.(lines)))
idx = CartesianIndices(heightmap)

o = CartesianIndex(1,1)
V = CartesianIndex(-1, 0), CartesianIndex(1, 0), CartesianIndex(0, -1), CartesianIndex(0, 1)
padded = fill(10, size(heightmap) .+ 2)
padded[idx .+ o] = heightmap[idx]

minimum = reduce(.&, [padded[idx .+ o .+ v] .> heightmap for v = V])
println(sum(minimum .* (heightmap .+ 1)))
