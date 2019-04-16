using LinearAlgebra: I, norm, cross, normalize

@testset "S" begin
    @testset "saelgv" begin
        vec1 = [1.0, 1.0, 1.0]
        vec2 = [1.0, -1.0, 1.0]
        expected_smajor = [sqrt(2.0), 0.0, sqrt(2.0)]
        expected_sminor = [0.0, sqrt(2.0), 0.0]
        smajor, sminor = saelgv(vec1, vec2)
        @test smajor ≈ expected_smajor
        @test sminor ≈ expected_sminor
    end
    @testset "scard" begin
        cell = SpiceDoubleCell(10)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        @test card(cell) == 0
        for w in darray
            wninsd!(cell, w...)
        end
        @test card(cell) == 6
        scard!(cell, 0)
        @test card(cell) == 0
    end
    @testset "scdecd" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            timein = scencd(-32, "2/20538:39:768")
            sclkch = scdecd(-32, timein)
            @test sclkch == "2/20538:39:768"
        finally
            kclear()
        end
    end
    @testset "sce2c" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            et = str2et("1979 JUL 05 21:50:21.23379")
            sclkdp = sce2c(-32, et)
            @test sclkdp ≈ 985327949.9999709
        finally
            kclear()
        end
    end
    @testset "sce2s" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            et = str2et("1979 JUL 05 21:50:21.23379")
            sclkch = sce2s(-32, et)
            @test sclkch == "2/20538:39:768"
        finally
            kclear()
        end
    end
    @testset "sce2t" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            et = str2et("1979 JUL 05 21:50:21.23379")
            sclkdp = sce2t(-32, et)
            @test sclkdp ≈ 985327950.0
        finally
            kclear()
        end
    end
    @testset "scfmt" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            pstart, pstop = scpart(-32)
            start = scfmt(-32, pstart[1])
            stop = scfmt(-32, pstop[1])
            @test start == "00011:00:001"
            @test stop == "04011:21:784"
        finally
            kclear()
        end
    end
    @testset "scs2e" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            et = scs2e(-32, "2/20538:39:768")
            @test et ≈ -646668528.58222842
            utc = et2utc(et, "C", 3)
            @test utc == "1979 JUL 05 21:50:21.234"
        finally
            kclear()
        end
    end
    @testset "sct2e" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            et = sct2e(-32, 985327965.0)
            utc = et2utc(et, "C", 3)
            @test utc == "1979 JUL 05 21:50:22.134"
        finally
            kclear()
        end
    end
    @testset "sctiks" begin
        try
            furnsh(path(CORE, :lsk), path(EXTRA, :voyager_sclk))
            ticks = sctiks(-32, "20656:14:768")
            @test ticks == 991499967.0
        finally
            kclear()
        end
    end
    @testset "sdiff" begin
        # SPICEINT_CELL
        a = SpiceIntCell(8)
        b = SpiceIntCell(8)
        insrti!(a, 1)
        insrti!(a, 2)
        insrti!(a, 5)
        insrti!(b, 3)
        insrti!(b, 4)
        insrti!(b, 5)
        c = sdiff(a, b)
        @test c == [1, 2, 3, 4]
        # SPICECHAR_CELL
        a = SpiceCharCell(8, 8)
        b = SpiceCharCell(8, 8)
        insrtc!(a, "1")
        insrtc!(a, "2")
        insrtc!(a, "5")
        insrtc!(b, "3")
        insrtc!(b, "4")
        insrtc!(b, "5")
        c = sdiff(a, b)
        @test c == ["1", "2", "3", "4"]
        # SPICEDOUBLE_CELL
        a = SpiceDoubleCell(8)
        b = SpiceDoubleCell(8)
        insrtd!(a, 1.0)
        insrtd!(a, 2.0)
        insrtd!(a, 5.0)
        insrtd!(b, 3.0)
        insrtd!(b, 4.0)
        insrtd!(b, 5.0)
        c = sdiff(a, b)
        @test c == [1.0, 2.0, 3.0, 4.0]
    end
    @testset "set" begin
        a = SpiceIntCell(8)
        b = SpiceIntCell(8)
        c = SpiceIntCell(8)
        insrti!(a, 1)
        insrti!(a, 2)
        insrti!(a, 3)
        insrti!(a, 4)
        insrti!(b, 1)
        insrti!(b, 3)
        insrti!(c, 1)
        insrti!(c, 3)
        @test set(b, "=", c)
        @test set(a, "<>", c)
        @test set(b, "<=", c)
        @test !set(b, "<", c)
        @test set(c, ">=", b)
        @test set(a, ">", b)
        @test set(b, "&", c)
        @test !set(a, "~", a)
    end
    @testset "shellc" begin
        array = ["FEYNMAN", "NEWTON", "EINSTEIN", "GALILEO", "EUCLID", "Galileo"]
        expected = ["EINSTEIN", "EUCLID", "FEYNMAN", "GALILEO", "Galileo", "NEWTON"]
        actual = sort(array)
        @test actual == expected
        @test SPICE._shellc(array) == expected
    end
    @testset "shelld" begin
        array = [99.0, 33.0, 55.0, 44.0, -77.0, 66.0]
        expected = [-77.0, 33.0, 44.0, 55.0, 66.0, 99.0]
        actual = sort(array)
        @test actual == expected
        @test SPICE._shelld(array) == expected
    end
    @testset "shelli" begin
        array = [99, 33, 55, 44, -77, 66]
        expected = [-77, 33, 44, 55, 66, 99]
        actual = sort(array)
        @test actual == expected
        @test SPICE._shelli(array) == expected
    end
    @testset "sincpt" begin
        try
            # load kernels
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk),
                   path(CASSINI, :pck),
                   path(CASSINI, :sat_spk),
                   path(CASSINI, :tour_spk),
                   path(CASSINI, :fk),
                   path(CASSINI, :ck),
                   path(CASSINI, :sclk),
                   path(CASSINI, :ik))
            # start test
            et = str2et("2013 FEB 25 11:50:00 UTC")
            camid = bodn2c("CASSINI_ISS_NAC")
            shape, frame, bsight, bounds = getfov(camid, 4)
            # run sincpt on boresight vector
            spoint, trgepc, obspos = sincpt("ELLIPSOID", "ENCELADUS", et, "IAU_ENCELADUS", "CN+S",
                                            "CASSINI", frame, bsight)
            @test trgepc ≈ 415065064.9055491
            expected_spoint = [-143.56046004007180272311, 202.90045955888857065474,
                               -27.99454300594213052022]
            expected_obspos = [-329794.62202281970530748367, -557628.89673861570190638304,
                               217721.3870436516881454736]
            @test spoint ≈ expected_spoint
            @test obspos ≈ expected_obspos
        finally
            kclear()
        end
    end
    @testset "spd" begin
        @test spd() == 86400.0
    end
    @testset "sphcyl" begin
        a = collect(sphcyl(1.4142, deg2rad(180.0), deg2rad(45.0)))
        b = [0.0, deg2rad(45.0), -sqrt(2)]
        @test a ≈ b atol=1e-4
    end
    @testset "sphlat" begin
        result = collect(sphlat(1.0, π, π/2))
        expected = [0.0, π/2, -1.0]
        @test result ≈ expected
    end
    @testset "sphrec" begin
        expected1 = [0.0, 0.0, 0.0]
        expected2 = [1.0, 0.0, 0.0]
        expected3 = [0.0, 0.0, -1.0]
        @test sphrec(0.0, 0.0, 0.0) ≈ expected1
        @test sphrec(1.0, deg2rad(90.0), 0.0) ≈ expected2
        @test sphrec(1.0, deg2rad(180.0), 0.0) ≈ expected3
    end
    @testset "spk14a" begin
        discrete_epochs = [100.0, 200.0, 300.0, 400.0]
        cheby_coeffs14 = [150.0, 50.0, 1.0101, 1.0102, 1.0103, 1.0201, 1.0202, 1.0203, 1.0301,
                          1.0302, 1.0303, 1.0401, 1.0402, 1.0403, 1.0501, 1.0502, 1.0503, 1.0601,
                          1.0602, 1.0603, 250.0, 50.0, 2.0101, 2.0102, 2.0103, 2.0201, 2.0202,
                          2.0203, 2.0301, 2.0302, 2.0303, 2.0401, 2.0402, 2.0403, 2.0501, 2.0502,
                          2.0503, 2.0601, 2.0602, 2.0603, 350.0, 50.0, 3.0101, 3.0102, 3.0103,
                          3.0201, 3.0202, 3.0203, 3.0301, 3.0302, 3.0303, 3.0401, 3.0402, 3.0403,
                          3.0501, 3.0502, 3.0503, 3.0601, 3.0602, 3.0603, 450.0, 50.0, 4.0101,
                          4.0102, 4.0103, 4.0201, 4.0202, 4.0203, 4.0301, 4.0302, 4.0303, 4.0401,
                          4.0402, 4.0403, 4.0501, 4.0502, 4.0503, 4.0601, 4.0602, 4.0603]
        spk14 = tempname()
        try
            handle = spkopn(spk14, "Type 14 SPK internal file name.", 1024)
            init_size = filesize(spk14)
            spk14b(handle, "SAMPLE_SPK_TYPE_14_SEGMENT", 399, 0, "J2000", 100.0, 400.0, 2)
            spk14a(handle, 4, cheby_coeffs14, discrete_epochs)
            spk14e(handle)
            spkcls(handle)
            end_size = filesize(spk14)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkacs" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("2000 JAN 1 12:00:00 TDB")
            state, lt, dlt = spkacs(301, et, "J2000", "LT+S", 399)
            expected_state = [-2.91584616594972088933e+05, -2.66693402359092258848e+05,
                              -7.60956475582799030235e+04,  6.43439144942984264652e-01,
                              -6.66065882529007446955e-01, -3.01310065348405708985e-01]
            expected_lt = 1.3423106103603615
            expected_dlt = 1.073169085424106e-07
            @test expected_lt ≈ lt
            @test expected_dlt ≈ dlt rtol=1e-6
            @test state ≈ expected_state
        finally
            kclear()
        end
    end
    @testset "spkapo" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            mars = 499
            moon = 301
            epoch = "JAN 1 2004 5:00 PM"
            ref = "J2000"
            abcorr = "LT+S"
            et = str2et(epoch)
            state = spkssb(moon, et, ref)
            pos_vec, ltime = spkapo(mars, et, ref, state, abcorr)
            expected_pos = [1.64534472413454592228e+08, 2.51219951337271928787e+07,
                           1.11454124484200235456e+07]
            @test pos_vec ≈ expected_pos
        finally
            kclear()
        end
    end
    @testset "spkaps" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("2000 JAN 1 12:00:00 TDB")
            stobs = spkssb(399, et, "J2000")
            state0 = spkssb(399, et - 1, "J2000")
            state2 = spkssb(399, et + 1, "J2000")
            acc = 0.5 / 1.0 .* (state0 .+ 3.0) .- 0.5 / 1.0 .* (state2 .+ 3.0)
            acc = [acc[1], acc[2], acc[3], 0.0, 0.0, 0.0]
            state, lt, dlt = spkaps(301, et, "J2000", "LT+S", stobs, acc)
            expected_lt = 1.3423106103603615
            expected_dlt = 1.073169085424106e-07
            expected_state = [-2.91584616594972088933e+05, -2.66693402359092258848e+05,
                             -7.60956475582799030235e+04, 1.59912685775666059129e+01,
                             -1.64471169612870582455e+01, -3.80333369259831766129e+00]
            @test lt ≈ expected_lt
            @test dlt ≈ expected_dlt rtol=1e-6
            @test state ≈ expected_state
        finally
            kclear()
        end
    end
    @testset "spkcov" begin
        try
            spk = path(CORE, :spk)
            ids = SpiceIntCell(1000)
            spkobj!(ids, spk)
            temp_obj = ids[1]

            cover = SpiceDoubleCell(2000)
            spkcov!(cover, spk, temp_obj)

            expected = [-94651137.81606464, 315662463.18395346]
            @test cover ≈ expected
        finally
            kclear()
        end
    end
    @testset "spkcpo" begin
        try
            furnsh(path(EXTRA, :earth_stn_spk),
                   path(EXTRA, :earth_high_per_pck),
                   path(EXTRA, :earth_topo_tf),
                   path(CORE, :lsk), path(CORE, :spk))
            et = str2et("2003 Oct 13 06:00:00")
            obspos = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439]
            state, lt = spkcpo("SUN", et, "DSS-14_TOPO", "OBSERVER", "CN+S", obspos, "EARTH", "ITRF93")
            expected_lt = 497.93167787805714
            expected_state = [6.25122733012810498476e+07,   5.89674929926417097449e+07,
                             -1.22059095879866167903e+08,   2.47597313358008614159e+03,
                             -9.87026711803482794494e+03,  -3.49990805659246507275e+03]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
            @test_throws ArgumentError spkcpo("SUN", et, "DSS-14_TOPO", "OBSERVER", "CN+S", obspos[1:2],
                                              "EARTH", "ITRF93")
        finally
            kclear()
        end
    end
    @testset "spkcpt" begin
        try
            furnsh(path(EXTRA, :earth_stn_spk),
                   path(EXTRA, :earth_high_per_pck),
                   path(EXTRA, :earth_topo_tf),
                   path(CORE, :lsk), path(CORE, :spk))
            obstime = str2et("2003 Oct 13 06:00:00")
            trgpos = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439]
            state, lt = spkcpt(trgpos, "EARTH", "ITRF93", obstime, "ITRF93", "TARGET", "CN+S", "SUN")
            expected_lt = 497.9321928250503
            expected_state = [-3.41263006568005401641e+06, -1.47916331564148992300e+08,
                              1.98124035009580813348e+07,  -1.07582448117249587085e+04,
                              2.50028331500427839273e+02,   1.11355285621842696742e+01]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
            @test_throws ArgumentError spkcpt(trgpos[1:2], "EARTH", "ITRF93", obstime, "ITRF93",
                                              "TARGET", "CN+S", "SUN")
        finally
            kclear()
        end
    end
    @testset "spkcvo" begin
        try
            furnsh(path(EXTRA, :earth_stn_spk),
                   path(EXTRA, :earth_high_per_pck),
                   path(EXTRA, :earth_topo_tf),
                   path(CORE, :lsk), path(CORE, :spk))
            obstime = str2et("2003 Oct 13 06:00:00")
            obstate = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439,
                       -0.00000000000057086, 0.00000000000020549, -0.00000000000012171]
            state, lt = spkcvo("SUN", obstime, "DSS-14_TOPO", "OBSERVER", "CN+S", obstate, 0.0,
                               "EARTH", "ITRF93")
            expected_lt = 497.93167787798325
            expected_state = [6.25122733012975975871e+07,   5.89674929925705492496e+07,
                             -1.22059095879864960909e+08,   2.47597313358015026097e+03,
                             -9.87026711803497346409e+03,  -3.49990805659256830040e+03]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
            @test_throws ArgumentError spkcvo("SUN", obstime, "DSS-14_TOPO", "OBSERVER", "CN+S",
                                              obstate[1:5], 0.0, "EARTH", "ITRF93")
        finally
            kclear()
        end
    end
    @testset "spkcvt" begin
        try
            furnsh(path(EXTRA, :earth_stn_spk),
                   path(EXTRA, :earth_high_per_pck),
                   path(EXTRA, :earth_topo_tf),
                   path(CORE, :lsk), path(CORE, :spk))
            obstime = str2et("2003 Oct 13 06:00:00")
            trgstate = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439,
                        -0.00000000000057086, 0.00000000000020549, -0.00000000000012171]
            state, lt = spkcvt(trgstate, 0.0, "EARTH", "ITRF93", obstime,
                               "ITRF93", "TARGET", "CN+S", "SUN")
            expected_lt = 497.932192824968
            expected_state = [-3.41263006574816117063e+06,  -1.47916331564124494791e+08,
                              1.98124035009435638785e+07,  -1.07582448117247804475e+04,
                              2.50028331500423831812e+02,   1.11355285621839659171e+01]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
            @test_throws ArgumentError spkcvt(trgstate[1:5], 0.0, "EARTH", "ITRF93", obstime,
                                              "ITRF93", "TARGET", "CN+S", "SUN")
        finally
            kclear()
        end
    end
    @testset "spkez" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("July 4, 2003 11:00 AM PST")
            state, lt = spkez(499, et, "J2000", "LT+S", 399)
            expected_lt = 269.6898813661505
            expected_state = [7.38222353105354905128e+07, -2.71279189984722770751e+07,
                              -1.87413063014898747206e+07, -6.80851334001380692484e+00,
                              7.51399612408221173609e+00, 3.00129849265935222391e+00]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
        finally
            kclear()
        end
    end
    @testset "spkezp" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("July 4, 2003 11:00 AM PST")
            pos, lt = spkezp(499, et, "J2000", "LT+S", 399)
            expected_lt = 269.6898813661505
            expected_pos = [73822235.31053550541400909424, -27127918.99847228080034255981,
                            -18741306.30148987472057342529]
            @test lt ≈ expected_lt
            @test pos ≈ expected_pos
        finally
            kclear()
        end
    end
    @testset "spkezr" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("July 4, 2003 11:00 AM PST")
            state, lt = spkezr("Mars", et, "J2000", "LT+S", "Earth")
            expected_lt = 269.6898813661505
            expected_state = [7.38222353105354905128e+07,  -2.71279189984722770751e+07,
                              -1.87413063014898747206e+07,  -6.80851334001380692484e+00,
                               7.51399612408221173609e+00,   3.00129849265935222391e+00]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
        finally
            kclear()
        end
    end
    @testset "spkgeo" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("July 4, 2003 11:00 AM PST")
            state, lt = spkgeo(499, et, "J2000", 399)
            expected_lt = 269.70264751151603
            expected_state = [7.38262164145559966564e+07, -2.71280305524311661720e+07,
                              -1.87419738849752545357e+07, -6.80950358877040429206e+00,
                              7.51381423681132254444e+00, 3.00129002640705921934e+00]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
        finally
            kclear()
        end
    end
    @testset "spkgps" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("July 4, 2003 11:00 AM PST")
            pos, lt = spkgps(499, et, "J2000", 399)
            expected_lt = 269.70264751151603
            expected_pos = [73826216.41455599665641784668, -27128030.55243116617202758789,
                            -18741973.88497525453567504883]
            @test lt ≈ expected_lt
            @test pos ≈ expected_pos
        finally
            kclear()
        end
    end
    @testset "spklef" begin
        try
            handle = spklef(path(CORE, :spk))
            @test handle != -1
            spkuef(handle)
        finally
            kclear()
        end
    end
    @testset "spkltc" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("2000 JAN 1 12:00:00 TDB")
            stobs = spkssb(399, et, "J2000")
            state, lt, dlt = spkltc(301, et, "J2000", "LT", stobs)
            expected_lt = 1.342310610325
            expected_dlt = 1.07316909e-07
            expected_state = [-2.91569268313527107239e+05, -2.66709183005481958389e+05,
                              -7.60991494675353169441e+04, 6.43530600728670520994e-01,
                              -6.66081825882520739412e-01, -3.01322833716675120286e-01]
            @test dlt ≈ expected_dlt rtol=1e-6
            @test lt ≈ expected_lt
            @test state ≈ expected_state
            @test_throws ArgumentError spkltc(301, et, "J2000", "LT", stobs[1:5])
        finally
            kclear()
        end
    end
    @testset "spkopa" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            file = tempname()
            et = str2et("2002 APR 27 00:00:00.000 TDB")
            # load subset from kernels
            handle, descr, ident = spksfs(5, et)
            body, center, frame, otype, first, last, start, stop = spkuds(descr)
            # create empty spk kernel
            handle_test = spkopn(file, "Test Kernel for spkopa unit test.", 4)
            # created empty spk kernel, write to it
            spksub!(handle_test, handle, descr, ident, first, last)
            # close kernel
            spkcls(handle_test)
            # open the file to append to it
            handle_spkopa = spkopa(file)
            @test handle_spkopa != -1
            et2 = str2et("2003 APR 27 00:00:00.000 TDB")
            handle, descr, ident = spksfs(5, et2)
            body, center, frame, otype, first, last, start, stop = spkuds(descr)
            spksub!(handle_spkopa, handle, descr, ident, first, last)
            spkcls(handle_spkopa)
        finally
            kclear()
        end
    end
    @testset "spkpds" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("2002 APR 27 00:00:00.000 TDB")
            handle, descr, ident = spksfs(5, et)
            body, center, frame, otype, first, last, start, stop  = spkuds(descr)
            outframe = frmnam(frame)
            spkpds_output = spkpds(body, center, outframe, otype, first, last)
            @test spkpds_output ≈ descr
        finally
            kclear()
        end
    end
    @testset "spkpos" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("July 4, 2003 11:00 AM PST")
            pos, lt = spkpos("Mars", et, "J2000", "LT+S", "Earth")
            expected_lt = 269.6898813661505
            expected_pos = [73822235.31053550541400909424, -27127918.99847228080034255981,
                            -18741306.30148987472057342529]
            @test lt ≈ expected_lt
            @test pos ≈ expected_pos
        finally
            kclear()
        end
    end
    @testset "spkpvn" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("2002 APR 27 00:00:00.000 TDB")
            handle, descr, ident = spksfs(5, et)
            refid, state, center = spkpvn(handle, descr, et)
            expected_state = [-2.70063336478468656540e+08, 6.69404818553274393082e+08,
                              2.93505043081457614899e+08, -1.24191493217698472051e+01,
                              -3.70147572019018955558e+00, -1.28422514561611489370e+00]
            @test state ≈ expected_state
            @test_throws ArgumentError spkpvn(handle, descr[1:4], et)
        finally
            kclear()
        end
    end
    @testset "spksfs" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            idcode = bodn2c("PLUTO BARYCENTER")
            et = str2et("2001 FEB 18 UTC")
            handle, descr, ident = spksfs(idcode, et)
            @test ident == "DE-405"
        finally
            kclear()
        end
    end
    @testset "spkw02" begin
        try
            spk2 = tempname()
            handle = spkopn(spk2, "Type 2 SPK internal file name.", 4)
            init_size = filesize(spk2)
            discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0]
            cheby_coeffs02 = [[1.0101, 1.0102, 1.0103, 1.0201],
                              [1.0202, 1.0203, 1.0301, 1.0302],
                              [1.0303, 2.0101, 2.0102, 2.0103],
                              [2.0201, 2.0202, 2.0203, 2.0301],
                              [2.0302, 2.0303, 3.0101, 3.0102],
                              [3.0103, 3.0201, 3.0202, 3.0203],
                              [3.0301, 3.0302, 3.0303, 4.0101],
                              [4.0102, 4.0103, 4.0201, 4.0202],
                              [4.0203, 4.0301, 4.0302, 4.0303]]
            segid = "SPK type 2 test segment"
            intlen = discrete_epochs[2] - discrete_epochs[1]
            spkw02(handle, 3, 10, "J2000", discrete_epochs[1],
                   discrete_epochs[end], segid, intlen, cheby_coeffs02, discrete_epochs[1])
            spkcls(handle)
            end_size = filesize(spk2)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw03" begin
        try
            spk3 = tempname()
            handle = spkopn(spk3, "Type 3 SPK internal file name.", 4)
            init_size = filesize(spk3)
            discrete_epochs = [100.0, 200.0, 300.0, 400.0]
            cheby_coeffs03 = [[1.0101, 1.0102, 1.0103, 1.0201, 1.0202, 1.0203,
                               1.0301, 1.0302, 1.0303, 1.0401, 1.0402, 1.0403,
                               1.0501, 1.0502, 1.0503, 1.0601, 1.0602, 1.0603],
                              [2.0101, 2.0102, 2.0103, 2.0201, 2.0202, 2.0203,
                               2.0301, 2.0302, 2.0303, 2.0401, 2.0402, 2.0403,
                               2.0501, 2.0502, 2.0503, 2.0601, 2.0602, 2.0603],
                              [3.0101, 3.0102, 3.0103, 3.0201, 3.0202, 3.0203,
                               3.0301, 3.0302, 3.0303, 3.0401, 3.0402, 3.0403,
                               3.0501, 3.0502, 3.0503, 3.0601, 3.0602, 3.0603],
                              [4.0101, 4.0102, 4.0103, 4.0201, 4.0202, 4.0203,
                               4.0301, 4.0302, 4.0303, 4.0401, 4.0402, 4.0403,
                               4.0501, 4.0502, 4.0503, 4.0601, 4.0602, 4.0603]]
            segid = "SPK type 3 test segment"
            intlen = discrete_epochs[2] - discrete_epochs[1]
            spkw03(handle, 3, 10, "J2000", discrete_epochs[1],
                   discrete_epochs[end], segid, intlen, cheby_coeffs03, discrete_epochs[1])
            spkcls(handle)
            end_size = filesize(spk3)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw05" begin
        try
            spk5 = tempname()
            handle = spkopn(spk5, "Type 5 SPK internal file name.", 4)
            init_size = filesize(spk5)
            discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0]
            discrete_states = [[101.0, 201.0, 301.0, 401.0, 501.0, 601.0],
                               [102.0, 202.0, 302.0, 402.0, 502.0, 602.0],
                               [103.0, 203.0, 303.0, 403.0, 503.0, 603.0],
                               [104.0, 204.0, 304.0, 404.0, 504.0, 604.0],
                               [105.0, 205.0, 305.0, 405.0, 505.0, 605.0],
                               [106.0, 206.0, 306.0, 406.0, 506.0, 606.0],
                               [107.0, 207.0, 307.0, 407.0, 507.0, 607.0],
                               [108.0, 208.0, 308.0, 408.0, 508.0, 608.0],
                               [109.0, 209.0, 309.0, 409.0, 509.0, 609.0]]
            segid = "SPK type 5 test segment"
            spkw05(handle, 3, 10, "J2000", discrete_epochs[1], discrete_epochs[end], segid,
                   132712440023.310, discrete_states, discrete_epochs)
            spkcls(handle)
            end_size = filesize(spk5)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw08" begin
        try
            spk8 = tempname()
            handle = spkopn(spk8, "Type 8 SPK internal file name.", 4)
            init_size = filesize(spk8)
            discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0]
            discrete_states = [[101.0, 201.0, 301.0, 401.0, 501.0, 601.0],
                               [102.0, 202.0, 302.0, 402.0, 502.0, 602.0],
                               [103.0, 203.0, 303.0, 403.0, 503.0, 603.0],
                               [104.0, 204.0, 304.0, 404.0, 504.0, 604.0],
                               [105.0, 205.0, 305.0, 405.0, 505.0, 605.0],
                               [106.0, 206.0, 306.0, 406.0, 506.0, 606.0],
                               [107.0, 207.0, 307.0, 407.0, 507.0, 607.0],
                               [108.0, 208.0, 308.0, 408.0, 508.0, 608.0],
                               [109.0, 209.0, 309.0, 409.0, 509.0, 609.0]]
            segid = "SPK type 8 test segment"
            step = discrete_epochs[2] - discrete_epochs[1]
            spkw08(handle, 3, 10, "J2000", discrete_epochs[2], discrete_epochs[end], segid,
                   3, discrete_states, discrete_epochs[1], step)
            spkcls(handle)
            end_size = filesize(spk8)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw09" begin
        try
            spk9 = tempname()
            handle = spkopn(spk9, "Type 9 SPK internal file name.", 4)
            init_size = filesize(spk9)
            discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0]
            discrete_states = [[101.0, 201.0, 301.0, 401.0, 501.0, 601.0],
                               [102.0, 202.0, 302.0, 402.0, 502.0, 602.0],
                               [103.0, 203.0, 303.0, 403.0, 503.0, 603.0],
                               [104.0, 204.0, 304.0, 404.0, 504.0, 604.0],
                               [105.0, 205.0, 305.0, 405.0, 505.0, 605.0],
                               [106.0, 206.0, 306.0, 406.0, 506.0, 606.0],
                               [107.0, 207.0, 307.0, 407.0, 507.0, 607.0],
                               [108.0, 208.0, 308.0, 408.0, 508.0, 608.0],
                               [109.0, 209.0, 309.0, 409.0, 509.0, 609.0]]
            segid = "SPK type 9 test segment"
            step = discrete_epochs[2] - discrete_epochs[1]
            spkw09(handle, 3, 10, "J2000", discrete_epochs[2], discrete_epochs[end], segid,
                   3, discrete_states, discrete_epochs)
            spkcls(handle)
            end_size = filesize(spk9)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw10" begin
        try
            furnsh(path(CORE, :lsk))
            spk10 = tempname()
            tle = ["1 18123U 87 53  A 87324.61041692 -.00000023  00000-0 -75103-5 0 00675",
                   "2 18123  98.8296 152.0074 0014950 168.7820 191.3688 14.12912554 21686",
                   "1 18123U 87 53  A 87326.73487726  .00000045  00000-0  28709-4 0 00684",
                   "2 18123  98.8335 154.1103 0015643 163.5445 196.6235 14.12912902 21988",
                   "1 18123U 87 53  A 87331.40868801  .00000104  00000-0  60183-4 0 00690",
                   "2 18123  98.8311 158.7160 0015481 149.9848 210.2220 14.12914624 22644",
                   "1 18123U 87 53  A 87334.24129978  .00000086  00000-0  51111-4 0 00702",
                   "2 18123  98.8296 161.5054 0015372 142.4159 217.8089 14.12914879 23045",
                   "1 18123U 87 53  A 87336.93227900 -.00000107  00000-0 -52860-4 0 00713",
                   "2 18123  98.8317 164.1627 0014570 135.9191 224.2321 14.12910572 23425",
                   "1 18123U 87 53  A 87337.28635487  .00000173  00000-0  10226-3 0 00726",
                   "2 18123  98.8284 164.5113 0015289 133.5979 226.6438 14.12916140 23475",
                   "1 18123U 87 53  A 87339.05673569  .00000079  00000-0  47069-4 0 00738",
                   "2 18123  98.8288 166.2585 0015281 127.9985 232.2567 14.12916010 24908",
                   "1 18123U 87 53  A 87345.43010859  .00000022  00000-0  16481-4 0 00758",
                   "2 18123  98.8241 172.5226 0015362 109.1515 251.1323 14.12915487 24626",
                   "1 18123U 87 53  A 87349.04167543  .00000042  00000-0  27370-4 0 00764",
                   "2 18123  98.8301 176.1010 0015565 100.0881 260.2047 14.12916361 25138"]
            epochs = Float64[]
            elems = Array{Float64}[]
            for lines in zip(tle[1:2:end], tle[2:2:end])
                epoch, ele = getelm(1950, lines)
                push!(epochs, epoch)
                push!(elems, ele)
            end
            first = epochs[1] - 0.5 * spd()
            last = epochs[end] + 0.5 * spd()
            consts = [1.082616e-3, -2.538813e-6, -1.65597e-6, 7.43669161e-2, 120.0, 78.0, 6378.135, 1.0]

            handle = spkopn(spk10, "Type 10 SPK internal file name.", 100)
            init_size = filesize(spk10)
            spkw10(handle, -118123, 399, "J2000", first, last, "DMSP F8", consts, elems, epochs)
            spkcls(handle)
            end_size = filesize(spk10)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw12" begin
        try
            spk12 = tempname()
            handle = spkopn(spk12, "Type 12 SPK internal file name.", 4)
            init_size = filesize(spk12)
            discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0]
            discrete_states = [[101.0, 201.0, 301.0, 401.0, 501.0, 601.0],
                               [102.0, 202.0, 302.0, 402.0, 502.0, 602.0],
                               [103.0, 203.0, 303.0, 403.0, 503.0, 603.0],
                               [104.0, 204.0, 304.0, 404.0, 504.0, 604.0],
                               [105.0, 205.0, 305.0, 405.0, 505.0, 605.0],
                               [106.0, 206.0, 306.0, 406.0, 506.0, 606.0],
                               [107.0, 207.0, 307.0, 407.0, 507.0, 607.0],
                               [108.0, 208.0, 308.0, 408.0, 508.0, 608.0],
                               [109.0, 209.0, 309.0, 409.0, 509.0, 609.0]]
            segid = "SPK type 12 test segment"
            step = discrete_epochs[2] - discrete_epochs[1]
            spkw12(handle, 3, 10, "J2000", discrete_epochs[2], discrete_epochs[end], segid,
                   3, discrete_states, discrete_epochs[1], step)
            spkcls(handle)
            end_size = filesize(spk12)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw13" begin
        try
            spk13 = tempname()
            handle = spkopn(spk13, "Type 13 SPK internal file name.", 4)
            init_size = filesize(spk13)
            discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0]
            discrete_states = [[101.0, 201.0, 301.0, 401.0, 501.0, 601.0],
                               [102.0, 202.0, 302.0, 402.0, 502.0, 602.0],
                               [103.0, 203.0, 303.0, 403.0, 503.0, 603.0],
                               [104.0, 204.0, 304.0, 404.0, 504.0, 604.0],
                               [105.0, 205.0, 305.0, 405.0, 505.0, 605.0],
                               [106.0, 206.0, 306.0, 406.0, 506.0, 606.0],
                               [107.0, 207.0, 307.0, 407.0, 507.0, 607.0],
                               [108.0, 208.0, 308.0, 408.0, 508.0, 608.0],
                               [109.0, 209.0, 309.0, 409.0, 509.0, 609.0]]
            segid = "SPK type 13 test segment"
            step = discrete_epochs[2] - discrete_epochs[1]
            spkw13(handle, 3, 10, "J2000", discrete_epochs[2], discrete_epochs[end], segid,
                   3, discrete_states, discrete_epochs)
            spkcls(handle)
            end_size = filesize(spk13)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw15" begin
        try
            discrete_epochs = [100.0, 900.0]
            spk15 = tempname()

            handle = spkopn(spk15, "Type 15 SPK internal file name.", 4)
            init_size = filesize(spk15)

            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk), path(CORE, :gm_pck))
            et = str2et("Dec 25, 2007")
            state, ltime = spkezr("Moon", et, "J2000", "NONE", "EARTH")
            mu = bodvrd("EARTH", "GM", 1)
            elts = oscelt(state, et, mu[1])
            ecc = elts[2]
            p   = elts[1] * (1.0 + ecc)
            state = state[1:3]
            tp = normalize(cross(state, state .+ 4.0))
            pa = normalize(state)
            j2flg = 0.0
            pv = [1.0, 2.0, 3.0]
            gm = 398600.436
            j2 = 1.0
            radius = 6000.0
            spkw15(handle, 3, 10, "J2000", discrete_epochs[1], discrete_epochs[end], "Test SPKW15",
                   et, tp, pa, p, ecc, j2flg, pv, gm, j2, radius)
            spkcls(handle)

            end_size = filesize(spk15)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw17" begin
        try
            discrete_epochs = [100.0, 900.0]

            spk17 = tempname()
            handle = spkopn(spk17, "Type 17 SPK internal file name.", 4)
            init_size = filesize(spk17)

            furnsh(path(CORE, :lsk))
            et = str2et("Dec 25, 2007")
            p = 10000.0
            gm = 398600.436
            ecc = 0.1
            a = p / (1.0 - ecc)
            n = sqrt(gm / a) / a
            argp   = deg2rad(30.0)
            node   = deg2rad(15.0)
            inc    = deg2rad(10.0)
            m0     = deg2rad(45.0)
            eqel   = [a, ecc * sin(argp + node), ecc * cos(argp + node), m0 + argp + node,
                      tan(inc / 2.0) * sin(node), tan(inc / 2.0) * cos(node), 0.0, n, 0.0]
            rapol  = -π/2
            decpol = π/2

            spkw17(handle, 3, 10, "J2000", discrete_epochs[1], discrete_epochs[end], "Test SPKW17",
                   et, eqel, rapol, decpol)

            spkcls(handle)
            end_size = filesize(spk17)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "spkw18" begin
        try
            spk18 = tempname()
            handle = spkopn(spk18, "Type 18 SPK internal file name.", 4)
            init_size = filesize(spk18)

            body = 3
            center = 10
            ref =  "J2000"
            epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0]
            packts = [[101.0, 201.0, 301.0, 401.0, 501.0, 601.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [102.0, 202.0, 302.0, 402.0, 502.0, 602.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [103.0, 203.0, 303.0, 403.0, 503.0, 603.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [104.0, 204.0, 304.0, 404.0, 504.0, 604.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [105.0, 205.0, 305.0, 405.0, 505.0, 605.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [106.0, 206.0, 306.0, 406.0, 506.0, 606.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [107.0, 207.0, 307.0, 407.0, 507.0, 607.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [108.0, 208.0, 308.0, 408.0, 508.0, 608.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
                      [109.0, 209.0, 309.0, 409.0, 509.0, 609.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]]

            spkw18(handle, :S18TP0, body, center, ref, epochs[1], epochs[end],
                   "SPK type 18 test segment", 3, packts, epochs)

            spkcls(handle)
            end_size = filesize(spk18)
            @test end_size != init_size

            handle = spklef(spk18)
            state, _ = spkgeo(body, epochs[1], ref, center)
            @test state ≈ [101., 201., 301., 1., 1., 1., ]
            state, _ = spkgeo(body, epochs[2], ref, center)
            @test state ≈ [102., 202., 302., 1., 1., 1., ]
            spkcls(handle)
        finally
            kclear()
        end
    end
    @testset "spkw20" begin
        try
            spk20 = tempname()
            handle = spkopn(spk20, "Type 20 SPK internal file name.", 4)
            init_size = filesize(spk20)

            intlen = 5.0
            cdata = [[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0],
                     [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0],
                     [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0],
                     [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]]
            dscale = 1.0
            tscale = 1.0
            initjd = 2451545.0
            initfr = 0.25
            first  = (initjd - j2000() + initfr) * spd()
            last   = ((initjd - j2000()) + initfr + 4 * intlen) * spd()
            spkw20(handle, 301, 3, "J2000", first, last, "Test SPKW20",
                   intlen, cdata, dscale, tscale, initjd, initfr)
            spkcls(handle)
            end_size = filesize(spk20)
            @test end_size != init_size
        finally
            kclear()
        end
    end
    @testset "srfc2s" begin
        try
            kernel = tempname()
            open(kernel, "w") do kernel_file
                write(kernel_file, "\\begindata\n")
                write(kernel_file, "NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n")
                write(kernel_file, "                       'MGS MOLA 128 pixel/deg',\n")
                write(kernel_file, "                       'PHOBOS GASKELL Q512'     )\n")
                write(kernel_file, "NAIF_SURFACE_CODE += (   1,   2,    1 )\n")
                write(kernel_file, "NAIF_SURFACE_BODY += ( 499, 499,  401 )\n")
                write(kernel_file, "\\begintext\n")
            end
            furnsh(kernel)
            @test srfc2s(1, 499) == ("MGS MOLA  64 pixel/deg", true)
            @test srfc2s(1, 401) == ("PHOBOS GASKELL Q512", true)
            @test srfc2s(2, 499) == ("MGS MOLA 128 pixel/deg", true)
            @test srfc2s(1, -1) == ("1", false)
        finally
            kclear()
        end
    end
    @testset "srfcss" begin
        try
            kernel = tempname()
            open(kernel, "w") do kernel_file
                write(kernel_file, "\\begindata\n")
                write(kernel_file, "NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n")
                write(kernel_file, "                       'MGS MOLA 128 pixel/deg',\n")
                write(kernel_file, "                       'PHOBOS GASKELL Q512'     )\n")
                write(kernel_file, "NAIF_SURFACE_CODE += (   1,   2,    1 )\n")
                write(kernel_file, "NAIF_SURFACE_BODY += ( 499, 499,  401 )\n")
                write(kernel_file, "\\begintext\n")
            end
            furnsh(kernel)
            @test srfcss(1, "MARS") == ("MGS MOLA  64 pixel/deg", true)
            @test srfcss(1, "PHOBOS") == ("PHOBOS GASKELL Q512", true)
            @test srfcss(2, "499") == ("MGS MOLA 128 pixel/deg", true)
            @test srfcss(1, "-1") == ("1", false)
        finally
            kclear()
        end
    end
    @testset "srfnrm" begin
        try
            furnsh(path(CORE, :pck), path(EXTRA, :phobos_dsk))
            srfpts = latsrf("DSK/UNPRIORITIZED", "PHOBOS", 0.0, "IAU_PHOBOS", [[0.0, 45.0], [60.0, 45.0]])
            normals = srfnrm("DSK/UNPRIORITIZED", "PHOBOS", 0.0, "IAU_PHOBOS", srfpts)
            @test norm(normals[1]) ≈ 1.0
            @test norm(normals[2]) ≈ 1.0
        finally
            kclear()
        end
    end
    @testset "srfrec" begin
        try
            furnsh(path(CORE, :pck))
            x = srfrec(399, deg2rad(100.0), deg2rad(35.0))
            expected = [-906.24919474, 5139.59458217, 3654.29989637]
            @test x ≈ expected
        finally
            kclear()
        end
    end
    @testset "srfs2c" begin
        try
            kernel = tempname()
            open(kernel, "w") do kernel_file
                write(kernel_file, "\\begindata\n")
                write(kernel_file, "NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n")
                write(kernel_file, "                       'MGS MOLA 128 pixel/deg',\n")
                write(kernel_file, "                       'PHOBOS GASKELL Q512'     )\n")
                write(kernel_file, "NAIF_SURFACE_CODE += (   1,   2,    1 )\n")
                write(kernel_file, "NAIF_SURFACE_BODY += ( 499, 499,  401 )\n")
                write(kernel_file, "\\begintext\n")
            end
            furnsh(kernel)
            @test srfs2c("MGS MOLA  64 PIXEL/DEG", "MARS") == 1
            @test srfs2c("PHOBOS GASKELL Q512", "PHOBOS")  == 1
            @test srfs2c("MGS MOLA 128 PIXEL/DEG", "MARS") == 2
            @test srfs2c("MGS MOLA  64 PIXEL/DEG", "499")  == 1
            @test srfs2c("1", "PHOBOS") == 1
            @test srfs2c("2", "499") == 2
            @test srfs2c("ZZZ", "MARS") === nothing
        finally
            kclear()
        end
    end
    @testset "srfscc" begin
        try
            kernel = tempname()
            open(kernel, "w") do kernel_file
                write(kernel_file, "\\begindata\n")
                write(kernel_file, "NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n")
                write(kernel_file, "                       'MGS MOLA 128 pixel/deg',\n")
                write(kernel_file, "                       'PHOBOS GASKELL Q512'     )\n")
                write(kernel_file, "NAIF_SURFACE_CODE += (   1,   2,    1 )\n")
                write(kernel_file, "NAIF_SURFACE_BODY += ( 499, 499,  401 )\n")
                write(kernel_file, "\\begintext\n")
            end
            furnsh(kernel)
            @test srfscc("MGS MOLA  64 PIXEL/DEG", 499) == 1
            @test srfscc("PHOBOS GASKELL Q512", 401)  == 1
            @test srfscc("MGS MOLA 128 PIXEL/DEG", 499) == 2
            @test srfscc("MGS MOLA  64 PIXEL/DEG", 499)  == 1
            @test srfscc("1", 401) == 1
            @test srfscc("2", 499) == 2
            @test srfscc("ZZZ", 499) === nothing
        finally
            kclear()
        end
    end
    @testset "ssize" begin
        cell = SpiceDoubleCell(10)
        @test size_c(cell) == 10
        ssize!(cell, 5)
        @test size_c(cell) == 5
    end
    @testset "stelab" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            idobs = 399
            idtarg = 301
            utc = "July 4 2004"
            frame = "J2000"
            et = str2et(utc)
            sobs = spkssb(idobs, et, frame)
            starg, _ = spkaps(idtarg, et, frame, "LT", sobs, zeros(6))
            expected_starg = [2.01738718005936592817e+05,  -2.60893145259797573090e+05,
                              -1.47722589585214853287e+05,   9.24727104822839152121e-01,
                              5.32379608845730878386e-01,   2.17669748758417824774e-01]
            @test starg ≈ expected_starg
            cortarg = stelab(starg[1:3], starg[4:6])
            expected_cortarg = [201739.80378842627396807075, -260892.46619604207808151841,
                                -147722.30606629714020527899]
            @test expected_cortarg ≈ cortarg
        finally
            kclear()
        end
    end
    @testset "stpool" begin
        try
            kernel = tempname()
            open(kernel, "w") do kernel_file
                write(kernel_file, "\\begindata\n")
                write(kernel_file, "SPK_FILES = ( 'this_is_the_full_path_specification_*',\n")
                write(kernel_file, "              'of_a_file_with_a_long_name',\n")
                write(kernel_file, "              'this_is_the_full_path_specification_*',\n")
                write(kernel_file, "              'of_a_second_file_name' )\n")
            end
            furnsh(kernel)
            string = stpool("SPK_FILES", 1, "*")
            @test string == "this_is_the_full_path_specification_of_a_file_with_a_long_name"
            string = stpool("SPK_FILES", 2, "*")
            @test string == "this_is_the_full_path_specification_of_a_second_file_name"
        finally
            kclear()
        end
    end
    @testset "str2et" begin
        try
            furnsh(path(CORE, :lsk))
            date = "Thu Mar 20 12:53:29 PST 1997"
            et = str2et(date)
            @test et ≈ -87836728.81438904
        finally
            kclear()
        end
    end
    @testset "subpnt" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk))
            et = str2et("2008 aug 11 00:00:00")
            re, _, rp = bodvrd("MARS", "RADII", 3)
            f = (re - rp) / re
            methods = ["INTERCEPT: ELLIPSOID", "NEAR POINT: ELLIPSOID"]
            expecteds = [[349199089.604657,
                          349199089.64135259,
                          0.0,
                          199.30230503198658,
                          199.30230503198658,
                          26.262401237213588,
                          25.99493675077423,
                          160.69769496801342,
                          160.69769496801342,
                          25.994934171245205,
                          25.994934171245202],
                         [349199089.6046486,
                          349199089.60464859,
                          0.0,
                          199.30230503240247,
                          199.30230503240247,
                          25.99493675092049,
                          25.99493675092049,
                          160.69769496759753,
                          160.69769496759753,
                          25.729407227461937,
                          25.994934171391463]]
            for (expected, method) in zip(expecteds, methods)
                spoint, trgepc, srfvec = subpnt(method, "MARS", et, "IAU_MARS", "LT+S", "EARTH")
                odist = norm(srfvec)
                @test odist ≈ expected[2]
                spglon, spglat, spgalt = recpgr("mars", spoint, re, f)
                @test spgalt ≈ expected[3] atol=sqrt(eps())
                @test rad2deg(spglon) ≈ expected[4]
                @test rad2deg(spglat) ≈ expected[6]
                spcrad, spclon, spclat = reclat(spoint)
                @test rad2deg(spclon) ≈ expected[8]
                @test rad2deg(spclat) ≈ expected[10]
                obspos = spoint - srfvec
                opglon, opglat, opgalt = recpgr("mars", obspos, re, f)
                @test opgalt ≈ expected[1]
                @test rad2deg(opglon) ≈ expected[5]
                @test rad2deg(opglat) ≈ expected[7]
                opcrad, opclon, opclat = reclat(obspos)
                @test rad2deg(opclon) ≈ expected[9]
                @test rad2deg(opclat) ≈ expected[11]
            end
        finally
            kclear()
        end
    end
    @testset "subslr" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk))
            et = str2et("2008 aug 11 00:00:00")
            re, _, rp = bodvrd("MARS", "RADII", 3)
            f = (re - rp) / re
            methods = ["INTERCEPT/ELLIPSOID", "NEAR POINT/ELLIPSOID"]
            expecteds = [[0.0,
                          175.8106755102322,
                          23.668550281477703,
                          -175.81067551023222,
                          23.420819936106213,
                          175.810721536362,
                          23.42082337182491,
                          -175.810721536362,
                          23.42081994605096],
                         [ 0.0,
                          175.8106754100492,
                          23.420823361866685,
                          -175.81067551023222,
                          23.175085577910583,
                          175.81072152220804,
                          23.420823371828,
                          -175.81072152220804,
                          23.420819946054046]]
            for (expected, method) in zip(expecteds, methods)
                spoint, trgepc, srfvec = subslr(method, "MARS", et, "IAU_MARS", "LT+S", "Earth")
                spglon, spglat, spgalt = recpgr("MARS", spoint, re, f)

                @test spgalt ≈ expected[1] atol=sqrt(eps())
                @test rad2deg(spglon) ≈ expected[2]
                @test rad2deg(spglat) ≈ expected[3]
                spcrad, spclon, spclat = reclat(spoint)
                @test rad2deg(spclon) ≈ expected[4]
                @test rad2deg(spclat) ≈ expected[5]
                sunpos, sunlt = spkpos("SUN", trgepc, "IAU_MARS", "LT+S", "MARS")
                supgln, supglt, supgal = recpgr("MARS", sunpos, re, f)
                @test rad2deg(supgln) ≈ expected[6]
                @test rad2deg(supglt) ≈ expected[7]
                supcrd, supcln, supclt = reclat(sunpos)
                @test rad2deg(supcln) ≈ expected[8]
                @test rad2deg(supclt) ≈ expected[9]
            end
        finally
            kclear()
        end
    end
    @testset "sumad" begin
        array = [1.0, 2.0, 3.0]
        @test sum(array) == SPICE._sumad(array)
    end
    @testset "sumai" begin
        array = [1, 2, 3]
        @test sum(array) == SPICE._sumai(array)
    end
    @testset "surfnm" begin
        normal = surfnm(1.0, 1.0, 1.0, [1.0, 0.0, 0.0])
        @test normal == [1.0, 0.0, 0.0]
    end
    @testset "surfpt" begin
        position = [2.0, 0.0, 0.0]
        u = [-1.0, 0.0, 0.0]
        point = surfpt(position, u, 1.0, 2.0, 3.0)
        @test point ≈ [1.0, 0.0, 0.0]
    end
    @testset "surfpv" begin
        stvrtx = [2.0, 0.0, 0.0, 0.0, 0.0, 3.0]
        stdir = [-1.0, 0.0, 0.0, 0.0, 0.0, 4.0]
        stx = surfpv(stvrtx, stdir, 1.0, 2.0, 3.0)
        expected = [1.0, 0.0, 0.0, 0.0, 0.0, 7.0]
        @test expected ≈ stx
    end
    @testset "swpool" begin
        try
            # add TEST_VAR_SWPOOL
            pdpool("TEST_VAR_SWPOOL", [-666.0])
            # establish check for TEST_VAR_SWPOOL
            swpool("TEST_SWPOOL", ["TEST_VAR_SWPOOL"])
            # update TEST_VAR_SWPOOL
            pdpool("TEST_VAR_SWPOOL", [555.0])
            # check for updated variable
            updated = cvpool("TEST_SWPOOL")
            value = gdpool("TEST_VAR_SWPOOL")
            @test length(value) == 1
            @test value[1] == 555.0
            @test updated
        finally
            clpool()
            kclear()
        end
    end
    @testset "sxform" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck))
            lon = deg2rad(118.25)
            lat = deg2rad(34.05)
            alt = 0.0
            utc = "January 1, 1990"
            et = str2et(utc)
            abc = bodvrd("EARTH", "RADII", 3)
            equatr = abc[1]
            polar = abc[3]
            f = (equatr - polar) / equatr
            estate = georec(lon, lat, alt, equatr, f)
            estate = push!(estate, 0.0, 0.0, 0.0)
            xform = sxform("IAU_EARTH", "J2000", et)
            jstate = xform * estate
            expected = [-4131.45969, -3308.36805, 3547.02462, 0.241249619, -0.301019201, 0.000234215666]
            @test jstate ≈ expected
        finally
            kclear()
        end
    end
    @testset "szpool" begin
        @test szpool("MAXVAR") == 26003
        @test szpool("MAXLEN") == 32
        @test szpool("MAXVAL") == 400000
        @test szpool("MXNOTE") == 130015
        @test szpool("MAXAGT") == 1000
        @test szpool("MAXCHR") == 80
        @test szpool("MAXLIN") == 15000
        @test szpool("NORBERT") === nothing
    end
end

