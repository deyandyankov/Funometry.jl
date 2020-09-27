using Makie
using GeometryBasics

struct PositionedRect
    rect::Rect
    idx::Int64
end

function rect_from_center(center, a)
    x, y = center
    Rect(
        Vec(x - a/2, y - a/2),
        Vec(a, a)
    )
end

first_rectangle = rect_from_center((0, 0), 4096)
second_rectangle = rect_from_center((0, 0), 2048)

function rectangle_position_from_idx(idx)
    idx == 0 && return :center
    idx == 1 && return :lower_left
    idx == 2 && return :lower_right
    idx == 3 && return :upper_right
    idx == 4 && return :upper_left
end

function corner_name_to_idx(cname)
    cname == :lower_left && return 1
    cname == :lower_right && return 2
    cname == :upper_right && return 3
    cname == :upper_left && return 4
end

function skip_gen(rect_idx, corner_name)
    rect_position = rectangle_position_from_idx(rect_idx)
    if rect_position == :lower_left && corner_name == :upper_right
        return true
    end

    if rect_position == :lower_right && corner_name == :upper_left
        return true
    end

    if rect_position == :upper_right && corner_name == :lower_left
        return true
    end

    if rect_position == :upper_left && corner_name == :lower_right
        return true
    end
    
    return false
end

function corners_from_rect(rect)
    origin_x = rect.origin[1]
    origin_y = rect.origin[2]
    a, b = rect.widths

    lower_left = (origin_x, origin_y)
    lower_right = (origin_x + a, origin_y)
    upper_right = (origin_x + a, origin_y + b)
    upper_left = (origin_x, origin_y + b)

    Dict(
        :lower_left => lower_left,
        :lower_right => lower_right,
        :upper_right => upper_right,
        :upper_left => upper_left
    )
end

init_scene() = Scene(show_axis = false)

function naive_plot_rectangles_around_corners(corners, a; rectangles = [])
    a < 100 && return rectangles

    for corner in corners
        rect = rect_from_center(corner, a)
        new_corners = corners_from_rect(rect)
        push!(rectangles, rect)
        plot_rectangles_around_corners(new_corners, a/2, rectangles = rectangles)
    end
    return rectangles
end

function naive_init_scene()
    scene = Scene(show_axis = false)
    poly!(scene, Rect(-1000, -1000, 2000, 2000), color = :white)
    rect = rect_from_center((0, 0), 1000)
    corners = corners_from_rect(rect)
    poly!(scene, rect, color = :black)
    Makie.save("plot_0.png", scene)
    return scene, rect, corners
end
