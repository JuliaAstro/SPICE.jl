@testset "S" begin 
    @test spd() == 86400.0
    furnsh(path(CORE, :spk))
    @test sxform("J2000", "J2000", 0.0) ≈ eye(6)
    @test_throws SpiceException sxform("J2000", "Norbert", 0.0)
    @test spkezr("EARTH", 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkezr(399, 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkezr("EARTH", 0.0, "J2000", 399) == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkezr(399, 0.0, "J2000", 399) == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkpos("EARTH", 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0], 0.0)
    @test spkpos(399, 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0], 0.0)
    @test spkpos("EARTH", 0.0, "J2000", 399) == ([0.0, 0.0, 0.0], 0.0)
    @test spkpos(399, 0.0, "J2000", 399) == ([0.0, 0.0, 0.0], 0.0)
    kclear()
end 

