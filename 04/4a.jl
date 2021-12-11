lines = readlines("input.txt")
numbers = parse.(Int, split(lines[1], ','))
fields_s = reshape(lines[2:end], 6, :)[2:end, :]
fields = parse.(Int, reshape(reduce(vcat, split.(fields_s)), 5,5,:))
marks = falses(size(fields))

for n = numbers
    marks[findall(x -> x == n, fields)] .= true

    rowhits = mapslices(prod, marks, dims=[1])
    if any(rowhits) # rows
        board = findfirst(isone, rowhits)[3]
        println(sum(@. fields[:,:,board] * !marks[:,:,board]) * n)
        break
    end

    colhits = mapslices(prod, marks, dims=[2])
    if any(colhits)
        board = findfirst(isone, colhits)[3]
        println(sum(@. fields[:,:,board] * !marks[:,:,board]) * n)
        break
    end
end
