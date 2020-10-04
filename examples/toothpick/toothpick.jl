using Funometry
using Test
using Images
using Luxor

function test_result(result)
    expected_values = [
        1, 3, 7, 11, 15, 23, 35, 43, 47, 55, 67, 79, 95, 123, 155, 171, 175, 183, 195, 207, 223, 251, 283, 303, 319, 347, 383, 423, 483, 571, 651, 683, 687, 695, 707, 719, 735, 763, 795, 815, 831, 859, 895, 935, 995, 1083, 1163, 1199, 1215, 1243, 1279, 1319, 1379
    ]
    expected_keys = 1:length(expected_values)
    expected_toothpicks_at_iteration = Dict(zip(expected_keys, expected_values))
    toothpicks_at_iteration = Dict{Int,Int}()
    
    total_toothpicks = 0
    for iteration in 1:maximum(keys(result))
        total_toothpicks += length(result[iteration])
        toothpicks_at_iteration[iteration] = total_toothpicks
    end
    for (ei, ep) in expected_toothpicks_at_iteration
        @assert toothpicks_at_iteration[ei] == ep
    end
end




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

function generate_toothpicks(N::Int)
    iteration_toothpicks = Dict{Int, Array{Toothpick,1}}(
        1 => [Toothpick(ToothpickPoint(0, 0), false)]
    )
    new_toothpicks = copy(iteration_toothpicks[1])
    draw(iteration_toothpicks)

    for iteration in 2:N
        new_toothpicks = spawn(iteration_toothpicks)
        iteration_toothpicks[iteration] = new_toothpicks
        draw(iteration_toothpicks)
    end
    iteration_toothpicks

end

result = generate_toothpicks(128)

test_result(result)
