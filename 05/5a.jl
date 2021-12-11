lines = readlines("input.txt")
field = zeros(Int, (1024,1024))
re = r"(\d+)"

for line = lines
    x1,y1,x2,y2 = parse.(Int, m.match for m = eachmatch(re, line))
    if x1 != x2 && y1 != y2
        continue
    end

    idx1,idx2,idy1,idy2 = min(x1,x2)+1, max(x1,x2)+1, min(y1,y2)+1, max(y1,y2)+1
    field[idy1:idy2, idx1:idx2] .+= 1
end

println(sum(@. field > 1))