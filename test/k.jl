@testset "K" begin 
    furnsh(path(CORE, :pck))
    @test  ktotal("ALL") == 1
    kclear() 
    @test ktotal("ALL") == 0
end 