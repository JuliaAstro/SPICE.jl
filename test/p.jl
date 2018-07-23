using LinearAlgebra: I

@testset "P" begin
    @test pxform("J2000", "J2000", 0.) ≈ Matrix{Float64}(I, 3, 3)
    @test_throws SpiceException pxform("Norbert", "J2000",0.)
end
