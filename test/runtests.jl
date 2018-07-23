using SPICE
using RemoteFiles
using Test

tempfile() = joinpath(tempdir(), randstring(6))

const BASE_URL = "https://raw.githubusercontent.com/AndrewAnnex/SpiceyPyTestKernels/master/"
const KERNEL_DIR = joinpath(@__DIR__, "kernels")

@RemoteFileSet CASSINI "Cassini Kernels" begin
    pck     = @RemoteFile BASE_URL * "cpck05Mar2004.tpc" dir=KERNEL_DIR
    sat_spk      = @RemoteFile BASE_URL * "130220AP_SE_13043_13073.bsp" dir=KERNEL_DIR
    tour_spk = @RemoteFile BASE_URL * "130212AP_SK_13043_13058.bsp" dir=KERNEL_DIR
    fk      = @RemoteFile BASE_URL * "cas_v40.tf" dir=KERNEL_DIR
    ck      = @RemoteFile BASE_URL * "13056_13057ra.bc" dir=KERNEL_DIR
    sclk    = @RemoteFile BASE_URL * "cas00167.tsc" dir=KERNEL_DIR
    ik      = @RemoteFile BASE_URL * "cas_iss_v10.ti" dir=KERNEL_DIR
end

@RemoteFileSet EXTRA "Extra Kernels" begin
    voyager_sclk     = @RemoteFile BASE_URL * "vg200022.tsc" dir=KERNEL_DIR
    earth_topo_tf     = @RemoteFile BASE_URL * "earth_topo_050714.tf" dir=KERNEL_DIR
    earth_stn_spk     = @RemoteFile BASE_URL * "earthstns_itrf93_050714.bsp" dir=KERNEL_DIR
    earth_high_per_pck = @RemoteFile BASE_URL * "earth_031228_231229_predict.bpc" dir=KERNEL_DIR
    phobos_dsk       = @RemoteFile BASE_URL * "phobos_lores.bds" dir=KERNEL_DIR
    mars_spk         = @RemoteFile BASE_URL * "mar022-1.bsp" dir=KERNEL_DIR
end

@RemoteFileSet CORE "Core Kernels" begin
    pck    = @RemoteFile BASE_URL * "pck00010.tpc" dir=KERNEL_DIR
    spk    = @RemoteFile BASE_URL * "de405s_littleendian.bsp" dir=KERNEL_DIR
    gm_pck = @RemoteFile BASE_URL * "gm_de431.tpc" dir=KERNEL_DIR
    lsk    = @RemoteFile BASE_URL * "naif0012.tls" dir=KERNEL_DIR
end

download(CASSINI)
download(EXTRA)
download(CORE)

@testset "SPICE" begin
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
        @test card(cell) == 3

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
end
