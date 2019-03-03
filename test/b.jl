@testset "B" begin
    @testset "b1900" begin
        @test b1900() == 2415020.31352
    end
    @testset "b1900" begin
        @test b1950() == 2433282.42345905
    end
    @testset "badkpv" begin
        try
            furnsh(path(CORE, :pck))
            @test !badkpv("SPICE.jl", "BODY399_RADII", "=", 3, 1, "N")
            @test_throws SpiceError badkpv("SPICE.jl", "BODY399_RADII", "=", 3, 1, "C")
        finally
            kclear()
        end
    end
    @testset "bltfrm" begin
        idset = bltfrm(-1)
        @test length(idset) >= 126
    end
    @testset "bodc2n" begin
        @test bodc2n(399) == "EARTH"
        @test bodc2n(typemax(Cint)) === nothing
    end
    @testset "bodc2s" begin
        @test bodc2s(399) == "EARTH"
        @test bodc2s(typemax(Cint)) == string(typemax(Cint))
    end
    @testset "boddef" begin
        boddef("Spaceball One", 999999)
        @test bodc2n(999999) == "Spaceball One"
    end
    @testset "bodfnd" begin
        try
            furnsh(path(CORE, :pck))
            @test bodfnd(399, "RADII") == true
            @test bodfnd(999999, "RADII") == false
        finally
            kclear()
        end
    end
    @testset "bodn2c" begin
        @test bodn2c("EARTH") == 399
        @test bodn2c("Norbert") === nothing
    end
    @testset "bods2c" begin
        @test bods2c("EARTH") == 399
        @test bods2c("888888") == 888888
        @test bodn2c("Norbert") === nothing
    end
    @testset "bodvcd" begin
        try
            furnsh(path(CORE, :pck))
            @test bodvcd(399, "RADII") == [6378.1366, 6378.1366, 6356.7519]
            @test bodvcd(399, "RADII") == [6378.1366, 6378.1366, 6356.7519]
            @test_throws SpiceError bodvcd(399, "Norbert")
            @test_throws SpiceError bodvcd(999999, "RADII")
        finally
            kclear()
        end
    end
    @testset "bodvrd" begin
        try
            furnsh(path(CORE, :pck))
            @test bodvrd("EARTH", "RADII") == [6378.1366, 6378.1366, 6356.7519]
            @test bodvrd("EARTH", "RADII") == [6378.1366, 6378.1366, 6356.7519]
            @test_throws SpiceError bodvrd("EARTH", "Norbert")
            @test_throws SpiceError bodvrd("Norbert", "RADII")
        finally
            kclear()
        end
    end
    @testset "brcktd/brckti" begin
        @test SPICE._brcktd(4.0, 1.0, 3.0) == clamp(4.0, 1.0, 3.0)
        @test SPICE._brckti(4, 1, 3) == clamp(4, 1, 3)
        arr = ["FEYNMAN", "BOHR", "EINSTEIN", "NEWTON", "GALILEO"]
        ord = sortperm(arr)
        for name in arr
            @test SPICE._bschoc(name, arr, ord) == findfirst(arr .== name)
            @test SPICE._bsrchc(name, sort(arr)) == findfirst(sort(arr) .== name)
        end
    end
    @testset "bschoi/bsrchd/bsrchi" begin
        @test SPICE._bschoi(1, [3, 1, 2], [2, 3, 1]) == findfirst([3, 1, 2] .== 1)
        @test SPICE._bsrchd(3.0, [1.0, 2.0, 3.0]) == findfirst([1.0, 2.0, 3.0] .== 3.0)
        @test SPICE._bsrchi(3, [1, 2, 3]) == findfirst([1, 2, 3] .== 3)
    end
end
