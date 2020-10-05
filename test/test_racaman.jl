using Test
using Funometry

@testset "racaman" begin
    @test racaman(1, [0]) == 1
    @test racaman(2, [0, 1]) == 3
    @test racaman(3, [0, 1, 3]) == 6
    @test racaman(4, [0, 1, 3, 6]) == 2
    @test racaman(5, [0, 1, 3, 6, 2]) == 7
end
