@testset "K" begin 
    furnsh(path(:PCK))
    @test  ktotal("ALL") == 1
    kclear() 
    @test ktotal("ALL") == 0
end 