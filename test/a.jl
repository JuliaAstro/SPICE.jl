@testset "A" begin
    axis = [0.0, 0.0, 1.0]
    output = axisar(axis, π/2)
    expected = [0.0 -1.0 0.0; 1.0 0.0 0.0; 0.0 0.0 1.0]
    @test output ≈ expected
    @test_throws ArgumentError axisar(axis[1:2], π/2)
end
