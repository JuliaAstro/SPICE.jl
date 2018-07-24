import LinearAlgebra

@testset "U" begin
    @test SPICE._ucase("test") == uppercase("test")
    let v1 = randn(3), v2 = randn(3)
        @test SPICE._ucrss(v1, v2) ≈ LinearAlgebra.normalize(LinearAlgebra.cross(v1, v2))
    end
end
