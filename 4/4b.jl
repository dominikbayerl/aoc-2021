lines = readlines("input.txt")
numbers = parse.(Int, split(lines[1], ','))
fields_s = reshape(lines[2:end], 6, :)[2:end, :]
fields = parse.(Int, reshape(reduce(vcat, split.(fields_s)), 5,5,:))
marks = falses(size(fields))
stack = Vector()

for n = numbers
    marks[findall(x -> x == n, fields)] .= true

    rowhits = mapslices(prod, marks, dims=[1])
    if any(rowhits) # rows
        for hit = findall(isone, rowhits)
            board = hit[3]
            push!(stack, (fields[:,:,board], marks[:,:,board], n))
            fields[:,:,board] = marks[:,:,board] .= 0
        end
    end

    colhits = mapslices(prod, marks, dims=[2])
    if any(colhits) # cols
        for hit = findall(isone, colhits)
            board = hit[3]
            push!(stack, (fields[:,:,board], marks[:,:,board], n))
            fields[:,:,board] = marks[:,:,board] .= 0
        end
    end
end

(field, mark, n) = last(stack) # last board to finish
println(sum(@. field * !mark) * n)
