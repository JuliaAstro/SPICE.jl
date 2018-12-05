@testset "B" begin
    @test b1900() == 2415020.31352
    @test b1950() == 2433282.42345905

    furnsh(path(CORE, :pck))
    @test badkpv("SPICE.jl", "BODY399_RADII", "=", 3, 1, "N") == false
    @test_throws SpiceError badkpv("SPICE.jl", "BODY399_RADII", "=", 3, 1, "C")
    unload(path(CORE, :pck))

    idset = bltfrm(-1)
    @test length(idset) >= 126

    @test bodc2n(399) == "EARTH"
    @test_throws SpiceError bodc2n(typemax(Cint))

    @test bodc2s(399) == "EARTH"
    @test bodc2s(typemax(Cint)) == string(typemax(Cint))

    boddef("Spaceball One", 999999)
    @test bodc2n(999999) == "Spaceball One"

    furnsh(path(CORE, :pck))
    @test bodfnd(399, "RADII") == true
    @test bodfnd(999999, "RADII") == false
    unload(path(CORE, :pck))

    @test bodn2c("EARTH") == 399
    @test_throws SpiceError bodn2c("Norbert")

    @test bods2c("EARTH") == 399
    @test bods2c("888888") == 888888
    @test_throws SpiceError bodn2c("Norbert")

    furnsh(path(CORE, :pck))
    @test bodvcd(399, "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test bodvcd(399, "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test_throws SpiceError bodvcd(399, "Norbert")
    @test_throws SpiceError bodvcd(999999, "RADII")
    unload(path(CORE, :pck))

    furnsh(path(CORE, :pck))
    @test bodvrd("EARTH", "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test bodvrd("EARTH", "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test_throws SpiceError bodvrd("EARTH", "Norbert")
    @test_throws SpiceError bodvrd("Norbert", "RADII")
    unload(path(CORE, :pck))

    @test SPICE._brcktd(4.0, 1.0, 3.0) == clamp(4.0, 1.0, 3.0)
    @test SPICE._brckti(4, 1, 3) == clamp(4, 1, 3)
    let arr = ["FEYNMAN", "BOHR", "EINSTEIN", "NEWTON", "GALILEO"],
        ord=sortperm(arr)
        for name in arr
            @test SPICE._bschoc(name, arr, ord) ==
                findfirst(arr .== name)
            @test SPICE._bsrchc(name, sort(arr)) ==
                findfirst(sort(arr) .== name)
        end
    end
    @test SPICE._bschoi(1, [3, 1, 2], [2, 3, 1]) == findfirst([3, 1, 2] .== 1)
    @test SPICE._bsrchd(3.0, [1.0, 2.0, 3.0]) ==
        findfirst([1.0, 2.0, 3.0] .== 3.0)
    @test SPICE._bsrchi(3, [1, 2, 3]) == findfirst([1, 2, 3] .== 3)
end
