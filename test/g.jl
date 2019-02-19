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
            act = gdpool("array", start=8)
            @test [8.0, 9.0, 10.0] == act
            act = gdpool("array", room=8)
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


# @testset "getelm" begin
#     kclear()
#     tle = ["1 18123U 87 53  A 87324.61041692 -.00000023  00000-0 -75103-5 0 00675",
#            "2 18123  98.8296 152.0074 0014950 168.7820 191.3688 14.12912554 21686"]
#     furnsh(CoreKernels.testMetaKernel)
#     epoch, elems = getelm(1950, 75, tle)
#     expected_elems = [-6.969196665949579e-13, 0.0, -7.510300000000001e-06,
#                       1.724901918428988, 2.653029617396028, 0.001495,
#                       2.9458016181010693, 3.3400156455905243, 0.06164994027515544, -382310404.79526937]
#     expected_epoch = -382310404.79526937
#     npt.assert_array_almost_equal(expected_elems, elems)
#     npt.assert_almost_equal(epoch, expected_epoch)
#     kclear()


# @testset "getfat" begin
#     arch, outtype = getfat(CoreKernels.lsk)
#     assert arch == "KPL"
#     assert outtype == "LSK"


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


# @testset "getmsg" begin
#     sigerr("test error")
#     message = getmsg("SHORT", 200)
#     assert message == "test error"
#     reset()


# @testset "gfbail" begin
#     assert not gfbail()


# @testset "gfclrh" begin
#     gfclrh()
#     assert not gfbail()


# @testset "gfdist" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     et0 = str2et("2007 JAN 01 00:00:00 TDB")
#     et1 = str2et("2007 APR 01 00:00:00 TDB")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     result = SpiceDoubleCell(1000)
#     gfdist("moon", "none", "earth", ">", 400000, 0.0, spd(), 1000, cnfine, result)
#     count = wncard(result)
#     assert count == 4
#     tempResults = []
#     for i in range(0, count):
#         left, right = wnfetd(result, i)
#         timstrLeft = timout(left, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#         timstrRight = timout(right, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#         tempResults.append(timstrLeft)
#         tempResults.append(timstrRight)
#     expected = ["2007-JAN-08 00:11:07.661897 (TDB)", "2007-JAN-13 06:37:47.937762 (TDB)",
#                 "2007-FEB-04 07:02:35.320555 (TDB)", "2007-FEB-10 09:31:01.829206 (TDB)",
#                 "2007-MAR-03 00:20:25.228066 (TDB)", "2007-MAR-10 14:04:38.482902 (TDB)",
#                 "2007-MAR-29 22:53:58.186230 (TDB)", "2007-APR-01 00:00:00.000000 (TDB)"]
#     assert tempResults == expected
#     kclear()


# @testset "gfevnt" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     #
#     et_start = str2et("2001 jan 01 00:00:00.000")
#     et_end   = str2et("2001 dec 31 00:00:00.000")
#     cnfine   = SpiceDoubleCell(2)
#     wninsd(et_start, et_end, cnfine)
#     result   = SpiceDoubleCell(1000)
#     qpnams   = ["TARGET", "OBSERVER", "ABCORR"]
#     qcpars   = ["MOON  ", "EARTH   ", "LT+S  "]
#     # Set the step size to 1/1000 day and convert to seconds
#     gfsstp(0.001 * spd())
#     # setup callbacks
#     udstep = spiceypy.utils.callbacks.SpiceUDSTEP(gfstep)
#     udrefn = spiceypy.utils.callbacks.SpiceUDREFN(gfrefn)
#     udrepi = spiceypy.utils.callbacks.SpiceUDREPI(gfrepi)
#     udrepu = spiceypy.utils.callbacks.SpiceUDREPU(gfrepu)
#     udrepf = spiceypy.utils.callbacks.SpiceUDREPF(gfrepf)
#     udbail = spiceypy.utils.callbacks.SpiceUDBAIL(gfbail)
#     qdpars = np.zeros(10, dtype=np.float)
#     qipars = np.zeros(10, dtype=np.int32)
#     qlpars = np.zeros(10, dtype=np.int32)
#     # call gfevnt
#     gfevnt(udstep, udrefn, "DISTANCE", 3, 81, qpnams, qcpars,
#                  qdpars, qipars, qlpars, "LOCMAX", 0, 1.e-6, 0,
#                  True, udrepi, udrepu, udrepf, 10000,
#                  True, udbail, cnfine, result)

#     # Verify the expected results
#     assert len(result) == 26
#     sTimout = "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND"
#     assert timout(result[0], sTimout) == "2001-JAN-24 19:22:01.418715 (TDB)"
#     assert timout(result[1], sTimout) == "2001-JAN-24 19:22:01.418715 (TDB)"
#     assert timout(result[2], sTimout) == "2001-FEB-20 21:52:07.900872 (TDB)"
#     assert timout(result[3], sTimout) == "2001-FEB-20 21:52:07.900872 (TDB)"
#     # Cleanup
#     if gfbail():
#         gfclrh()
#     gfsstp(0.5)
#     kclear()


# @testset "gffove" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     furnsh(CassiniKernels.cassCk)
#     furnsh(CassiniKernels.cassFk)
#     furnsh(CassiniKernels.cassIk)
#     furnsh(CassiniKernels.cassPck)
#     furnsh(CassiniKernels.cassSclk)
#     furnsh(CassiniKernels.cassTourSpk)
#     furnsh(CassiniKernels.satSpk)
#     # Cassini ISS NAC observed Enceladus on 2013-FEB-25 from ~11:00 to ~12:00
#     # Split confinement window, from continuous CK coverage, into two pieces
#     et_start = str2et("2013-FEB-25 10:00:00.000")
#     et_end   = str2et("2013-FEB-25 11:45:00.000")
#     cnfine   = SpiceDoubleCell(2)
#     wninsd(et_start, et_end, cnfine)
#     result   = SpiceDoubleCell(1000)
#     # call gffove
#     udstep = spiceypy.utils.callbacks.SpiceUDSTEP(gfstep)
#     udrefn = spiceypy.utils.callbacks.SpiceUDREFN(gfrefn)
#     udrepi = spiceypy.utils.callbacks.SpiceUDREPI(gfrepi)
#     udrepu = spiceypy.utils.callbacks.SpiceUDREPU(gfrepu)
#     udrepf = spiceypy.utils.callbacks.SpiceUDREPF(gfrepf)
#     udbail = spiceypy.utils.callbacks.SpiceUDBAIL(gfbail)
#     gfsstp(1.0)
#     gffove("CASSINI_ISS_NAC", "ELLIPSOID", [0.0, 0.0, 0.0], "ENCELADUS", "IAU_ENCELADUS",
#                  "LT+S", "CASSINI", 1.e-6, udstep, udrefn, True,
#                  udrepi, udrepu, udrepf, True, udbail,
#                  cnfine, result)
#     # Verify the expected results
#     assert len(result) == 2
#     sTimout = "YYYY-MON-DD HR:MN:SC UTC ::RND"
#     assert timout(result[0], sTimout) == "2013-FEB-25 10:42:33 UTC"
#     assert timout(result[1], sTimout) == "2013-FEB-25 11:45:00 UTC"
#     # Cleanup
#     if gfbail():
#         gfclrh()
#     gfsstp(0.5)
#     kclear()


# @testset "gfilum" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     furnsh(ExtraKernels.marsSpk)         # to get Phobos ephemeris
#     # Hard-code the future position of MER-1
#     # pos, lt = spkpos("MER-1", str2et("2006 OCT 02 00:00:00 UTC"), "iau_mars", "CN+S", "Mars")
#     pos = [3376.17890941875839416753, -325.55203839445334779157, -121.47422900638389364758]
#     # Two-month Viking orbiter window for Phobos;
#     # - marsSPK runs from [1971 OCT 01] to [1972 OCT 01]
#     startET = str2et("1971 OCT 02 00:00:00 UTC")
#     endET   = str2et("1971 NOV 30 12:00:00 UTC")
#     # Create confining and result windows for incidence angle GF check
#     cnfine  = SpiceDoubleCell(2000)
#     wninsd(startET, endET, cnfine)
#     wnsolr  = SpiceDoubleCell(2000)
#     # Find windows where solar incidence angle at MER-1 position is < 60deg
#     gfilum("Ellipsoid", "INCIDENCE", "Mars", "Sun",
#                  "iau_mars", "CN+S", "PHOBOS", pos,
#                  "<", 60.0 * rpd(), 0.0, 21600.0,
#                  1000, cnfine, wnsolr)
#     # Create result window for emission angle GF check
#     result = SpiceDoubleCell(2000)
#     # Find windows, within solar incidence angle windows found above (wnsolar),
#     # where emission angle from MER-1 position to Phobos is < 20deg
#     gfilum("Ellipsoid", "EMISSION", "Mars", "Sun",
#                  "iau_mars", "CN+S", "PHOBOS", pos,
#                  "<", 20.0 * rpd(), 0.0, 900.0,
#                  1000, wnsolr, result)
#     # Ensure there were some results
#     assert wncard(result) > 0
#     startEpoch = timout(result[0],  "YYYY MON DD HR:MN:SC.###### UTC")
#     endEpoch   = timout(result[-1], "YYYY MON DD HR:MN:SC.###### UTC")
#     # Check times of results
#     assert startEpoch.startswith("1971 OCT 02")
#     assert endEpoch.startswith("1971 NOV 29")
#     # Cleanup
#     kclear()


# @testset "gfinth" begin
#     gfinth(2)
#     with pytest.raises(stypes.SpiceyError):
#         gfinth(0)


# @testset "gfocce" begin
#     kclear()
#     if gfbail():
#         gfclrh()
#     furnsh(CoreKernels.testMetaKernel)
#     et0 = str2et("2001 DEC 01 00:00:00 TDB")
#     et1 = str2et("2002 JAN 01 00:00:00 TDB")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     result = SpiceDoubleCell(1000)
#     gfsstp(20.0)
#     udstep = spiceypy.utils.callbacks.SpiceUDSTEP(gfstep)
#     udrefn = spiceypy.utils.callbacks.SpiceUDREFN(gfrefn)
#     udrepi = spiceypy.utils.callbacks.SpiceUDREPI(gfrepi)
#     udrepu = spiceypy.utils.callbacks.SpiceUDREPU(gfrepu)
#     udrepf = spiceypy.utils.callbacks.SpiceUDREPF(gfrepf)
#     udbail = spiceypy.utils.callbacks.SpiceUDBAIL(gfbail)
#     # call gfocce
#     gfocce("Any", "moon", "ellipsoid", "iau_moon", "sun",
#                  "ellipsoid", "iau_sun", "lt", "earth", 1.e-6,
#                  udstep, udrefn, True, udrepi, udrepu, udrepf,
#                  True, udbail, cnfine, result)
#     if gfbail():
#         gfclrh()
#     count = wncard(result)
#     assert count == 1
#     kclear()


# @testset "gfoclt" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     et0 = str2et("2001 DEC 01 00:00:00 TDB")
#     et1 = str2et("2002 JAN 01 00:00:00 TDB")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     result = SpiceDoubleCell(1000)
#     gfoclt("any", "moon", "ellipsoid", "iau_moon", "sun",
#                  "ellipsoid", "iau_sun", "lt", "earth", 180.0, cnfine, result)
#     count = wncard(result)
#     assert count == 1
#     start, end = wnfetd(result, 0)
#     startTime = timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#     endTime = timout(end, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#     assert startTime == "2001-DEC-14 20:10:14.203347 (TDB)"
#     assert endTime == "2001-DEC-14 21:35:50.328804 (TDB)"
#     kclear()


    @testset "gfpa" begin
        relate = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
        expected = Dict(
            "=" => [
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
            ]
        )
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2006 DEC 01")
            et1 = str2et("2007 JAN 31")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = SpiceDoubleCell(2000)
            for relation in relate
                gfpa!(cnfine, result, "Moon", "Sun", "LT+S", "Earth", relation, 0.57598845,
                     0.0, spd(), 5000)
                count = wncard(result)
                @test count > 0
                if count > 0
                    temp_results = []
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


# @testset "gfposc" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     et0 = str2et("2007 JAN 01")
#     et1 = str2et("2008 JAN 01")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     result = SpiceDoubleCell(1000)
#     gfposc("sun", "iau_earth", "none", "earth", "latitudinal", "latitude",
#                  "absmax", 0.0, 0.0, 90.0 * spd(), 1000, cnfine, result)
#     count = wncard(result)
#     assert count == 1
#     start, end = wnfetd(result, 0)
#     startTime = timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#     endTime = timout(end, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#     assert startTime == endTime
#     assert startTime == "2007-JUN-21 17:54:13.201561 (TDB)"
#     kclear()


# @testset "gfrefn" begin
#     s1 = [True, False]
#     s2 = [True, False]
#     for i in range(0, 2):
#         for j in range(0, 2):
#             scale = 10.0 * i + j
#             t1 = 5.0 * scale
#             t2 = 7.0 * scale
#             t  = gfrefn(t1, t2, s1[i], s2[j])
#             assert t == pytest.approx(scale*6.0)
#     for i in range(0, 2):
#         for j in range(0, 2):
#             scale = 10.0 * i + j
#             t1 = 15.0 * scale
#             t2 = 7.0 * scale
#             t  = gfrefn(t1, t2, s1[i], s2[j])
#             assert t == pytest.approx(scale*11.0)
#     for i in range(0, 2):
#         for j in range(0, 2):
#             scale = 10.0 * i + j
#             t1 = -scale
#             t2 = -scale
#             t  = gfrefn(t1, t2, s1[i], s2[j])
#             assert t == pytest.approx(-scale)

# @testset "gfrepf" begin
#     # Minimal test; gfrepf does nothing PyTest can notice
#     gfrepf()
#     # Pass bad argument list
#     with pytest.raises(TypeError):
#         gfrepf(0)


# @testset "gfrepi" begin
#     window = SpiceDoubleCell(4)
#     wninsd(0., 100., window)
#     gfrepi(window, "x", "y")
#     # BEGMSS or ENDMSS empty, too long, or containing non-printing characters
#     with pytest.raises(stypes.SpiceyError):
#         gfrepi(window, "", "y")
#     with pytest.raises(stypes.SpiceyError):
#         gfrepi(window, "x", "")
#     with pytest.raises(stypes.SpiceyError):
#         gfrepi(window, "x"*1000, "y")
#     with pytest.raises(stypes.SpiceyError):
#         gfrepi(window, "x", "y"*1000)
#     with pytest.raises(stypes.SpiceyError):
#         gfrepi(window, "y\n", "y")
#     with pytest.raises(stypes.SpiceyError):
#         gfrepi(window, "x", "y\n")
#     gfrepf()


# @testset "gfrepu" begin
#     window = SpiceDoubleCell(4)
#     wninsd(0., 100., window)
#     gfrepi(window, "x", "y")
#     gfrepu(0., 100., 50.)
#     gfrepu(0., 100., 100.)
#     with pytest.raises(stypes.SpiceyError):
#         gfrepu(100., 0., 100.)
#     with pytest.raises(stypes.SpiceyError):
#         gfrepu(0., 100., -1.)
#     with pytest.raises(stypes.SpiceyError):
#         gfrepu(0., 100., 1011.)
#     gfrepu(0., 100., 100.)
#     gfrepf()


# @testset "gfrfov" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     furnsh(CassiniKernels.cassCk)
#     furnsh(CassiniKernels.cassFk)
#     furnsh(CassiniKernels.cassIk)
#     furnsh(CassiniKernels.cassPck)
#     furnsh(CassiniKernels.cassSclk)
#     furnsh(CassiniKernels.cassTourSpk)
#     furnsh(CassiniKernels.satSpk)
#     # Changed ABCORR to NONE from S for this test, so we do not need SSB
#     # begin test
#     inst  = "CASSINI_ISS_WAC"
#     # Cassini ISS NAC observed Enceladus on 2013-FEB-25 from ~11:00 to ~12:00
#     # Split confinement window, from continuous CK coverage, into two pieces
#     et_start1 = str2et("2013-FEB-25 07:20:00.000")
#     et_end1   = str2et("2013-FEB-25 11:45:00.000") #\
#     et_start2 = str2et("2013-FEB-25 11:55:00.000") #_>synthetic 10min gap
#     et_end2   = str2et("2013-FEB-26 14:25:00.000")
#     cnfine    = SpiceDoubleCell(4)
#     wninsd(et_start1, et_end1, cnfine)
#     wninsd(et_start2, et_end2, cnfine)
#     # The ray direction vector is from Cassini toward Enceladus during the gap
#     et_nom    = str2et("2013-FEB-25 11:50:00.000") #\
#     raydir, lt  = spkpos("Enceladus", et_nom, "J2000", "NONE", "Cassini")
#     result   = SpiceDoubleCell(2000)
#     gfrfov(inst, raydir, "J2000", "NONE", "Cassini", 10.0, cnfine, result)
#     # Verify the expected results
#     assert len(result) == 4
#     sTimout = "YYYY-MON-DD HR:MN:SC UTC ::RND"
#     assert timout(result[0], sTimout) == "2013-FEB-25 11:26:46 UTC"
#     assert timout(result[1], sTimout) == "2013-FEB-25 11:45:00 UTC"
#     assert timout(result[2], sTimout) == "2013-FEB-25 11:55:00 UTC"
#     assert timout(result[3], sTimout) == "2013-FEB-25 12:05:33 UTC"
#     # Cleanup
#     kclear()


# @testset "gfrr" begin
#     relate = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
#     expected = {"=": ["2007-JAN-02 00:35:19.583", "2007-JAN-02 00:35:19.583", "2007-JAN-19 22:04:54.905",
#                       "2007-JAN-19 22:04:54.905", "2007-FEB-01 23:30:13.439", "2007-FEB-01 23:30:13.439",
#                       "2007-FEB-17 11:10:46.547", "2007-FEB-17 11:10:46.547", "2007-MAR-04 15:50:19.940",
#                       "2007-MAR-04 15:50:19.940", "2007-MAR-18 09:59:05.966", "2007-MAR-18 09:59:05.966"],
#                 "<": ["2007-JAN-02 00:35:19.583", "2007-JAN-19 22:04:54.905", "2007-FEB-01 23:30:13.439",
#                       "2007-FEB-17 11:10:46.547", "2007-MAR-04 15:50:19.940", "2007-MAR-18 09:59:05.966"],
#                 ">": ["2007-JAN-01 00:00:00.000", "2007-JAN-02 00:35:19.583", "2007-JAN-19 22:04:54.905",
#                       "2007-FEB-01 23:30:13.439", "2007-FEB-17 11:10:46.547", "2007-MAR-04 15:50:19.940",
#                       "2007-MAR-18 09:59:05.966", "2007-APR-01 00:00:00.000"],
#                 "LOCMIN": ["2007-JAN-11 07:03:59.001", "2007-JAN-11 07:03:59.001",
#                            "2007-FEB-10 06:26:15.451", "2007-FEB-10 06:26:15.451",
#                            "2007-MAR-12 03:28:36.414", "2007-MAR-12 03:28:36.414"],
#                 "ABSMIN": ["2007-JAN-11 07:03:59.001", "2007-JAN-11 07:03:59.001"],
#                 "LOCMAX": ["2007-JAN-26 02:27:33.772", "2007-JAN-26 02:27:33.772",
#                            "2007-FEB-24 09:35:07.822", "2007-FEB-24 09:35:07.822",
#                            "2007-MAR-25 17:26:56.158", "2007-MAR-25 17:26:56.158"],
#                 "ABSMAX": ["2007-MAR-25 17:26:56.158", "2007-MAR-25 17:26:56.158"]}
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     et0 = str2et("2007 JAN 01")
#     et1 = str2et("2007 APR 01")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     for relation in relate:
#         result = SpiceDoubleCell(2000)
#         gfrr("moon", "none", "sun", relation, 0.3365, 0.0, spd(), 2000, cnfine, result)
#         count = wncard(result)
#         if count > 0:
#             tempResults = []
#             for i in range(0, count):
#                 left, right = wnfetd(result, i)
#                 timstrLeft = timout(left, "YYYY-MON-DD HR:MN:SC.###", 41)
#                 timstrRight = timout(right, "YYYY-MON-DD HR:MN:SC.###", 41)
#                 tempResults.append(timstrLeft)
#                 tempResults.append(timstrRight)
#             assert tempResults == expected.get(relation)
#     kclear()


# @testset "gfsep" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     expected = ["2007-JAN-03 14:20:24.628017 (TDB)", "2007-FEB-02 06:16:24.111794 (TDB)",
#                 "2007-MAR-03 23:22:42.005064 (TDB)", "2007-APR-02 16:49:16.145506 (TDB)",
#                 "2007-MAY-02 09:41:43.840096 (TDB)", "2007-JUN-01 01:03:44.537483 (TDB)",
#                 "2007-JUN-30 14:15:26.586223 (TDB)", "2007-JUL-30 01:14:49.010797 (TDB)",
#                 "2007-AUG-28 10:39:01.398087 (TDB)", "2007-SEP-26 19:25:51.519413 (TDB)",
#                 "2007-OCT-26 04:30:56.635336 (TDB)", "2007-NOV-24 14:31:04.341632 (TDB)",
#                 "2007-DEC-24 01:40:12.245932 (TDB)"]
#     et0 = str2et("2007 JAN 01")
#     et1 = str2et("2008 JAN 01")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     result = SpiceDoubleCell(2000)
#     gfsep("MOON", "SPHERE", "NULL", "SUN", "SPHERE", "NULL", "NONE", "EARTH",
#                 "LOCMAX", 0.0, 0.0, 6.0 * spd(), 1000, cnfine, result)
#     count = wncard(result)
#     assert count == 13
#     tempResults = []
#     for i in range(0, count):
#         start, end = wnfetd(result, i)
#         assert start == end
#         tempResults.append(timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41))
#     assert tempResults == expected
#     kclear()


# @testset "gfsntc" begin
#     kclear()
#     kernel = os.path.join(cwd, "gfnstc_test.tf")
#     if exists(kernel):
#         os.remove(kernel) # pragma: no cover # pragma: no cover 
#     with open(kernel, "w") as kernelFile:
#         kernelFile.write("\\begindata\n")
#         kernelFile.write("FRAME_SEM                     =  10100000\n")
#         kernelFile.write("FRAME_10100000_NAME           = "SEM"\n")
#         kernelFile.write("FRAME_10100000_CLASS          =  5\n")
#         kernelFile.write("FRAME_10100000_CLASS_ID       =  10100000\n")
#         kernelFile.write("FRAME_10100000_CENTER         =  10\n")
#         kernelFile.write("FRAME_10100000_RELATIVE       = "J2000"\n")
#         kernelFile.write("FRAME_10100000_DEF_STYLE      = "PARAMETERIZED"\n")
#         kernelFile.write("FRAME_10100000_FAMILY         = "TWO-VECTOR"\n")
#         kernelFile.write("FRAME_10100000_PRI_AXIS       = "X"\n")
#         kernelFile.write("FRAME_10100000_PRI_VECTOR_DEF = "OBSERVER_TARGET_POSITION"\n")
#         kernelFile.write("FRAME_10100000_PRI_OBSERVER   = "SUN"\n")
#         kernelFile.write("FRAME_10100000_PRI_TARGET     = "EARTH"\n")
#         kernelFile.write("FRAME_10100000_PRI_ABCORR     = "NONE"\n")
#         kernelFile.write("FRAME_10100000_SEC_AXIS       = "Y"\n")
#         kernelFile.write("FRAME_10100000_SEC_VECTOR_DEF = "OBSERVER_TARGET_VELOCITY"\n")
#         kernelFile.write("FRAME_10100000_SEC_OBSERVER   = "SUN"\n")
#         kernelFile.write("FRAME_10100000_SEC_TARGET     = "EARTH"\n")
#         kernelFile.write("FRAME_10100000_SEC_ABCORR     = "NONE"\n")
#         kernelFile.write("FRAME_10100000_SEC_FRAME      = "J2000"\n")
#         kernelFile.close()
#     furnsh(CoreKernels.testMetaKernel)
#     furnsh(kernel)
#     et0 = str2et("2007 JAN 01")
#     et1 = str2et("2008 JAN 01")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     result = SpiceDoubleCell(2000)
#     gfsntc("EARTH", "IAU_EARTH", "Ellipsoid", "NONE", "SUN", "SEM", [1.0, 0.0, 0.0], "LATITUDINAL",
#                  "LATITUDE", "=", 0.0, 0.0, 90.0 * spd(), 1000, cnfine, result)
#     count = wncard(result)
#     assert count > 0
#     beg, end = wnfetd(result, 0)
#     begstr = timout(beg, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
#     endstr = timout(end, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
#     assert begstr == "2007-MAR-21 00:01:25.527303 (TDB)"
#     assert endstr == "2007-MAR-21 00:01:25.527303 (TDB)"
#     beg, end = wnfetd(result, 1)
#     begstr = timout(beg, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
#     endstr = timout(end, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 80)
#     assert begstr == "2007-SEP-23 09:46:39.606982 (TDB)"
#     assert endstr == "2007-SEP-23 09:46:39.606982 (TDB)"
#     kclear()
#     if exists(kernel):
#         os.remove(kernel) # pragma: no cover # pragma: no cover


# @testset "gfsstp" begin
#     gfsstp(0.5)
#     assert gfstep(0.5) == 0.5


# @testset "gfstep" begin
#     gfsstp(0.5)
#     assert gfstep(0.5) == 0.5


# @testset "gfstol" begin
#     gfstol(1.0e-16)
#     gfstol(1.0e-6)


# @testset "gfsubc" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     et0 = str2et("2007 JAN 01")
#     et1 = str2et("2008 JAN 01")
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et0, et1, cnfine)
#     result = SpiceDoubleCell(2000)
#     gfsubc("earth", "iau_earth", "Near point: ellipsoid", "none", "sun", "geodetic", "latitude", ">",
#                  16.0 * rpd(), 0.0, spd() * 90.0, 1000, cnfine, result)
#     count = wncard(result)
#     assert count > 0
#     start, end = wnfetd(result, 0)
#     startTime = timout(start, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#     endTime = timout(end, "YYYY-MON-DD HR:MN:SC.###### (TDB) ::TDB ::RND", 41)
#     assert startTime == "2007-MAY-04 17:08:56.724320 (TDB)"
#     assert endTime == "2007-AUG-09 01:51:29.307830 (TDB)"
#     kclear()


# @testset "gftfov" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     furnsh(CassiniKernels.cassCk)
#     furnsh(CassiniKernels.cassFk)
#     furnsh(CassiniKernels.cassIk)
#     furnsh(CassiniKernels.cassPck)
#     furnsh(CassiniKernels.cassSclk)
#     furnsh(CassiniKernels.cassTourSpk)
#     furnsh(CassiniKernels.satSpk)
#     # Changed ABCORR to LT from LT+S for this test, so we do not need SSB
#     # begin test
#     # Cassini ISS NAC observed Enceladus on 2013-FEB-25 from ~11:00 to ~12:00
#     # Split confinement window, from continuous CK coverage, into two pieces
#     et_start1 = str2et("2013-FEB-25 07:20:00.000")
#     et_end1   = str2et("2013-FEB-25 11:45:00.000") #\
#     et_start2 = str2et("2013-FEB-25 11:55:00.000") #_>synthetic 10min gap
#     et_end2   = str2et("2013-FEB-26 14:25:00.000")
#     cnfine    = SpiceDoubleCell(4)
#     wninsd(et_start1, et_end1, cnfine)
#     wninsd(et_start2, et_end2, cnfine)
#     # Subtract off the position of the spacecraft relative to the solar system barycenter the result is the ray"s direction vector.
#     result = gftfov("CASSINI_ISS_NAC", "ENCELADUS", "ELLIPSOID", "IAU_ENCELADUS", "LT", "CASSINI", 10.0, cnfine)
#     # Verify the expected results
#     assert card(result) == 4
#     sTimout = "YYYY-MON-DD HR:MN:SC UTC ::RND"
#     assert timout(result[0], sTimout) == "2013-FEB-25 10:42:33 UTC"
#     assert timout(result[1], sTimout) == "2013-FEB-25 11:45:00 UTC"
#     assert timout(result[2], sTimout) == "2013-FEB-25 11:55:00 UTC"
#     assert timout(result[3], sTimout) == "2013-FEB-25 12:04:30 UTC"
#     # Cleanup
#     kclear()


# @testset "gfudb" begin
#     kclear()
#     # load kernels
#     furnsh(CoreKernels.testMetaKernel)
#     # begin test
#     et_start = str2et("Jan 1 2001")
#     et_end   = str2et("Jan 1 2002")
#     result   = SpiceDoubleCell(40000)
#     cnfine   = SpiceDoubleCell(2)
#     wninsd(et_start, et_end, cnfine)
#     step = 5.0 * spd()

#     # make a udf callback
#     udf = spiceypy.utils.callbacks.SpiceUDFUNS(udf)

#     # define gfq
#     @spiceypy.utils.callbacks.SpiceUDFUNB
#     def gfq(udfunc, et):
#         # we are not using udfunc in this example
#         state, lt = spkez(301, et, "IAU_EARTH", "NONE", 399)
#         return state[2] >= 0.0 and state[5] > 0.0

#     # call gfudb
#     gfudb(udf, gfq, step, cnfine, result)
#     # count
#     assert len(result) > 20 # true value is 28
#     kclear()


# @testset "gfudb2" begin
#     kclear()
#     # load kernels
#     furnsh(CoreKernels.testMetaKernel)
#     # begin test
#     et_start = str2et("Jan 1 2001")
#     et_end = str2et("Jan 1 2002")
#     result = SpiceDoubleCell(40000)
#     cnfine = SpiceDoubleCell(2)
#     wninsd(et_start, et_end, cnfine)
#     step = 60.0 * 60.0

#     # define gfq
#     @spiceypy.utils.callbacks.SpiceUDFUNS
#     def gfq(et):
#         pos, lt = spkezp(301, et, "IAU_EARTH", "NONE", 399)
#         return pos[2]

#     # define gfb
#     @spiceypy.utils.callbacks.SpiceUDFUNB
#     def gfb(udfuns, et):
#         value = spiceypy.utils.callbacks.CallUDFUNS(udfuns, et)
#         return -1000.0 <= value <= 1000.0

#     # call gfudb
#     gfudb(gfq, gfb, step, cnfine, result)
#     # count
#     assert len(result) > 50  # true value is 56
#     kclear()


# @testset "gfuds" begin
#     relations = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
#     kclear()
#     # load kernels
#     furnsh(CoreKernels.testMetaKernel)
#     # begin test
#     et_start = str2et("Jan 1 2007")
#     et_end = str2et("Apr 1 2007")
#     # set up some constants
#     step = spd()
#     adjust = 0.0
#     refval  = 0.3365
#     # declare the callbacks we will use in the test
#     @spiceypy.utils.callbacks.SpiceUDFUNS
#     def gfq(et):
#         state, lt = spkez(301, et, "J2000", "NONE", 10)
#         return dvnorm(state)

#     @spiceypy.utils.callbacks.SpiceUDFUNB
#     def gfdecrx(udfuns, et):
#         return uddc(udfuns, et, 10.0)

#     # loop through to test each relation type
#     for i, r in enumerate(relations):
#         result = SpiceDoubleCell(40000)
#         cnfine = SpiceDoubleCell(2)
#         wninsd(et_start, et_end, cnfine)
#         # call gfuds
#         result = gfuds(gfq, gfdecrx, r, refval, adjust, step, 20000, cnfine, result)
#         assert len(result) > 0
#     # cleanup
#     kclear()


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


# @testset "gnpool" begin
#     kclear()
#     furnsh(CoreKernels.testMetaKernel)
#     var = "BODY599*"
#     index = 0
#     room = 10
#     expected = ["BODY599_POLE_DEC", "BODY599_LONG_AXIS", "BODY599_PM", "BODY599_RADII",
#                 "BODY599_POLE_RA", "BODY599_GM", "BODY599_NUT_PREC_PM", "BODY599_NUT_PREC_DEC",
#                 "BODY599_NUT_PREC_RA"]
#     kervar = gnpool(var, index, room)
#     kclear()
# assert set(expected) == set(kervar)
end
