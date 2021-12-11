lines = readlines("input.txt")
x,y = 0,0

for line = lines
    cmd, arg_s = split(line)
    arg_i = parse(Int, arg_s)
    if cmd == "forward"
        global x += arg_i
    elseif cmd == "down"
        global y += arg_i
    elseif cmd == "up"
        global y -= arg_i
    end
end

println(x*y)