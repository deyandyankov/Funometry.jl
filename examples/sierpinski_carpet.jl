using Funometry
using Luxor

function backdrop(scene, framenumber)
    background("black")
    origin()
end

function frame(scene, framenumber)
    boxes = scene.opts[:boxes][framenumber]
    sethue("white")

    for (idx, b) in enumerate(boxes)
        box(b, :fill)
    end

end

function animate_sierpinski_carpet(N)
    h = 2187
    w = 2187
    Drawing(h, w)
    movie = Movie(h, w, "", 1:N)

    boxes = Dict(
        1 => [BoundingBox()]
    )

    for i in 2:N
        boxes[i] = []
        for b in boxes[i-1]
            for bb in sierpinski_carpet(b)
                push!(boxes[i], bb)
            end
        end
    end

    optarg = Dict(
        :boxes => boxes
    )

    scenes = [
        Scene(movie, backdrop, optarg=optarg),
        Scene(movie, frame, optarg=optarg),
    ]

    animate(
        movie,
        scenes,
        creategif=true,
        framerate=1,
        pathname="/tmp/animation.gif"
    )
end

animate_sierpinski_carpet(7)
