@testset "F" begin
    # TODO: code doesnt work (problem with kernels), needs to be modified
    kclear()
    furnsh(path(CORE, :pck),path(CORE, :spk),path(CORE, :gm_pck),path(CORE, :lsk))
    @test ktotal("ALL") == 4
    kclear()
end 