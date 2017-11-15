@testset "C" begin
    @test ccifrm(2, 3000) == (13000, "ITRF93", 399)
    @test_throws SpiceException ccifrm(9999, 3000)

    @test cidfrm(399) == (10013, "IAU_EARTH")
    @test_throws SpiceException cidfrm(999999)

    file = "test.ck"
    try
        handle = ckopn(file)
        quats = reshape(collect(1.0:8.0), 4, 2)
        avvs = reshape(collect(1.0:6.0), 3, 2)
        sclkdp = [1.0, 2.0]
        ckw01(handle, -7701, "J2000", "GLL SCAN PLT - DATA TYPE 1", sclkdp, quats, avvs)
        ckcls(handle)
    finally
        rm(file, force=true)
    end
end
