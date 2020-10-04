using Funometry

function draw_racaman(history)
    max_iteration = length(history)
    imgnum = lpad(max_iteration, 3, "0")
    w = 256
    h = 256

    Drawing(h, w, "racaman_$(imgnum).png")

    points = [Point(x, 0) for x in history]
    

    # scale(25, 25)
    background("black")

    ys = []

    sethue("white")

    draw_arcs = []
    left = 1
    right = 2
    while right <= length(points)
        left_point = points[left]
        right_point = points[right]
        center_point = midpoint(left_point, right_point)
        push!(draw_arcs, (center_point, left_point, right_point))
        push!(ys, right_point.x - center_point.x)
        left += 1
        right += 1
    end


    max_y = maximum(ys)
    @show max_y

    draw_arcs = [d .* 10 for d in draw_arcs]


    origin(Point(h * .1, h * .9))
    rotate(-π/4)
    for d in draw_arcs
        arc2r(d[1], d[2], d[3], :stroke)
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
    history = generate_racaman(20)

    for i=1:length(history)-1
        draw_racaman(history[1:i+1])
    end
end

do_racaman()
