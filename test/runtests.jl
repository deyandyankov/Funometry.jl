using Test
import Funometry

@testset "basic" begin
    r = Funometry.rect_from_center((0, 0), 500)
    @test r.origin == [-250, -250]
    @test r.widths == [500, 500]

    corners = Funometry.corners_from_rect(r)
    @test corners[:lower_left] == (-250, -250)
    @test corners[:lower_right] == (250, -250)
    @test corners[:upper_right] == (250, 250)
    @test corners[:upper_left] == (-250, 250)
end

@testset "init_scene" begin
    s = Funometry.init_scene()
    @test length(s.plots) == 0
end
