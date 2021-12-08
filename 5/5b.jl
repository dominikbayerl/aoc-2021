lines = readlines("input.txt")
field = zeros(Int, (1024,1024))
re = r"(\d+)"

for line = lines
    x1,y1,x2,y2 = 1 .+ parse.(Int, m.match for m = eachmatch(re, line))
    dx,dy = x1 < x2 ? 1 : -1, y1 < y2 ? 1 : -1
    if x1 != x2 && y1 != y2  
        for ij = CartesianIndex.(zip(y1:dy:y2, x1:dx:x2))
            field[ij] += 1
        end
    else
        field[y1:dy:y2, x1:dx:x2] .+= 1
    end
end

println(sum(@. field > 1))