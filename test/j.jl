@testset "J" begin
    @test j1900() == 2415020.0
    @test j1950() == 2433282.5
    @test j2000() == 2451545.0
    @test j2100() == 2488070.0
    @test jyear() == 31557600.0
end