lines = readlines("input.txt")
x,y,aim = 0,0,0

for line = lines
    cmd, arg_s = split(line)
    arg_i = parse(Int, arg_s)
    if cmd == "forward"
        global x += arg_i
        global y += aim * arg_i
    elseif cmd == "down"
        global aim += arg_i
    elseif cmd == "up"
        global aim -= arg_i
    end
end

println(x*y)