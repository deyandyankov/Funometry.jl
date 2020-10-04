using Funometry
using Test
using Images
using Luxor


function pride_colour(iteration::Int)
    colours = Dict(
        1 => (120., 79., 23.) ./ 255,
        2 => (228., 3., 3.) ./ 255,
        3 => (255., 140., 0.) ./ 255,
        4 => (255., 237., 0.) ./ 255,
        5 => (0., 128., 38.) ./ 255,
        6 => (0., 77., 255.) ./ 255,
        7 => (117., 7., 135.) ./ 255
    )

    for i in 1:maximum(keys(colours))
        if iteration < 2^i
            return colours[i]
        end
    end
    return colours[7]

end

function draw(iteration_toothpicks)
    max_iteration = maximum(keys(iteration_toothpicks))
    imgnum = lpad(max_iteration, 3, "0")
    h = 2048
    w = 2048
    Drawing(h, w, "toothpicks_$(imgnum).png")
    origin()
    background("black")

    # needed for calculating scale
    all_toothpicks = Iterators.flatten(collect(values(iteration_toothpicks)))
    tpx = Iterators.flatten([Iterators.flatten([tp.a.x; tp.b.x]) for tp in all_toothpicks])
    tpy = Iterators.flatten([Iterators.flatten([tp.a.y; tp.b.y]) for tp in all_toothpicks])
    min_x = minimum(tpx)
    max_x = maximum(tpx)
    min_y = minimum(tpy)
    max_y = maximum(tpy)
    h_y = abs(min_y) + abs(max_y)
    w_x = abs(min_x) + abs(max_y)
    scale(h / h_y, w / w_x)

    for iteration in 1:maximum(keys(iteration_toothpicks))
        toothpicks = iteration_toothpicks[iteration]

        col = pride_colour(iteration)
        sethue(col)


        for t in toothpicks
            a = Point(t.a.x, t.a.y)
            b = Point(t.b.x, t.b.y)
            line(a, b, :stroke)
        end
    end
    
    finish()
end

function example_toothpick(iterations)
    generated = generate_toothpicks(iterations)

    for (iteration, toothpicks) in generated
        d = Dict{Int, Array{Toothpick,1}}()
        for i in 1:iteration
            d[i] = generated[i]
        end
        draw(d)
    end
end

example_toothpick(13)
