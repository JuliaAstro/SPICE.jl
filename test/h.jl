@testset "H" begin
    @test hx2dp("2A^3") == 672.0
    @test_throws SpiceException hx2dp("2A^3000")
    @test_throws SpiceException hx2dp("-2A^3000")
    @test_throws SpiceException hx2dp("foo")
    @test SPICE._halfpi() ≈ π/2
end
