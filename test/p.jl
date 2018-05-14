@testset "P" begin 
    @test pxform("J2000", "J2000", 0.) ≈ eye(3)
    @test_throws SpiceException pxform("Norbert", "J2000",0.)
end 