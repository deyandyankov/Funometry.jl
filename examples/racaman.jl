using Funometry
using Luxor

function backdrop(scene, framenumber)
    background("black")
    origin(Point(scene.movie.width * .1, scene.movie.height * .9))
end

function frame(scene, framenumber)
    max_iteration = maximum(scene.movie.movieframerange)

    sequence = scene.opts[:sequence]
    sequence_so_far = sequence[1:framenumber]
    points = [Point(x, 0) for x in sequence_so_far]

    rotate(-π/4)
    scaler = 10

    sethue(1, 1 - framenumber / max_iteration, 0)

    left = 1
    right = 2
    while right <= length(points)
        left_point = points[left]
        right_point = points[right]
        center_point = midpoint(left_point, right_point)
        arc_tuple = (center_point, left_point, right_point)
        arc_tuple = arc_tuple .* scaler
        arc2r(arc_tuple[1], arc_tuple[2], arc_tuple[3], :stroke)
        left += 1
        right += 1
    end

    # draw a line..
    sethue("white")
    line_start = points[1]
    line_end = Point(maximum(sequence_so_far) * scaler, 0)
    
    line(line_start, line_end, :stroke)
end

function animate_racaman(N)
    racaman_movie = Movie(1024, 1024, "racaman", 1:N)
    optarg = Dict(:sequence => racaman(N))

    scenes_backdrop = Scene(racaman_movie, backdrop, optarg=optarg)
    scenes_frame = Scene(racaman_movie, frame, optarg=optarg)
    
    animate(
        racaman_movie,
        [scenes_backdrop, scenes_frame],
        creategif=true,
        framerate=5,
        pathname="/tmp/animationtest.gif"
    )
end

animate_racaman(65)
