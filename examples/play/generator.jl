using Funometry

function draw_racaman(history)
    max_iteration = length(history)
    imgnum = lpad(max_iteration, 3, "0")
    w = 1024
    h = 1024

    Drawing(h, w, "racaman_$(imgnum).png")
    origin(Point(h * .1, h * .9))
    rotate(-π/4)
    
    points = [Point(x, 0) for x in history]
    background("black")

    sethue(1, 1 - max_iteration / 70, 0)
    left = 1
    right = 2
    while right <= length(points)
        left_point = points[left]
        right_point = points[right]
        center_point = midpoint(left_point, right_point)
        arc_tuple = (center_point, left_point, right_point)
        arc_tuple = arc_tuple .* 10
        arc2r(arc_tuple[1], arc_tuple[2], arc_tuple[3], :stroke)
        left += 1
        right += 1
    end


    finish()
end

function generate_racaman(N)
    history = [0]
    
    for iteration in 1:N
        next_number = racaman(iteration, history)
        push!(history, next_number)
    end

    return history
end

function do_racaman()
    history = generate_racaman(65)
    draw_racaman(history[1:1])
    for i=1:length(history)-1
        draw_racaman(history[1:i+1])
    end
end

do_racaman()
