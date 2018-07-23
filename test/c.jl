using Random: randstring

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
        sclk = path(CASSINI, :sclk)
        ck = path(CASSINI, :ck)
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

    try
        ck = path(CASSINI, :ck)
        furnsh(
            ck,
            path(CASSINI, :sclk),
            path(CASSINI, :ik),
            path(CASSINI, :fk),
            path(CASSINI, :pck),
        )
        ckid = ckobj(ck)[1]
        cover = ckcov(ck, ckid, false, "INTERVAL", 0.0, "SCLK")
        cmat, clkout, found = ckgp(ckid, cover[1], 256, "J2000")
        expected_cmat = [
            0.5064665782997639365 -0.75794210739897316387  0.41111478554891744963
            -0.42372128242505308071  0.19647683351734512858  0.88422685364733510927
            -0.7509672961490383436  -0.6220294331642198804 -0.22164725216433822652
        ]
        @test cmat ≈ expected_cmat
        @test clkout == 267832537952.0
        @test found
    finally
        kclear()
    end

    try
        ck = path(CASSINI, :ck)
        furnsh(
            ck,
            path(CASSINI, :sclk),
            path(CASSINI, :ik),
            path(CASSINI, :fk),
            path(CASSINI, :pck),
        )
        ckid = ckobj(ck)[1]
        cover = ckcov(ck, ckid, false, "INTERVAL", 0.0, "SCLK")
        cmat, av, clkout, found = ckgpav(ckid, cover[1], 256, "J2000")
        expected_cmat = [
            0.5064665782997639365 -0.75794210739897316387  0.41111478554891744963
            -0.42372128242505308071  0.19647683351734512858  0.88422685364733510927
            -0.7509672961490383436  -0.6220294331642198804 -0.22164725216433822652
        ]
        expected_av = [-0.00231258422150853885, -0.00190333614370416515, -0.00069657429072504716]
        @test cmat ≈ expected_cmat
        @test av ≈ expected_av
        @test clkout == 267832537952.0
        @test found
    finally
        kclear()
    end

    let CKLPF = tempfile()
        try
            ifname = "Test CK type 1 segment created by cklpf"
            handle = ckopn(CKLPF, ifname, 10)
            ckw01(handle, -77701, "J2000", "Test type 1 CK segment",
                [1.1, 4.1], [1.0 1.0 1.0 1.0; 2.0 2.0 2.0 2.0],
                [0.0 0.0 1.0; 0.0 0.0 2.0])
            ckcls(handle)
            kclear()
            handle = cklpf(CKLPF)
            ckupf(handle)
            ckcls(handle)
            @test isfile(CKLPF)
        finally
            kclear()
            rm(CKLPF, force=true)
        end
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
