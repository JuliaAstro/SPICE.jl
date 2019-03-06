@testset "C" begin
    @testset "ccifrm" begin
        @test ccifrm(2, 3000) == (13000, "ITRF93", 399)
        @test ccifrm(9999, 3000) === nothing
    end
    @testset "cgv2el" begin
        vec1 = [1.0, 1.0, 1.0]
        vec2 = [1.0, -1.0, 1.0]
        cent = [-1.0, 1.0, -1.0]
        ellipse = cgv2el(cent, vec1, vec2)
        @test center(ellipse) ≈ [-1.0, 1.0, -1.0]
        @test semi_major(ellipse) ≈ [sqrt(2.0), 0.0, sqrt(2.0)]
        @test semi_minor(ellipse) ≈ [0.0, sqrt(2.0), 0.0]
    end
    @testset "chbder" begin
        cp = [1.0, 3.0, 0.5, 1.0, 0.5, -1.0, 1.0]
        x2s = [0.5, 3.0]
        dpdxs = chbder(cp, x2s, 1.0, 3)
        expected = [-0.340878, 0.382716, 4.288066, -1.514403]
        @test dpdxs ≈ expected rtol=1e-6
    end
    @testset "cidfrm" begin
        @test cidfrm(399) == (10013, "IAU_EARTH")
        @test cidfrm(999999) === nothing
    end
    @testset "ckcov" begin
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
    end
    @testset "ckgp" begin
        try
            ck = path(CASSINI, :ck)
            furnsh(ck, path(CASSINI, :sclk), path(CASSINI, :ik),
                   path(CASSINI, :fk), path(CASSINI, :pck))
            ckid = ckobj(ck)[1]
            cover = ckcov(ck, ckid, false, "INTERVAL", 0.0, "SCLK")
            cmat, clkout = ckgp(ckid, cover[1], 256, "J2000")
            expected_cmat = [0.5064665782997639365 -0.75794210739897316387 0.41111478554891744963;
                             -0.42372128242505308071 0.19647683351734512858 0.88422685364733510927;
                             -0.7509672961490383436 -0.6220294331642198804 -0.22164725216433822652]
            @test cmat ≈ expected_cmat
            @test clkout == 267832537952.0
        finally
            kclear()
        end
    end
    @testset "ckgpav" begin
        try
            ck = path(CASSINI, :ck)
            furnsh(ck, path(CASSINI, :sclk), path(CASSINI, :ik),
                   path(CASSINI, :fk), path(CASSINI, :pck))
            ckid = ckobj(ck)[1]
            cover = ckcov(ck, ckid, false, "INTERVAL", 0.0, "SCLK")
            cmat, av, clkout = ckgpav(ckid, cover[1], 256, "J2000")
            expected_cmat = [0.5064665782997639365 -0.75794210739897316387 0.41111478554891744963;
                             -0.42372128242505308071 0.19647683351734512858 0.88422685364733510927;
                             -0.7509672961490383436 -0.6220294331642198804 -0.22164725216433822652]
            expected_av = [-0.00231258422150853885, -0.00190333614370416515, -0.00069657429072504716]
            @test cmat ≈ expected_cmat
            @test av ≈ expected_av
            @test clkout == 267832537952.0
        finally
            kclear()
        end
    end
    @testset "cklpf/ckupf" begin
        file = tempname()
        try
            ifname = "Test CK type 1 segment created by cklpf"
            handle = ckopn(file, ifname, 10)
            ckw01(handle, 1.1, 4.1, -77701, "J2000", "Test type 1 CK segment",
                  [1.1, 4.1], [[1.0, 1.0, 1.0, 1.0], [2.0, 2.0, 2.0, 2.0]],
                  [[0.0, 0.0, 1.0], [0.0, 0.0, 2.0]])
            ckcls(handle)
            kclear()
            handle = cklpf(file)
            ckupf(handle)
            ckcls(handle)
            @test isfile(file)
        finally
            kclear()
        end
    end
    @testset "ckw01" begin
        file = tempname()
        try
            handle = ckopn(file)
            init_size = filesize(file)
            quats = [ones(4), ones(4)]
            avvs = [ones(3), ones(3)]
            sclkdp = [1.0, 2.0]
            ckw01(handle, 1.0, 2.0, -7701, "J2000", "GLL SCAN PLT - DATA TYPE 1", sclkdp, quats, avvs)
            ckcls(handle)
            end_size = filesize(file)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "ckw02" begin
        try
            ck2 = tempname()
            inst = -77702
            maxrec = 201
            secpertick = 0.001
            segid = "test type 2 ck segment"
            ifname = "test ck type 2 segment created by cspice_ckw02"
            ncomch = 0
            ref = "j2000"
            spacing_ticks = 10.0
            spacing_secs = spacing_ticks * secpertick
            rate = 0.01
            handle = ckopn(ck2, ifname, ncomch)
            init_size = filesize(ck2)
            quats = fill([0.0, 0.0, 0.0, 1.0], maxrec)
            av = fill(zeros(3), maxrec)
            rates = fill(secpertick, maxrec)
            sclkdp = collect(1:maxrec) .* spacing_ticks
            sclkdp .+= 1000.0
            starts = sclkdp
            stops = sclkdp .+ (0.8 * spacing_ticks)
            begtime = sclkdp[1]
            endtime = sclkdp[end]
            ckw02(handle, begtime, endtime, inst, ref, segid, starts, stops, quats, av, rates)
            ckcls(handle)
            end_size = filesize(ck2)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "ckw03" begin
        try
            ck3 = tempname()
            inst = -77702
            ref = "j2000"
            maxrec = 201
            secpertick = 0.001
            segid = "test type 3 ck segment"
            ifname = "test ck type 3 segment created by cspice_ckw03"
            spacing_ticks = 10.0
            spacing_secs = spacing_ticks * secpertick
            rate = 0.01
            handle = ckopn(ck3, ifname, 0)
            init_size = filesize(ck3)
            quats = fill([0.0, 0.0, 0.0, 1.0], maxrec)
            sclkdp = collect(1:maxrec) .* spacing_ticks
            sclkdp .+= 1000.0
            starts = sclkdp[1:2:end-1]
            begtime = sclkdp[1]
            endtime = sclkdp[end]
            ckw03(handle, begtime, endtime, inst, ref, segid, sclkdp, quats, starts)
            ckcls(handle)
            end_size = filesize(ck3)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "ckw05" begin
        try
            ck5 = tempname()
            epochs = collect(0.0:1.0)
            inst = [-41000, -41001, -41002, -41003]
            segid = "ck type 05 test segment"
            avflag = true
            type0data = [[ 9.999e-1, -1.530e-4, -8.047e-5, -4.691e-4, 0.0, 0.0, 0.0, 0.0],
                         [9.999e-1, -4.592e-4, -2.414e-4, -1.407e-3,
                          -7.921e-10, -1.616e-7, -8.499e-8,  -4.954e-7]]
            type1data = [[ 9.999e-1, -1.530e-4, -8.047e-5, -4.691e-4],
                         [9.999e-1, -4.592e-4, -2.414e-4, -1.407e-3]]
            type2data = [[0.959, -0.00015309, -8.0476e-5, -0.00046913,
                          0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
                         [0.959, -0.00045928, -0.00024143, -0.0014073,
                          -7.921e-10, -1.616e-7, -8.499e-8, -4.954e-7,
                          3.234e-7, 1.7e-7, 9.91e-7, 3.234e-7, 1.7e-9, 9.91e-9]]
            type3data = [[0.959, -0.00015309, -8.0476e-05, -0.00046913, 0.0, 0.0, 0.0],
                         [0.959, -0.00045928, -0.00024143, -0.0014073, 3.234e-7, 1.7e-7, 9.91e-7]]

            handle = ckopn(ck5, " ", 0)
            init_size = filesize(ck5)
            # test subtype 0
            ckw05(handle, 0, 15, epochs[1], epochs[end], inst[1], "j2000", avflag, segid, epochs,
                  type0data, 1000.0, 1, epochs)
            # test subtype 1
            ckw05(handle, 1, 15, epochs[1], epochs[end], inst[2], "j2000", avflag, segid, epochs,
                  type1data, 1000.0, 1, epochs)
            # test subtype 2
            ckw05(handle, 2, 15, epochs[1], epochs[end], inst[3], "j2000", avflag, segid, epochs,
                  type2data, 1000.0, 1, epochs)
            # test subtype 3
            ckw05(handle, 3, 15, epochs[1], epochs[end], inst[4], "j2000", avflag, segid, epochs,
                  type3data, 1000.0, 1, epochs)
            ckcls(handle)

            end_size = filesize(ck5)
            @test end_size != init_size
            furnsh(ck5)
            cmat, av, clk = ckgpav(-41000, epochs[1 ]+ 0.5, 1.0, "j2000")
            @test clk ≈ 0.5
        finally
            kclear()
        end
    end
    @testset "clight" begin
        @test clight() == 299792.458
    end
    @testset "clpool" begin
        pdpool("test", [1.0, 2.0, 3.0])
        clpool()
        @test gdpool("test") === nothing
    end
    @testset "cmprss" begin
        s = "1,,2,,,3,,,,"
        @test cmprss(',', 1, s) == "1,2,3,"
        @test cmprss(",", 2, s) == "1,,2,,3,,"
        @test cmprss(",", 3, s) == "1,,2,,,3,,,"
    end
    @testset "cnmfrm" begin
        @test cnmfrm("norbert") === nothing
        code, name = cnmfrm("IO")
        @test code == 10023
        @test name == "IAU_IO"
    end
    @testset "conics" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk), path(CORE, :gm_pck))
            et = str2et("Dec 25, 2007")
            state, ltime = spkezr("Moon", et, "J2000", "NONE", "EARTH")
            mu = bodvrd("EARTH", "GM")[1]
            elts = oscelt(state, et, mu)
            later = et + 7.0 * spd()
            later_state = conics(elts, later)
            state, ltime = spkezr("Moon", later, "J2000", "NONE", "EARTH")
            pert = later_state .- state
            expected_pert = [-7.48885583081946242601e+03,
                            3.97608014470621128567e+02,
                            1.95744667259379639290e+02,
                            -3.61527427787390887026e-02,
                            -1.27926899069508159812e-03,
                            -2.01458906615054056388e-03]
            @test expected_pert ≈ pert
        finally
            kclear()
        end
    end
    @testset "convrt" begin
        @test convrt(300.0, "statute_miles", "km") == 482.8032
        @test convrt(1.0, "parsecs", "lightyears") ≈ 3.2615638
        @test_throws SpiceError convrt(1.0, "parsecs", "hours")
        @test_throws SpiceError convrt(1.0, "parsecs", "norbert")
    end
    @testset "cpos/cposr" begin
        string = "BOB, JOHN, TED, AND MARTIN...."
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
    @testset "cvpool" begin
        try
            pdpool("TEST_VAR_CVPOOL", [-646.0])
            swpool("TEST_CVPOOL", ["TEST_VAR_CVPOOL"])
            pdpool("TEST_VAR_CVPOOL", [565.0])
            updated = cvpool("TEST_CVPOOL")
            @test updated
            clpool()
        finally
            kclear()
        end
    end
    @testset "cyllat" begin
        @test collect(cyllat(1.0, deg2rad(180.0), -1.0)) ≈ [sqrt(2), π, -π/4.0]
    end
    @testset "cylrec" begin
        @test cylrec(0.0, deg2rad(33.0), 0.0) ≈ [0.0, 0.0, 0.0]
    end
    @testset "cylsph" begin
        @test collect(cylsph(1.0, deg2rad(180.0), 1.0)) ≈ [1.4142, deg2rad(45.0), deg2rad(180.0)] rtol=1e-4
    end
end

