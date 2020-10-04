module Funometry

using Images
using Luxor

include("toothpicks.jl")
include("racaman.jl")

export
    # toothpicks.jl
    ToothpickPoint,
    Toothpick,
    spawn,
    generate_toothpicks,

    # racaman.jl
    racaman

end # module
