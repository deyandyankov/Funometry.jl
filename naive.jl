include("func.jl")
using ProgressMeter


begin
    Makie.AbstractPlotting.inline!(true)
    _scene, rect, corners = init_scene()
    rectangles = naive_plot_rectangles_around_corners(corners, 500)
    println(length(rectangles))

    rectangles = unique(rectangles)
    println(length(rectangles))
    
    @showprogress for i in 1:length(rectangles)
        scene, _, __, = naive_init_scene()
        unique_rectangles = unique(rectangles[1:i])
        color = :black
        for r in 1:i
            poly!(scene, unique_rectangles[r], color = color)
        end
        imgnum = lpad(i, 5, "0")
        filename = "plot_$(imgnum).png"
        Makie.save(filename, scene)
    end

    cmd = "convert -delay 1 plot_*.png -delay 500 last_frame.png myimage.gif"
    println(cmd)

end


