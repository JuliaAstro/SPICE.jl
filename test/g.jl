using Random: randstring

@testset "G" begin
    @testset "gcpool" begin
        try
            data = [randstring() for i in 1:10]
            pcpool("pcpool_test", data)
            cvals = gcpool("pcpool_test")
            @test data == cvals
            @test gcpool("norbert") === nothing
        finally
            kclear()
        end
    end
    @testset "gdpool" begin
        try
            exp = collect(1.0:10.0)
            pdpool("array", exp)
            act = gdpool("array")
            @test exp == act
            act = gdpool("array", start = 8)
            @test [8.0, 9.0, 10.0] == act
            act = gdpool("array", room = 8)
            @test collect(1.0:8.0) == act
            @test gdpool("norbert") === nothing
        finally
            kclear()
        end
    end
    @testset "georec" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("EARTH", "RADII", 3)
            flat = (radii[1] - radii[3]) / radii[1]
            lon = deg2rad(118.0)
            lat = deg2rad(32.0)
            alt = 0.0
            output = georec(lon, lat, alt, radii[1], flat)
            expected = [-2541.74621567, 4780.329376, 3360.4312092]
            @test expected ≈ output
            @test_throws SpiceError georec(lon, lat, alt, -1.0, flat)
            @test_throws SpiceError georec(lon, lat, alt, radii[1], 2.0)
        finally
            kclear()
        end
    end
    @testset "getelm" begin
        try
            tle = ["1 18123U 87 53  A 87324.61041692 -.00000023  00000-0 -75103-5 0 00675",
                   "2 18123  98.8296 152.0074 0014950 168.7820 191.3688 14.12912554 21686"]
            furnsh(path(CORE, :lsk))
            epoch, elems = getelm(1950, tle)
            expected_elems = [-6.969196665949579e-13, 0.0, -7.510300000000001e-06,
                              1.724901918428988, 2.653029617396028, 0.001495,
                              2.9458016181010693, 3.3400156455905243, 0.06164994027515544,
                              -382310404.79526937]
            expected_epoch = -382310404.79526937
            @test expected_elems ≈ elems
            @test epoch ≈ expected_epoch
        finally
            kclear()
        end
    end
    @testset "getfat" begin
    arch, outtype = getfat(path(CORE, :lsk))
        @test arch == "KPL"
        @test outtype == "LSK"
    end
    @testset "getfov" begin
        try
            kernel = tempname()
            open(kernel, "w") do kernel_file
                write(kernel_file, "\\begindata\n")
                write(kernel_file, "INS-999004_FOV_SHAPE            = 'POLYGON'\n")
                write(kernel_file, "INS-999004_FOV_FRAME            = 'SC999_INST004'\n")
                write(kernel_file, "INS-999004_BORESIGHT            = (  0.0,  1.0,  0.0 )\n")
                write(kernel_file, "INS-999004_FOV_BOUNDARY_CORNERS = (  0.0,  0.8,  0.5,\n")
                write(kernel_file, "                                     0.4,  0.8, -0.2,\n")
                write(kernel_file, "                                    -0.4,  0.8, -0.2,\n")
                write(kernel_file, "\\begintext\n")
            end
            furnsh(kernel)
            shape, frame, bsight, bounds = getfov(-999004, 4, 32, 32)
            @test shape == "POLYGON"
            @test frame == "SC999_INST004"
            @test bsight ≈ [0.0, 1.0, 0.0]
            @test length(bounds) == 3
    expected = [[0.0, 0.8, 0.5], [0.4, 0.8, -0.2], [-0.4, 0.8, -0.2]]
            @test expected ≈ bounds
        finally
            kclear()
        end
    end
    @testset "gfbail" begin
        @test !Bool(SPICE.gfbail())
    end
    @testset "gfclrh" begin
        SPICE.gfclrh()
        @test !Bool(SPICE.gfbail())
    end
    @testset "gfdist" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2007 JAN 01 00:00:00 TDB")
            et1 = str2et("2007 APR 01 00:00:00 TDB")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = gfdist("moon", "none", "earth", ">", 400000, 0.0, spd(), 1000, cnfine)
            count = wncard(result)
            @test count == 4
            results = String[]
            for i in 1:count
                left, right = wnfetd(result, i)
                timstr_left = timout(left, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
                timstr_right = timout(right, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
                push!(results, timstr_left)
                push!(results, timstr_right)
            end
            expected = ["2007-JAN-08 00:11:07.661897 (TDB)", "2007-JAN-13 06:37:47.937762 (TDB)",
                        "2007-FEB-04 07:02:35.320555 (TDB)", "2007-FEB-10 09:31:01.829206 (TDB)",
                        "2007-MAR-03 00:20:25.228066 (TDB)", "2007-MAR-10 14:04:38.482902 (TDB)",
                        "2007-MAR-29 22:53:58.186230 (TDB)", "2007-APR-01 00:00:00.000000 (TDB)"]
            @test results == expected
        finally
            kclear()
        end
    end
    @testset "gfevnt" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et_start = str2et("2001 JAN 01 00:00:00.000")
            et_end   = str2et("2001 DEC 31 00:00:00.000")
            cnfine   = SpiceDoubleCell(2)
            wninsd!(cnfine, et_start, et_end)
            result   = SpiceDoubleCell(1000)
            qpnams   = ["TARGET", "OBSERVER", "ABCORR"]
            qcpars   = ["MOON  ", "EARTH   ", "LT+S  "]
            # Set the step size to 1/1000 day and convert to seconds
            gfsstp(0.001 * spd())
            qdpars = zeros(3)
            qipars = zeros(Int, 3)
            qlpars = falses(3)
            result = gfevnt(gfstep, gfrefn, "DISTANCE", qpnams, qcpars,
                            qdpars, qipars, qlpars, "LOCMAX", 0, 1.e-6, 0,
                            true, gfrepi, gfrepu, gfrepf, 10000, cnfine)
            @test length(result) == 26
            s_timout = "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND"
            @test startswith(timout(result[1], s_timout), "2001-JAN-24 19:22:01.41871")
            @test startswith(timout(result[2], s_timout), "2001-JAN-24 19:22:01.41871")
            @test startswith(timout(result[3], s_timout), "2001-FEB-20 21:52:07.90087")
            @test startswith(timout(result[4], s_timout), "2001-FEB-20 21:52:07.90087")
        finally
            gfsstp(0.5)
            kclear()
        end
    end
    @testset "gffove" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk),
                   path(CASSINI, :ck),
                   path(CASSINI, :fk),
                   path(CASSINI, :ik),
                   path(CASSINI, :pck),
                   path(CASSINI, :sclk),
                   path(CASSINI, :tour_spk),
                   path(CASSINI, :sat_spk))
            et_start = str2et("2013-FEB-25 10:00:00.000")
            et_end   = str2et("2013-FEB-25 11:45:00.000")
            cnfine   = SpiceDoubleCell(2)
            wninsd!(cnfine, et_start, et_end)
            result = SpiceDoubleCell(1000)
            gfsstp(1.0)
            gffove!("CASSINI_ISS_NAC", "ELLIPSOID", [0.0, 0.0, 0.0], "ENCELADUS",
                    "IAU_ENCELADUS", "LT+S", "CASSINI", 1.e-6, gfstep, gfrefn, true, gfrepi,
                    gfrepu, gfrepf, cnfine, result)
            # Verify the expected results
            @test length(result) == 2
            s_timout = "YYYY-MON-DD HR:MN:SC UTC ::RND"
            @test timout(result[1], s_timout) == "2013-FEB-25 10:42:33 UTC"
            @test timout(result[2], s_timout) == "2013-FEB-25 11:45:00 UTC"
        finally
            gfsstp(0.5)
            kclear()
        end
    end
    @testset "gfilum" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk),
                   path(EXTRA, :mars_spk))
            pos = [3376.17890941875839416753, -325.55203839445334779157, -121.47422900638389364758]
            start_et = str2et("1971 OCT 02 00:00:00 UTC")
            end_et = str2et("1971 NOV 30 12:00:00 UTC")
            cnfine = SpiceDoubleCell(2000)
            wninsd!(cnfine, start_et, end_et)
            wnsolr = gfilum("ELLIPSOID", "INCIDENCE", "MARS", "SUN",
                            "IAU_MARS", "CN+S", "PHOBOS", pos,
                            "<", deg2rad(60.0), 0.0, 21600.0,
                            1000, cnfine)
            result = gfilum("Ellipsoid", "EMISSION", "MARS", "SUN",
                            "IAU_MARS", "CN+S", "PHOBOS", pos,
                            "<", deg2rad(20.0), 0.0, 900.0,
                            1000, wnsolr)
            @test wncard(result) > 0
            start_epoch = timout(result[1],  "YYYY MON DD HR:MN:SC.###### UTC")
            end_epoch   = timout(result[end], "YYYY MON DD HR:MN:SC.###### UTC")
            @test startswith(start_epoch, "1971 OCT 02")
            @test startswith(end_epoch, "1971 NOV 29")
        finally
            kclear()
        end
    end
    @testset "gfocce" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2001 DEC 01 00:00:00 TDB")
            et1 = str2et("2002 JAN 01 00:00:00 TDB")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = SpiceDoubleCell(1000)
            gfsstp(20.0)
            gfocce!("Any", "moon", "ellipsoid", "iau_moon", "sun",
                    "ellipsoid", "iau_sun", "lt", "earth", 1.e-6,
                    gfstep, gfrefn, true, gfrepi, gfrepu, gfrepf,
                    cnfine, result)
            @test wncard(result) == 1
        finally
            gfsstp(0.5)
            kclear()
        end
    end
    @testset "gfoclt" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2001 DEC 01 00:00:00 TDB")
            et1 = str2et("2002 JAN 01 00:00:00 TDB")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = gfoclt("ANY", "MOON", "ELLIPSOID", "IAU_MOON", "SUN",
                            "ELLIPSOID", "IAU_SUN", "LT", "EARTH", 15 * 60.0, cnfine)
            count = wncard(result)
            @test count == 1
            start, stop = wnfetd(result, 1)
            start_time = timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
            end_time = timout(stop, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
            @test start_time == "2001-DEC-14 20:10:14.203347 (TDB)"
            @test end_time == "2001-DEC-14 21:35:50.328804 (TDB)"
        finally
            kclear()
        end
    end
    @testset "gfpa" begin
        relate = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
        expected = Dict("=" => [
                                "2006-DEC-02 13:31:34.425",
                                "2006-DEC-02 13:31:34.425",
                                "2006-DEC-07 14:07:55.480",
                                "2006-DEC-07 14:07:55.480",
                                "2007-JAN-01 00:00:00.007",
                                "2007-JAN-01 00:00:00.007",
                                "2007-JAN-06 08:16:25.522",
                                "2007-JAN-06 08:16:25.522",
                                "2007-JAN-30 11:41:32.568",
                                "2007-JAN-30 11:41:32.568",
                               ],
                        "<" => [
                                "2006-DEC-02 13:31:34.425",
                                "2006-DEC-07 14:07:55.480",
                                "2007-JAN-01 00:00:00.007",
                                "2007-JAN-06 08:16:25.522",
                                "2007-JAN-30 11:41:32.568",
                                "2007-JAN-31 00:00:00.000",
                               ],
                        ">" => [
                                "2006-DEC-01 00:00:00.000",
                                "2006-DEC-02 13:31:34.425",
                                "2006-DEC-07 14:07:55.480",
                                "2007-JAN-01 00:00:00.007",
                                "2007-JAN-06 08:16:25.522",
                                "2007-JAN-30 11:41:32.568",
                               ],
                        "LOCMIN" => [
                                     "2006-DEC-05 00:16:50.327",
                                     "2006-DEC-05 00:16:50.327",
                                     "2007-JAN-03 14:18:31.987",
                                     "2007-JAN-03 14:18:31.987",
                                    ],
                        "ABSMIN" => [
                                     "2007-JAN-03 14:18:31.987",
                                     "2007-JAN-03 14:18:31.987",
                                    ],
                        "LOCMAX" => [
                                     "2006-DEC-20 14:09:10.402",
                                     "2006-DEC-20 14:09:10.402",
                                     "2007-JAN-19 04:27:54.610",
                                     "2007-JAN-19 04:27:54.610",
                                    ],
                        "ABSMAX" => [
                                     "2007-JAN-19 04:27:54.610",
                                     "2007-JAN-19 04:27:54.610",
                                    ])
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2006 DEC 01")
            et1 = str2et("2007 JAN 31")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = SpiceDoubleCell(2000)
            for relation in relate
                result = gfpa("Moon", "Sun", "LT+S", "Earth", relation, 0.57598845,
                              0.0, spd(), 5000, cnfine)
                count = wncard(result)
                @test count > 0
                if count > 0
                    temp_results = String[]
                    for i in 1:count
                        left, right = wnfetd(result, i)
                        timstr_left = timout(left, "YYYY-MON-DD HR:MN:SC.###")
                        timstr_right = timout(right, "YYYY-MON-DD HR:MN:SC.###")
                        push!(temp_results, timstr_left)
                        push!(temp_results, timstr_right)
                    end
                    @test temp_results == expected[relation]
                end
            end
        finally
            kclear()
        end
    end
    @testset "gfposc" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2007 JAN 01")
            et1 = str2et("2008 JAN 01")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = gfposc("sun", "iau_earth", "none", "earth", "latitudinal", "latitude",
                            "absmax", 0.0, 0.0, 90.0 * spd(), 1000, cnfine)
            count = wncard(result)
            @test count == 1
            start, stop = wnfetd(result, 1)
            start_time = timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
            end_time = timout(stop, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
            @test start_time == end_time
            @test start_time == "2007-JUN-21 17:54:13.201561 (TDB)"
        finally
            kclear()
        end
    end
    @testset "gfrefn" begin
        s1 = [true, false]
        s2 = [true, false]
        for i in 1:2
            for j in 1:2
                scale = 10.0 * i + j
                t1 = 5.0 * scale
                t2 = 7.0 * scale
                t  = gfrefn(t1, t2, s1[i], s2[j])
                @test t ≈ scale * 6.0
            end
        end
        for i in 1:2
            for j in 1:2
                scale = 10.0 * i + j
                t1 = 15.0 * scale
                t2 = 7.0 * scale
                t  = gfrefn(t1, t2, s1[i], s2[j])
                @test t ≈ scale * 11.0
            end
        end
        for i in 1:2
            for j in 1:2
                scale = 10.0 * i + j
                t1 = -scale
                t2 = -scale
                t  = gfrefn(t1, t2, s1[i], s2[j])
                @test t ≈ -scale
            end
        end
    end
    @testset "gfrepi" begin
        window = SpiceDoubleCell(4)
        wninsd!(window, 0., 100.)
        gfrepi(window, "x", "y")
        # BEGMSS or ENDMSS empty, too long, or containing non-printing characters
        @test_throws SpiceError gfrepi(window, "", "y")
        @test_throws SpiceError gfrepi(window, "x", "")
        @test_throws SpiceError gfrepi(window, "x"^1000, "y")
        @test_throws SpiceError gfrepi(window, "x", "y"^1000)
        @test_throws SpiceError gfrepi(window, "y\n", "y")
        @test_throws SpiceError gfrepi(window, "x", "y\n")
        gfrepf()
    end
    @testset "gfrepu" begin
        window = SpiceDoubleCell(4)
        wninsd!(window, 0., 100.)
        gfrepi(window, "x", "y")
        gfrepu(0., 100., 50.)
        gfrepu(0., 100., 100.)
        @test_throws SpiceError gfrepu(100., 0., 100.)
        @test_throws SpiceError gfrepu(0., 100., -1.)
        @test_throws SpiceError gfrepu(0., 100., 1011.)
        gfrepu(0., 100., 100.)
        gfrepf()
    end
    @testset "gfrfov" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk),
                   path(CASSINI, :ck),
                   path(CASSINI, :fk),
                   path(CASSINI, :ik),
                   path(CASSINI, :pck),
                   path(CASSINI, :sclk),
                   path(CASSINI, :tour_spk),
                   path(CASSINI, :sat_spk))
            inst = "CASSINI_ISS_WAC"
            et_start1 = str2et("2013-FEB-25 07:20:00.000")
            et_end1 = str2et("2013-FEB-25 11:45:00.000")
            et_start2 = str2et("2013-FEB-25 11:55:00.000")
            et_end2 = str2et("2013-FEB-26 14:25:00.000")
            cnfine = SpiceDoubleCell(4)
            wninsd!(cnfine, et_start1, et_end1)
            wninsd!(cnfine, et_start2, et_end2)
            et_nom = str2et("2013-FEB-25 11:50:00.000")
            raydir, lt = spkpos("Enceladus", et_nom, "J2000", "NONE", "Cassini")
            result = gfrfov(inst, raydir, "J2000", "NONE", "Cassini", 10.0, cnfine)
            @test length(result) == 4
            s_timout = "YYYY-MON-DD HR:MN:SC UTC ::RND"
            @test timout(result[1], s_timout) == "2013-FEB-25 11:26:46 UTC"
            @test timout(result[2], s_timout) == "2013-FEB-25 11:45:00 UTC"
            @test timout(result[3], s_timout) == "2013-FEB-25 11:55:00 UTC"
            @test timout(result[4], s_timout) == "2013-FEB-25 12:05:33 UTC"
        finally
            kclear()
        end
    end
    @testset "gfrr" begin
        relate = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
        expected = Dict("=" => ["2007-JAN-02 00:35:19.583",
                                "2007-JAN-02 00:35:19.583",
                                "2007-JAN-19 22:04:54.905",
                                "2007-JAN-19 22:04:54.905",
                                "2007-FEB-01 23:30:13.439",
                                "2007-FEB-01 23:30:13.439",
                                "2007-FEB-17 11:10:46.547",
                                "2007-FEB-17 11:10:46.547",
                                "2007-MAR-04 15:50:19.940",
                                "2007-MAR-04 15:50:19.940",
                                "2007-MAR-18 09:59:05.966",
                                "2007-MAR-18 09:59:05.966"],
                        "<" => ["2007-JAN-02 00:35:19.583",
                                "2007-JAN-19 22:04:54.905",
                                "2007-FEB-01 23:30:13.439",
                                "2007-FEB-17 11:10:46.547",
                                "2007-MAR-04 15:50:19.940",
                                "2007-MAR-18 09:59:05.966"],
                        ">" => ["2007-JAN-01 00:00:00.000",
                                "2007-JAN-02 00:35:19.583",
                                "2007-JAN-19 22:04:54.905",
                                "2007-FEB-01 23:30:13.439",
                                "2007-FEB-17 11:10:46.547",
                                "2007-MAR-04 15:50:19.940",
                                "2007-MAR-18 09:59:05.966",
                                "2007-APR-01 00:00:00.000"],
                        "LOCMIN" => ["2007-JAN-11 07:03:59.001",
                                     "2007-JAN-11 07:03:59.001",
                                     "2007-FEB-10 06:26:15.451",
                                     "2007-FEB-10 06:26:15.451",
                                     "2007-MAR-12 03:28:36.414",
                                     "2007-MAR-12 03:28:36.414"],
                        "ABSMIN" => ["2007-JAN-11 07:03:59.001",
                                     "2007-JAN-11 07:03:59.001"],
                        "LOCMAX" => ["2007-JAN-26 02:27:33.772",
                                     "2007-JAN-26 02:27:33.772",
                                     "2007-FEB-24 09:35:07.822",
                                     "2007-FEB-24 09:35:07.822",
                                     "2007-MAR-25 17:26:56.158",
                                     "2007-MAR-25 17:26:56.158"],
                        "ABSMAX" => ["2007-MAR-25 17:26:56.158",
                                     "2007-MAR-25 17:26:56.158"])
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2007 JAN 01")
            et1 = str2et("2007 APR 01")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            for relation in relate
                result = gfrr("MOON", "NONE", "SUN", relation, 0.3365, 0.0, spd(), 2000, cnfine)
                count = wncard(result)
                if count > 0
                    results = String[]
                    for i in 1:count
                        left, right = wnfetd(result, i)
                        timstr_left = timout(left, "YYYY-MON-DD HR:MN:SC.###", 41)
                        timstr_right = timout(right, "YYYY-MON-DD HR:MN:SC.###", 41)
                        push!(results, timstr_left)
                        push!(results, timstr_right)
                    end
                    @test results == expected[relation]
                end
            end
        finally
            kclear()
        end
    end
    @testset "gfsep" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            expected = ["2007-JAN-03 14:20:24.628017 (TDB)",
                        "2007-FEB-02 06:16:24.111794 (TDB)",
                        "2007-MAR-03 23:22:42.005064 (TDB)",
                        "2007-APR-02 16:49:16.145506 (TDB)",
                        "2007-MAY-02 09:41:43.840096 (TDB)",
                        "2007-JUN-01 01:03:44.537483 (TDB)",
                        "2007-JUN-30 14:15:26.586223 (TDB)",
                        "2007-JUL-30 01:14:49.010797 (TDB)",
                        "2007-AUG-28 10:39:01.398087 (TDB)",
                        "2007-SEP-26 19:25:51.519413 (TDB)",
                        "2007-OCT-26 04:30:56.635336 (TDB)",
                        "2007-NOV-24 14:31:04.341632 (TDB)",
                        "2007-DEC-24 01:40:12.245932 (TDB)"]
            et0 = str2et("2007 JAN 01")
            et1 = str2et("2008 JAN 01")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = gfsep("MOON", "SPHERE", "NULL", "SUN", "SPHERE", "NULL", "NONE", "EARTH",
                           "LOCMAX", 0.0, 0.0, 6.0 * spd(), 1000, cnfine)
            count = wncard(result)
            @test count == 13
            results = []
        for i in 1:count
                start, stop = wnfetd(result, i)
                @test start == stop
                push!(results, timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41))
            end
            @test results == expected
        finally
            kclear()
        end
    end
    @testset "gfsntc" begin
        kclear()
        kernel = tempname()
        open(kernel, "w") do kernel_file
            write(kernel_file, "\\begindata\n")
            write(kernel_file, "FRAME_SEM                     =  10100000\n")
            write(kernel_file, "FRAME_10100000_NAME           = 'SEM'\n")
            write(kernel_file, "FRAME_10100000_CLASS          =  5\n")
            write(kernel_file, "FRAME_10100000_CLASS_ID       =  10100000\n")
            write(kernel_file, "FRAME_10100000_CENTER         =  10\n")
            write(kernel_file, "FRAME_10100000_RELATIVE       = 'J2000'\n")
            write(kernel_file, "FRAME_10100000_DEF_STYLE      = 'PARAMETERIZED'\n")
            write(kernel_file, "FRAME_10100000_FAMILY         = 'TWO-VECTOR'\n")
            write(kernel_file, "FRAME_10100000_PRI_AXIS       = 'X'\n")
            write(kernel_file, "FRAME_10100000_PRI_VECTOR_DEF = 'OBSERVER_TARGET_POSITION'\n")
            write(kernel_file, "FRAME_10100000_PRI_OBSERVER   = 'SUN'\n")
            write(kernel_file, "FRAME_10100000_PRI_TARGET     = 'EARTH'\n")
            write(kernel_file, "FRAME_10100000_PRI_ABCORR     = 'NONE'\n")
            write(kernel_file, "FRAME_10100000_SEC_AXIS       = 'Y'\n")
            write(kernel_file, "FRAME_10100000_SEC_VECTOR_DEF = 'OBSERVER_TARGET_VELOCITY'\n")
            write(kernel_file, "FRAME_10100000_SEC_OBSERVER   = 'SUN'\n")
            write(kernel_file, "FRAME_10100000_SEC_TARGET     = 'EARTH'\n")
            write(kernel_file, "FRAME_10100000_SEC_ABCORR     = 'NONE'\n")
            write(kernel_file, "FRAME_10100000_SEC_FRAME      = 'J2000'\n")
        end
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            furnsh(kernel)
            et0 = str2et("2007 JAN 01")
            et1 = str2et("2008 JAN 01")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = gfsntc("EARTH", "IAU_EARTH", "Ellipsoid", "NONE", "SUN", "SEM", [1.0, 0.0, 0.0],
                            "LATITUDINAL", "LATITUDE", "=", 0.0, 0.0, 90.0 * spd(), 1000, cnfine)
            count = wncard(result)
            @test count > 0
            beg, stop = wnfetd(result, 1)
            begstr = timout(beg, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
            endstr = timout(stop, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
            @test begstr == "2007-MAR-21 00:01:25.527303 (TDB)"
            @test endstr == "2007-MAR-21 00:01:25.527303 (TDB)"
            beg, stop = wnfetd(result, 2)
            begstr = timout(beg, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
            endstr = timout(stop, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
            @test startswith(begstr, "2007-SEP-23 09:46:39.60698")
            @test startswith(endstr, "2007-SEP-23 09:46:39.60698")
        finally
            kclear()
        end
    end
    @testset "gfstep/gfsstp" begin
        gfsstp(0.5)
        @test gfstep(0.5) == 0.5
    end
    @testset "gfsubc" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2007 JAN 01")
            et1 = str2et("2008 JAN 01")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = gfsubc("earth", "iau_earth", "Near point: ellipsoid", "none", "sun",
                            "geodetic", "latitude", ">", deg2rad(16.0), 0.0, spd() * 90.0, 1000,
                            cnfine)
            count = wncard(result)
            @test count > 0
            start, stop = wnfetd(result, 1)
            start_time = timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
            end_time = timout(stop, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
            @test start_time == "2007-MAY-04 17:08:56.724320 (TDB)"
            @test end_time == "2007-AUG-09 01:51:29.307830 (TDB)"
        finally
            kclear()
        end
    end
    @testset "gftfov" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk),
                   path(CASSINI, :ck),
                   path(CASSINI, :fk),
                   path(CASSINI, :ik),
                   path(CASSINI, :pck),
                   path(CASSINI, :sclk),
                   path(CASSINI, :tour_spk),
                   path(CASSINI, :sat_spk))
            et_start1 = str2et("2013-FEB-25 07:20:00.000")
            et_end1 = str2et("2013-FEB-25 11:45:00.000")
            et_start2 = str2et("2013-FEB-25 11:55:00.000")
            et_end2 = str2et("2013-FEB-26 14:25:00.000")
            cnfine = SpiceDoubleCell(4)
            wninsd!(cnfine, et_start1, et_end1)
            wninsd!(cnfine, et_start2, et_end2)
            result = gftfov("CASSINI_ISS_NAC", "ENCELADUS", "ELLIPSOID", "IAU_ENCELADUS", "LT", "CASSINI", 10.0, 5000, cnfine)
            @test card(result) == 4
            s_timout = "YYYY-MON-DD HR:MN:SC UTC ::RND"
            @test timout(result[1], s_timout) == "2013-FEB-25 10:42:33 UTC"
            @test timout(result[2], s_timout) == "2013-FEB-25 11:45:00 UTC"
            @test timout(result[3], s_timout) == "2013-FEB-25 11:55:00 UTC"
            @test timout(result[4], s_timout) == "2013-FEB-25 12:04:30 UTC"
        finally
            kclear()
        end
    end
    @testset "gfudb" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et_start = str2et("Jan 1 2001")
            et_end = str2et("Jan 1 2002")
            result = SpiceDoubleCell(40000)
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et_start, et_end)
            step = 5.0 * spd()

            function gfq(_, et)
                state, lt = spkez(301, et, "IAU_EARTH", "NONE", 399)
                state[3] >= 0.0 && state[6] > 0.0
            end

            gfudb!(_ -> 0.0, gfq, step, cnfine, result)
            @test length(result) > 20 # true value is 28
        finally
            kclear()
        end
    end
    @testset "gfudb2" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et_start = str2et("Jan 1 2001")
            et_end = str2et("Jan 1 2002")
            result = SpiceDoubleCell(40000)
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et_start, et_end)
            step = 60.0 * 60.0

            function gfq(et)
                pos, _ = spkezp(301, et, "IAU_EARTH", "NONE", 399)
                pos[3]
            end

            function gfb(udfuns, et)
                value = udfuns(et)
                -1000.0 <= value <= 1000.0
            end

            gfudb!(gfq, gfb, step, cnfine, result)
            @test length(result) > 50  # true value is 56
        finally
            kclear()
        end
    end
    @testset "gfuds" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            relations = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
            et_start = str2et("Jan 1 2007")
            et_end = str2et("Apr 1 2007")
            step = spd()
            adjust = 0.0
            refval  = 0.3365

            function gfq(et)
                state, _ = spkez(301, et, "J2000", "NONE", 10)
                dvnorm(state)
            end

            function gfdecrx(udfuns, et)
                h = 1.0
                dx = uddf(udfuns, et, h)
                dx < 0.0
            end

            @testset for r in relations
                result = SpiceDoubleCell(40000)
                cnfine = SpiceDoubleCell(2)
                wninsd!(cnfine, et_start, et_end)
                result = gfuds!(gfq, gfdecrx, r, refval, adjust, step, 20000, cnfine, result)
                @test length(result) > 0
            end
        finally
            kclear()
        end
    end
    @testset "gipool" begin
        try
            data = collect(1:10)
            pipool("pipool_array", data)
            ivals = gipool("pipool_array")
            @test data == ivals
        finally
            kclear()
        end
    end
    @testset "gnpool" begin
        try
            furnsh(path(CORE, :pck))
            var = "BODY599*"
            index = 1
            room = 10
            expected = ["BODY599_POLE_DEC", "BODY599_LONG_AXIS", "BODY599_PM", "BODY599_RADII",
                        "BODY599_POLE_RA", "BODY599_NUT_PREC_PM", "BODY599_NUT_PREC_DEC",
                        "BODY599_NUT_PREC_RA"]
            kervar = gnpool(var, index, room)
            @test Set(expected) == Set(kervar)
            @test gnpool("BLOB", index, room) === nothing
        finally
            kclear()
        end
    end
end
