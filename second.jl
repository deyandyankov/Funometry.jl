using ProgressMeter
include("func.jl")


function run(iterations)
    Makie.AbstractPlotting.inline!(true)
    scene = init_scene()
    poly!(scene, first_rectangle, color = :white)
    poly!(scene, second_rectangle, color = :black)
    Makie.save("plot_0.png", scene)

    nr = [PositionedRect(second_rectangle, 0)]
    a = 1024
    for iteration in 1:iterations
        println("Iteration: $(iteration), a: $a")

        if iteration == 1
            expected_elements = 4
        else
            expected_elements = 4^iteration - div(4^iteration, 4)
        end
        new_rectangles = Array{PositionedRect, 1}(undef, expected_elements)

        new_rectangles = []
        
        i = 1
        for (rectangle_idx, rectangle) in enumerate(nr)
            rect = rectangle.rect
            rect_idx = rectangle.idx

            rect_position = rectangle_position_from_idx(rect_idx)
            # println("$(rectangle_idx), $(rectangle), $(rect_position)")
            
            for (corner_name, corner_coord) in corners_from_rect(rect)
                skip_gen(rect_idx, corner_name) && continue
                new_rect = rect_from_center(corner_coord, a)
                poly!(scene, new_rect, color = :black)
                # println("reference: $i , $(length(new_rectangles))")
#                new_rectangles[i] = PositionedRect(new_rect, corner_name_to_idx(corner_name))
                push!(new_rectangles, PositionedRect(new_rect, corner_name_to_idx(corner_name)))
                i += 1
            end
        end
        println("Total new rectangles generated: $(length(new_rectangles))")
        nr = new_rectangles
        a /= 2
        filename = "plot_$(iteration).png"
        println("Saving $filename")
        Makie.save(filename, scene)
    end
end

@time run(10)
