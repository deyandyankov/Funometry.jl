using Test
using Funometry

@testset "racaman" begin
    @test racaman(0) == [0]
    @test racaman(1) == [0, 1]
    @test racaman(5) == [0, 1, 3, 6, 2, 7]
end
