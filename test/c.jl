using Random: randstring

@testset "C" begin
    @test ccifrm(2, 3000) == (13000, "ITRF93", 399)
    @test_throws SpiceError ccifrm(9999, 3000)

    @test cidfrm(399) == (10013, "IAU_EARTH")
    @test_throws SpiceError cidfrm(999999)

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

    let file = tempfile()
        try
            ifname = "Test CK type 1 segment created by cklpf"
            handle = ckopn(file, ifname, 10)
            ckw01(handle, -77701, "J2000", "Test type 1 CK segment",
                [1.1, 4.1], [1.0 1.0 1.0 1.0; 2.0 2.0 2.0 2.0],
                [0.0 0.0 1.0; 0.0 0.0 2.0])
            ckcls(handle)
            kclear()
            handle = cklpf(file)
            ckupf(handle)
            ckcls(handle)
            @test isfile(file)
        finally
            kclear()
            rm(file, force=true)
        end
    end

    let file = tempfile()
        try
            handle = ckopn(file)
            quats = reshape(collect(1.0:8.0), 4, 2)
            avvs = reshape(collect(1.0:6.0), 3, 2)
            sclkdp = [1.0, 2.0]
            ckw01(handle, -7701, "J2000", "GLL SCAN PLT - DATA TYPE 1", sclkdp, quats, avvs)
            ckcls(handle)
        finally
            kclear()
            rm(file, force=true)
        end
    end

    pdpool("test", [1.0, 2.0, 3.0])
    clpool()
    @test gdpool("test") === nothing

    let s = "1,,2,,,3,,,,"
        @test cmprss(',', 1, s) == "1,2,3,"
        @test cmprss(",", 2, s) == "1,,2,,3,,"
        @test cmprss(",", 3, s) == "1,,2,,,3,,,"
    end

    @test cnmfrm("norbert") === nothing
    let
        code, name = cnmfrm("IO")
        @test code == 10023
        @test name == "IAU_IO"
    end

    furnsh(path(CORE, :lsk), path(CORE, :spk), path(CORE, :gm_pck))
    let
        et = str2et("Dec 25, 2007")
        state, ltime = spkezr("Moon", et, "J2000", "EARTH")
        mu = bodvrd("EARTH", "GM")[1]
        elts = oscelt(state, et, mu)
        later = et + 7.0 * spd()
        later_state = conics(elts, later)
        state, ltime = spkezr("Moon", later, "J2000", "EARTH")
        pert = later_state .- state
        expected_pert = [-7.48885583081946242601e+03,
                        3.97608014470621128567e+02,
                        1.95744667259379639290e+02,
                        -3.61527427787390887026e-02,
                        -1.27926899069508159812e-03,
                        -2.01458906615054056388e-03]
        @test expected_pert ≈ pert
    end
    kclear()

    @test convrt(300.0, "statute_miles", "km") == 482.8032
    @test convrt(1.0, "parsecs", "lightyears") ≈ 3.2615638
    @test_throws SpiceError convrt(1.0, "parsecs", "hours")
    @test_throws SpiceError convrt(1.0, "parsecs", "norbert")

    let string = "BOB, JOHN, TED, AND MARTIN...."
        @test cpos(string, " ,", 1) == 4
        @test cpos(string, " ,", 5) == 5
        @test cpos(string, " ,", 6) == 10
        @test cpos(string, " ,", 11) == 11
        @test cpos(string, " ,", 12) == 15
        @test cpos(string, " ,", 16) == 16
        @test cpos(string, " ,", 17) == 20
        @test cpos(string, " ,", 21) == -1
        @test cpos(string, " ,", -112) == 4
        @test cpos(string, " ,", -1) == 4
        @test cpos(string, " ,", 1230) == -1

        @test cposr(string, " ,", 30) == 20
        @test cposr(string, " ,", 26) == 20
        @test cposr(string, " ,", 19) == 16
        @test cposr(string, " ,", 15) == 15
        @test cposr(string, " ,", 14) == 11
        @test cposr(string, " ,", 10) == 10
        @test cposr(string, " ,", 9) == 5
        @test cposr(string, " ,", 4) == 4
        @test cposr(string, " ,", 3) == -1
        @test cposr(string, " ,", 231) == 20
        @test cposr(string, " ,", 31) == 20
        @test cposr(string, " ,", -1) == -1
        @test cposr(string, " ,", -10) == -1
    end

    pdpool("TEST_VAR_CVPOOL", [-646.0])
    swpool("TEST_CVPOOL", ["TEST_VAR_CVPOOL"])
    pdpool("TEST_VAR_CVPOOL", [565.0])
    updated = cvpool("TEST_CVPOOL")
    @test updated
    clpool()
    kclear()

    @test collect(cyllat(1.0, deg2rad(180.0), -1.0)) ≈ [sqrt(2), π, -π/4.0]
    @test cylrec(0.0, deg2rad(33.0), 0.0) ≈ [0.0, 0.0, 0.0]
    @test collect(cylsph(1.0, deg2rad(180.0), 1.0)) ≈ [1.4142, deg2rad(45.0), deg2rad(180.0)] rtol=1e-4
end

