@testset "A" begin
    axis = [0.0, 0.0, 1.0]
    output = axisar(axis, pi/2)
    expected = [0.0 -1.0 0.0; 1.0 0.0 0.0; 0.0 0.0 1.0]
    @test output ≈ expected
end