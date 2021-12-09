lines = readlines("input.txt")
heightmap = parse.(Int, reduce(hcat, collect.(lines)))
idx = CartesianIndices(heightmap)

o = CartesianIndex(1,1)
V = CartesianIndex(-1, 0), CartesianIndex(1, 0), CartesianIndex(0, -1), CartesianIndex(0, 1)
padded = fill(10, size(heightmap) .+ 2)
padded[idx .+ o] = heightmap[idx]

minimum = reduce(.&, [padded[idx .+ o .+ v] .> heightmap for v = V])

function DFS(yx_i, cond, s)
    cond_j = yx_j -> cond(yx_j) && (heightmap[yx_j] >= heightmap[yx_i]) && !(yx_j ∈ s)
    return reduce(vcat, [yx_i, [DFS(yx_i + v, cond, [yx_i, s...]) for v ∈ V if cond_j(yx_i + v)]...])
end

cond = yx -> padded[yx + o] < 9
basins = [Set(DFS(start, cond, [])) for start = findall(==(1), minimum)]
println(prod(sort(length.(basins), rev=true)[1:3]))
