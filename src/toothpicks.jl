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

function Toothpick(center::ToothpickPoint, horizontal::Bool; toothpick_length=31)
    toothpick_half = div(toothpick_length - 1, 2)

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

function spawn(toothpicks::Dict{Int,Array{Toothpick,1}})
    last_iteration_toothpicks = toothpicks[maximum(keys(toothpicks))]
    new_toothpicks = Toothpick[]

    occurances = Dict{ToothpickPoint,Int}()
    for tp in [[t.a for t in Iterators.flatten(values(toothpicks))]; [t.b for t in Iterators.flatten(values(toothpicks))]]
        if tp in keys(occurances)
            occurances[tp] += 1
        else
            occurances[tp] = 1
        end
    end

    for t in last_iteration_toothpicks
        if occurances[t.a] == 1
            push!(new_toothpicks, Toothpick(t.a, !t.horizontal))
        end
        if occurances[t.b] == 1
            push!(new_toothpicks, Toothpick(t.b, !t.horizontal))
        end
    end
    new_toothpicks
end

function generate_toothpicks(N::Int)
    iteration_toothpicks = Dict{Int, Array{Toothpick,1}}(
        1 => [Toothpick(ToothpickPoint(0, 0), false)]
    )
    new_toothpicks = copy(iteration_toothpicks[1])

    for iteration in 2:N
        new_toothpicks = spawn(iteration_toothpicks)
        iteration_toothpicks[iteration] = new_toothpicks
    end

    iteration_toothpicks
end
