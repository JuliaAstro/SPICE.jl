@testset "B" begin
    @test b1900() == 2415020.31352
    @test b1950() == 2433282.42345905

    furnsh(path(:PCK))
    @test badkpv("SPICE.jl", "BODY399_RADII", "=", 3, 1, "N") == false
    @test_throws SpiceException badkpv("SPICE.jl", "BODY399_RADII", "=", 3, 1, "C")
    unload(path(:PCK))

    idset = bltfrm(-1)
    @test length(idset) >= 126

    @test bodc2n(399) == "EARTH"
    @test_throws SpiceException bodc2n(typemax(Cint))

    @test bodc2s(399) == "EARTH"
    @test bodc2s(typemax(Cint)) == string(typemax(Cint))

    boddef("Spaceball One", 999999)
    @test bodc2n(999999) == "Spaceball One"

    furnsh(path(:PCK))
    @test bodfnd(399, "RADII") == true
    @test bodfnd(999999, "RADII") == false
    unload(path(:PCK))

    @test bodn2c("EARTH") == 399
    @test_throws SpiceException bodn2c("Norbert")

    @test bods2c("EARTH") == 399
    @test bods2c("888888") == 888888
    @test_throws SpiceException bodn2c("Norbert")

    furnsh(path(:PCK))
    @test bodvcd(399, "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test bodvcd(399, "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test_throws SpiceException bodvcd(399, "Norbert")
    @test_throws SpiceException bodvcd(999999, "RADII")
    unload(path(:PCK))

    furnsh(path(:PCK))
    @test bodvrd("EARTH", "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test bodvrd("EARTH", "RADII") == [6378.1366, 6378.1366, 6356.7519]
    @test_throws SpiceException bodvrd("EARTH", "Norbert")
    @test_throws SpiceException bodvrd("Norbert", "RADII")
    unload(path(:PCK))
end
