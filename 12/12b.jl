lines = readlines("input.txt")

edges = [Tuple(split(line, '-')) for line = lines]
nodes = unique(vcat(collect.(edges)...))
N = length(nodes)
adjacency = falses((N,N))
node2idx = n -> findfirst(nodes .== n)
idx2node = i -> nodes[i]

function isupper(s)
    return isuppercase.(collect(s)) |> all
end

function DFS(from, to, cond, state)
    state = [state..., from]
    if from == to
        names = idx2node.(state)
        return [state]
    else
        C_n = findall(adjacency[from, :] .== true)
        paths = [DFS(n, to, cond, state) for n ∈ C_n if cond(from, n, state)]
        return length(paths) > 0 ? reduce(vcat, paths) : []
    end
end

for (from, to) = edges
    ix, iy = node2idx(from), node2idx(to)
    adjacency[ix,iy] = adjacency[iy,ix] = true 
end

# big oof.
function twice(c)
    return (from, to, state) -> from != node2idx("end") && (
        isupper(idx2node(to))
        || !(to ∈ state) 
        || (to == c && count(==(c), state) < 2)
    )
end

paths = []
for c = nodes
    if c in ["start", "end"]
        continue
    end
    append!(paths, DFS(node2idx("start"), node2idx("end"), twice(node2idx(c)), []))
end
println(length(Set(vcat(paths))))

