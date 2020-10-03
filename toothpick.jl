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
    default_toothpick_length = 17

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

function draw(toothpicks::Array{Toothpick,1}, iteration)
    imgnum = lpad(iteration, 3, "0")
    Drawing(1000, 1000, "toothpicks_$(imgnum).png")
    origin()
    background("black")
    sethue("white")
    for t in toothpicks
        a = Point(t.a.x, t.a.y)
        b = Point(t.b.x, t.b.y)
        line(a, b, :stroke)
    end
    finish()
end

function generate_toothpicks(iterations::Int)
    toothpicks = [
        Toothpick(ToothpickPoint(0, 0), true)
    ]
    new_toothpicks = copy(toothpicks)

    i = 0
    while i < iterations
        new_toothpicks = spawn(new_toothpicks)
        for new_toothpick in new_toothpicks
            push!(toothpicks, new_toothpick)
        end
        draw(toothpicks, i)
        i += 1
    end
    toothpicks
end

result = generate_toothpicks(112)
