function racaman(iteration, history)
    iteration < 1 && error("Iteration must be >= 1")
    if length(history) == 0
        history = [0]
    end

    n = last(history)

    next_number = n - iteration

    if next_number < 0 || next_number in history
        next_number = n + iteration
    end

    return next_number
end
