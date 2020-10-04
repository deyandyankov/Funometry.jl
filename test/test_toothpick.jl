using Test
using Funometry

@testset "Toothpick" begin
    result = generate_toothpicks(12)
    expected_values = [
        1, 3, 7, 11, 15, 23, 35, 43, 47, 55, 67, 79
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
        @test toothpicks_at_iteration[ei] == ep
    end

end
