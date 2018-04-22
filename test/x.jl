@testset "X" begin 
    furnsh(path(:PCK))
    sx = sxform("J2000", "IAU_JUPITER", 0.0)
    eulang, unique = xf2eul(sx, 3, 1, 3)
    @test round.(eulang.*100000)./100000 == [-3.10768, 0.44513, -1.83172, -0.0, 0.0, 0.0]
    @test_throws SpiceException xf2eul(sx, 4, 1, 4)
    unload(path(:PCK))
end 