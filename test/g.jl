@testset "G" begin
    exp = collect(1.0:10.0)
    pdpool("array", exp)
    act = gdpool("array")
    @test exp == act
    act = gdpool("array", start=8)
    @test [8.0, 9.0, 10.0] == act
    act = gdpool("array", room=8)
    @test collect(1.0:8.0) == act
    @test gdpool("norbert") === nothing
    kclear()
end
