using Images
using Luxor

struct ToothpickPoint
    x::Int
    y::Int
end

struct Toothpick
    center::ToothpickPoint
    horizontal::Bool
    a::ToothpickPoint
    b::ToothpickPoint
end

function Toothpick(center::ToothpickPoint, horizontal::Bool)
    default_toothpick_length = 31

    toothpick_half = div(default_toothpick_length - 1, 2)

    if horizontal
        ax = center.x - toothpick_half
        ay = center.y
        bx = center.x + toothpick_half
        by = center.y
    else
        ax = center.x
        ay = center.y + toothpick_half
        bx = center.x
        by = center.y - toothpick_half
    end

    a = ToothpickPoint(ax, ay)
    b = ToothpickPoint(bx, by)

    Toothpick(center, horizontal, a, b)
end

function spawn(toothpick::Toothpick, from_a::Bool, from_b::Bool)
    spawned = []
    if from_a
        push!(spawned, Toothpick(toothpick.a, !toothpick.horizontal))
    end
    if from_b
        push!(spawned, Toothpick(toothpick.b, !toothpick.horizontal))
    end

    spawned
end

function spawn(toothpicks::Array{Toothpick,1})
    new_toothpicks = Toothpick[]

    occurances = Dict{ToothpickPoint,Int}()
    for tp in [[t.a for t in toothpicks]; [t.b for t in toothpicks]]
        if tp in keys(occurances)
            occurances[tp] += 1
        else
            occurances[tp] = 1
        end
    end

    for t in toothpicks
        if occurances[t.a] == 1
            push!(new_toothpicks, Toothpick(t.a, !t.horizontal))
        end
        if occurances[t.b] == 1
            push!(new_toothpicks, Toothpick(t.b, !t.horizontal))
        end
    end
    new_toothpicks
end

function pride_colour(iteration::Int)
    # colours = Dict(
    #     1 => (120., 79., 23.),
    #     2 => (228., 3., 3.),
    #     3 => (255., 140., 0.),
    #     4 => (255., 237., 0.),
    #     5 => (0., 128., 38.),
    #     6 => (0., 77., 255.),
    #     7 => (117., 7., 135.)
    # )

    colours = Dict(
        1 => "brown",
        2 => "red",
        3 => "orange",
        4 => "yellow",
        5 => "green",
        6 => "blue",
        7 => "purple"
    )
    if iteration % 7 == 0
        return colours[7]
    end

    return colours[iteration % 7]

end

function draw(iteration_toothpicks)
    imgnum = lpad(maximum(keys(iteration_toothpicks)), 3, "0")
    Drawing(1024, 1024, "toothpicks_$(imgnum).png")
    origin()
    background("black")

    drawn = []

    for iteration in 1:maximum(keys(iteration_toothpicks))
        toothpicks = iteration_toothpicks[iteration]
        col = pride_colour(iteration)
        @show iteration, col, length(toothpicks)
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
        new_toothpicks = spawn(new_toothpicks)
        iteration_toothpicks[iteration] = new_toothpicks
        draw(iteration_toothpicks)
    end
    iteration_toothpicks

end

result = generate_toothpicks(64)
