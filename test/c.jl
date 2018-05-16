@testset "C" begin
    @test ccifrm(2, 3000) == (13000, "ITRF93", 399)
    @test_throws SpiceException ccifrm(9999, 3000)

    @test cidfrm(399) == (10013, "IAU_EARTH")
    @test_throws SpiceException cidfrm(999999)

    @test clight() == 299792.458

    let vec1 = [1.0, 1.0, 1.0],
        vec2 = [1.0, -1.0, 1.0],
        cent = [-1.0, 1.0, -1.0]
        ellipse = cgv2el(cent, vec1, vec2)
        @test center(ellipse) ≈ [-1.0, 1.0, -1.0]
        @test semi_major(ellipse) ≈ [sqrt(2.0), 0.0, sqrt(2.0)]
        @test semi_minor(ellipse) ≈ [0.0, sqrt(2.0), 0.0]
    end

    try
        sclk = path(CASSINI, :cass_sclk)
        ck = path(CASSINI, :cass_ck)
        furnsh(sclk)
        ckid = ckobj(ck)[1]
        @test length(ckid) == 1
        cover = ckcov(ck, ckid, false, "INTERVAL", 0.0, "SCLK")
        @test cover[1:2] ≈ [267832537952.000000, 267839247264.000000]
        @test cover[3:4] ≈ [267839256480.000000, 267867970464.000000]
        @test cover[5:6] ≈ [267868006304.000000, 267876773792.000000]
    finally
        kclear()
    end

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
