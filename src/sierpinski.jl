function sierpinski_carpet(b::BoundingBox)
    w = boxwidth(b)
    h = boxheight(b)
    d = boxdiagonal(b)
    a = w / 3

    corner2(corner1::Point) = corner1 + Point(a, a)

    corner1s = [
        b.corner1 + Point(0, 0),
        b.corner1 + Point(a, 0),
        b.corner1 + Point(2a, 0),

        b.corner1 + Point(0, a),
#        b.corner1 + Point(a, a),
        b.corner1 + Point(2a, a),

        b.corner1 + Point(0, 2a),
        b.corner1 + Point(a, 2a),
        b.corner1 + Point(2a, 2a)
    ]
    corner2s = corner2.(corner1s)

    boxes = Array{BoundingBox,1}(undef, 8)
    for (idx, corners) in enumerate(zip(corner1s, corner2s))
        boxes[idx] = BoundingBox(corners[1], corners[2])
    end
    
    boxes
end
