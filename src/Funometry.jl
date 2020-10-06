module Funometry

using Images
using Luxor
using Distances

include("toothpicks.jl")
include("racaman.jl")
include("sierpinski.jl")

export
    # toothpicks.jl
    ToothpickPoint,
    Toothpick,
    spawn,
    generate_toothpicks,

    # racaman.jl
    racaman,

    # sierpinski.jl
    sierpinski_carpet

end # module
