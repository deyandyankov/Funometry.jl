function racaman(N)
    sequence = [0]
    n = last(sequence)
    
    for i in 1:N
        next_number = n - i
        if next_number < 0 || next_number in sequence
            next_number = n + i
        end
        n = next_number
        push!(sequence, next_number)
    end
    return sequence
end
