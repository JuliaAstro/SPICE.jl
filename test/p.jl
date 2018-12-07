using LinearAlgebra: I

@testset "P" begin
    # @testset "pckcov" begin
    #     try
    #         ids = SpiceIntCell(1000)
    #         cover = SpiceDoubleCell(2000)
    #         pckfrm!(ids, path(EXTRA, :earth_high_per_pck))
    #         scard!(cover, 0)
    #         pckcov(path(EXTRA, :earth_high_per_pck), ids[1], cover)
    #         expected = [94305664.18380372, 757080064.1838132]
    #         @test cover ≈ expected
    #     finally
    #         kclear()
    #     end
    # end
    # @testset "pckfrm" begin
    #     try
    #         ids = SpiceIntCell(1000)
    #         pckfrm!(ids, path(EXTRA, :earth_high_per_pck))
    #         @test ids[1] == 3000
    #     finally
    #         kclear()
    #     end
    # end
    @test pxform("J2000", "J2000", 0.) ≈ Matrix{Float64}(I, 3, 3)
    @test_throws SpiceError pxform("Norbert", "J2000",0.)
end
