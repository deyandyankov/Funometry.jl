using Luxor
import Funometry

function luxor_rect_from_center(center, a)
    x, y = center
    Rect(
        Vec(x - a/2, y - a/2),
        Vec(a, a)
    )
end

function square_corners_from_center(center, a)
    origin_x = center.x
    origin_y = center.y
    lower_left = Point(origin_x - a, origin_y - a)
    lower_right = Point(origin_x + a, origin_y - a)
    upper_right = Point(origin_x + a, origin_y + a)
    upper_left = Point(origin_x - a, origin_y + a)

    Dict(
        :lower_left => lower_left,
        :lower_right => lower_right,
        :upper_right => upper_right,
        :upper_left => upper_left
    )
end


function tsquare()
    w = 2048
    h = 2048
    center_x = div(w, 2)
    center_y = div(h, 2)
    a = 512
    
    prefix = "tsquare"

    Drawing(w, h, "tsquare_0.svg")
    background("white")
    # origin(1024, 1024)
    
    sethue("black")
    centers = square_corners_from_center(Point(center_x, center_y), a)
    #box(center, a, a, :fill)
    box(Point(800, 800), 100, 123, :fill)
    while a >= 512
        new_centers = []
        for (center_location, center_point) in centers
            println(center_location)
            # println("going once...")
            corners = square_corners_from_center(center_point, a)
            for (corner_name, corner_point) in corners
                println("Center_location: $center_location, $center_point, $corner_name, $corner_point")
                box(corner_point, a/2, a/2, :fill)
                # push!(new_centers, square_corners_from_center(corner_point, a))
                # break
            end
            break

        end
        #centers = copy(new_centers)
        a /= 2
    end
    
    finish()
end

tsquare()
