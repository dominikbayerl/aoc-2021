numbers,folds = split(read("input.txt", String), "\n\n")
re = r"(\w)=(\d+)"

xys = @. map(x -> parse(Int, x) + 1, Tuple(split($split(numbers, '\n'), ',')))
N = maximum(reduce(hcat, collect.(xys)))
w,h = maximum(map(t -> t[1], xys)), maximum(map(t -> t[2], xys))
field = falses((w,h))
field[CartesianIndex.(xys)] .= true

for fold = eachline(IOBuffer(folds))
    local w,h = size(field)
    axis,pos = match(re, fold)
    pos = parse(Int, pos) + 1
    if axis == "y"
        A,B = view(field, :, 1:pos-1), view(field, :, h:-1:(pos+1))
    elseif axis == "x"
        A,B = view(field, 1:pos-1, :), view(field, w:-1:(pos+1), :)
    end
    global field = A .| B
end

plot = map(f -> f ? '⬛' : '⬜', field')
println(join(collect(join.(eachrow(plot))), '\n'))
