using SPICE
using Base.Test

# const LSK_URL = "https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/"
# const LSK_FILE = "naif0012.tls"
# const SPK_URL = "https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/"
# const SPK_FILE = "de430.bsp"

# if !isfile(LSK_FILE)
    # download(LSK_URL*LSK_FILE, LSK_FILE)
# end
# if !isfile(SPK_FILE)
    # download(SPK_URL*SPK_FILE, SPK_FILE)
# end

@testset "Cells" begin
    cell = SpiceIntCell(3)
    appnd(1, cell)
    appnd(2, cell)
    appnd(3, cell)
    @test cell[1:end] == [1, 2, 3]

    cell = SpiceIntCell(3)
    push!(cell, 1, 2, 3)
    @test cell[1:end] == [1, 2, 3]

    cell = SpiceIntCell(3)
    append!(cell, [1, 2, 3])
    @test cell[1:end] == [1, 2, 3]

    cell = SpiceDoubleCell(3)
    appnd(1, cell)
    appnd(2, cell)
    appnd(3, cell)
    @test cell[1:end] == [1.0, 2.0, 3.0]

    cell = SpiceDoubleCell(3)
    push!(cell, 1, 2, 3)
    @test cell[1:end] == [1.0, 2.0, 3.0]

    cell = SpiceDoubleCell(3)
    append!(cell, [1, 2, 3])
    @test cell[1:end] == [1.0, 2.0, 3.0]

    cell = SpiceCharCell(3, 6)
    appnd("foobar1", cell)
    appnd("foobar2", cell)
    appnd("foobar3", cell)
    @test cell[1:end] == fill("foobar", 3)

    cell = SpiceCharCell(3, 6)
    push!(cell, "foobar1", "foobar2", "foobar3")
    @test cell[1:end] == fill("foobar", 3)

    cell = SpiceCharCell(3, 6)
    append!(cell, ["foobar1", "foobar2", "foobar3"])
    @test cell[1:end] == fill("foobar", 3)

    cell = SpiceIntCell(1)
    @test_throws ErrorException cell[1]
    @test_throws ErrorException cell[2]
end

include("a.jl")
include("b.jl")
include("c.jl")
include("d.jl")
include("e.jl")
include("f.jl")
include("g.jl")
include("h.jl")
include("i.jl")
include("j.jl")
include("k.jl")
include("l.jl")
include("m.jl")
include("n.jl")
include("o.jl")
include("p.jl")
include("q.jl")
include("r.jl")
include("s.jl")
include("t.jl")
include("u.jl")
include("v.jl")
include("w.jl")
include("x.jl")
