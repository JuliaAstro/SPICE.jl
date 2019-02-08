using LinearAlgebra: I, norm

@testset "S" begin
    @testset "OLD" begin
        @test spd() == 86400.0
        furnsh(path(CORE, :spk))
        @test sxform("J2000", "J2000", 0.0) ≈ Matrix{Float64}(I, 6, 6)
        @test_throws SpiceError sxform("J2000", "Norbert", 0.0)
        @test spkezr("EARTH", 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
        @test spkezr(399, 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
        @test spkezr("EARTH", 0.0, "J2000", 399) == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
        @test spkezr(399, 0.0, "J2000", 399) == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
        @test spkpos("EARTH", 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0], 0.0)
        @test spkpos(399, 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0], 0.0)
        @test spkpos("EARTH", 0.0, "J2000", 399) == ([0.0, 0.0, 0.0], 0.0)
        @test spkpos(399, 0.0, "J2000", 399) == ([0.0, 0.0, 0.0], 0.0)
        kclear()
    end
#= @testset "saelgv" begin =#
#=     vec1 = [1.0, 1.0, 1.0] =#
#=     vec2 = [1.0, -1.0, 1.0] =#
#=     expectedSmajor = [sqrt(2.0), 0.0, sqrt(2.0)] =#
#=     expectedSminor = [0.0, sqrt(2.0), 0.0] =#
#=     smajor, sminor = saelgv(vec1, vec2) =#
#=     npt.assert_array_almost_equal(smajor, expectedSmajor) =#
#=     npt.assert_array_almost_equal(sminor, expectedSminor) =#
#=  =#
#=  =#
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
#= @testset "scdecd" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     timein = scencd(-32, '2/20538:39:768') =#
#=     sclkch = scdecd(-32, timein) =#
#=     assert sclkch == '2/20538:39:768' =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "sce2c" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     et = str2et('1979 JUL 05 21:50:21.23379') =#
#=     sclkdp = sce2c(-32, et) =#
#=     npt.assert_almost_equal(sclkdp, 985327949.9999709, decimal=6) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "sce2s" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     et = str2et('1979 JUL 05 21:50:21.23379') =#
#=     sclkch = sce2s(-32, et) =#
#=     assert sclkch == "2/20538:39:768" =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "sce2t" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     et = str2et('1979 JUL 05 21:50:21.23379') =#
#=     sclkdp = sce2t(-32, et) =#
#=     npt.assert_almost_equal(sclkdp, 985327950.000000) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "scencd" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     sclkch = scdecd(-32, 985327950.0, 50) =#
#=     sclkdp = scencd(-32, sclkch) =#
#=     npt.assert_almost_equal(sclkdp, 985327950.0) =#
#=     assert sclkch == "2/20538:39:768" =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "scfmt" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     pstart, pstop = scpart(-32) =#
#=     start = scfmt(-32, pstart[0]) =#
#=     stop = scfmt(-32, pstop[0]) =#
#=     assert start == "00011:00:001" =#
#=     assert stop == "04011:21:784" =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "scpart" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     pstart, pstop = scpart(-32) =#
#=     assert pstart is not None =#
#=     assert pstop is not None =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "scs2e" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     et = scs2e(-32, '2/20538:39:768') =#
#=     npt.assert_almost_equal(et, -646668528.58222842) =#
#=     utc = et2utc(et, 'C', 3, 50) =#
#=     assert utc == "1979 JUL 05 21:50:21.234" =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "sct2e" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     et = sct2e(-32, 985327965.0) =#
#=     utc = et2utc(et, 'C', 3, 50) =#
#=     assert utc == "1979 JUL 05 21:50:22.134" =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "sctiks" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(ExtraKernels.voyagerSclk) =#
#=     ticks = sctiks(-32, '20656:14:768') =#
#=     assert ticks == 991499967.00000000 =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "sdiff" begin =#
#=     # SPICEINT_CELL =#
#=     a = cell_int(8) =#
#=     b = cell_int(8) =#
#=     insrti(1, a) =#
#=     insrti(2, a) =#
#=     insrti(5, a) =#
#=     insrti(3, b) =#
#=     insrti(4, b) =#
#=     insrti(5, b) =#
#=     c = sdiff(a, b) =#
#=     assert [x for x in c] == [1, 2, 3, 4] =#
#=     # SPICECHAR_CELL =#
#=     a = cell_char(8, 8) =#
#=     b = cell_char(8, 8) =#
#=     insrtc('1', a) =#
#=     insrtc('2', a) =#
#=     insrtc('5', a) =#
#=     insrtc('3', b) =#
#=     insrtc('4', b) =#
#=     insrtc('5', b) =#
#=     c = sdiff(a, b) =#
#=     assert [x for x in c] == ['1', '2', '3', '4'] =#
#=     # SPICEDOUBLE_CELL =#
#=     a = cell_double(8) =#
#=     b = cell_double(8) =#
#=     insrtd(1., a) =#
#=     insrtd(2., a) =#
#=     insrtd(5., a) =#
#=     insrtd(3., b) =#
#=     insrtd(4., b) =#
#=     insrtd(5., b) =#
#=     c = sdiff(a, b) =#
#=     assert [x for x in c] == [1., 2., 3., 4.] =#
#=     # SPICEBOOLEAN_CELL =#
#=     testCellOne = cell_bool(9) =#
#=     testCellTwo = cell_bool(9) =#
#=     with pytest.raises(NotImplementedError): =#
#=         sdiff(testCellOne, testCellTwo) =#
#=  =#
#=  =#
#= @testset "set_c" begin =#
#=     a = cell_int(8) =#
#=     b = cell_int(8) =#
#=     c = cell_int(8) =#
#=     insrti(1, a) =#
#=     insrti(2, a) =#
#=     insrti(3, a) =#
#=     insrti(4, a) =#
#=     insrti(1, b) =#
#=     insrti(3, b) =#
#=     insrti(1, c) =#
#=     insrti(3, c) =#
#=     assert set_c(b, "=", c) =#
#=     assert set_c(a, "<>", c) =#
#=     assert set_c(b, "<=", c) =#
#=     assert not set_c(b, "<", c) =#
#=     assert set_c(c, ">=", b) =#
#=     assert set_c(a, ">", b) =#
#=     assert set_c(b, "&", c) =#
#=     assert not set_c(a, "~", a) =#
#=  =#
#=  =#
#= @testset "setmsg" begin =#
#=     setmsg("test setmsg") =#
#=     sigerr("some error") =#
#=     message = getmsg("LONG", 2000) =#
#=     assert message == "test setmsg" =#
#=     reset() =#
#=  =#
#=  =#
#= @testset "shellc" begin =#
#=     array = ["FEYNMAN", "NEWTON", "EINSTEIN", "GALILEO", "EUCLID", "Galileo"] =#
#=     expected = ["EINSTEIN", "EUCLID", "FEYNMAN", "GALILEO", "Galileo", "NEWTON"] =#
#=     assert shellc(6, 10, array) == expected =#
#=  =#
#=  =#
#= @testset "shelld" begin =#
#=     array = [99.0, 33.0, 55.0, 44.0, -77.0, 66.0] =#
#=     expected = [-77.0, 33.0, 44.0, 55.0, 66.0, 99.0] =#
#=     npt.assert_array_almost_equal(shelld(6, array), expected) =#
#=  =#
#=  =#
#= @testset "shelli" begin =#
#=     array = [99, 33, 55, 44, -77, 66] =#
#=     expected = [-77, 33, 44, 55, 66, 99] =#
#=     npt.assert_array_almost_equal(shelli(6, array), expected) =#
#=  =#
#=  =#
#= @testset "sigerr" begin =#
#=     sigerr("test error") =#
#=     message = getmsg("SHORT", 200) =#
#=     assert message == "test error" =#
#=     reset() =#
#=  =#
#=  =#
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
#= @testset "size" begin =#
#=     testCellOne = cell_int(8) =#
#=     assert size(testCellOne) == 8 =#
#=  =#
#=  =#
#= @testset "spd" begin =#
#=     assert spd() == 86400.0 =#
#=  =#
#=  =#
#= @testset "sphcyl" begin =#
#=     a = array(sphcyl(1.4142, deg2rad(180.0), deg2rad(45.0))) =#
#=     b = [0.0, deg2rad(45.0), -sqrt(2)] =#
#=     testing.assert_almost_equal(a, b, decimal=4) =#
#=  =#
#=  =#
#= @testset "sphlat" begin =#
#=     result = array(sphlat(1.0, pi(), halfpi())) =#
#=     expected = array([0.0, halfpi(), -1.0]) =#
#=     npt.assert_array_almost_equal(result, expected) =#
#=  =#
#=  =#
#= @testset "sphrec" begin =#
#=     expected1 = array([0.0, 0.0, 0.0]) =#
#=     expected2 = array([1.0, 0.0, 0.0]) =#
#=     expected3 = array([0.0, 0.0, -1.0]) =#
#=     npt.assert_array_almost_equal(sphrec(0.0, 0.0, 0.0), expected1) =#
#=     npt.assert_array_almost_equal(sphrec(1.0, 90.0 * rpd(), 0.0), expected2) =#
#=     npt.assert_array_almost_equal(sphrec(1.0, 180.0 * rpd(), 0.0), expected3) =#
#=  =#
#=  =#
#= @testset "spk14a" begin =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0] =#
#=     cheby_coeffs14 = [150.0, 50.0, 1.0101, 1.0102, 1.0103, =#
#=                                    1.0201, 1.0202, 1.0203, =#
#=                                    1.0301, 1.0302, 1.0303, =#
#=                                    1.0401, 1.0402, 1.0403, =#
#=                                    1.0501, 1.0502, 1.0503, =#
#=                                    1.0601, 1.0602, 1.0603, 250.0, 50.0, =#
#=                                    2.0101, 2.0102, 2.0103, =#
#=                                    2.0201, 2.0202, 2.0203, =#
#=                                    2.0301, 2.0302, 2.0303, =#
#=                                    2.0401, 2.0402, 2.0403, =#
#=                                    2.0501, 2.0502, 2.0503, =#
#=                                    2.0601, 2.0602, 2.0603, 350.0, 50.0, =#
#=                                    3.0101, 3.0102, 3.0103, =#
#=                                    3.0201, 3.0202, 3.0203, =#
#=                                    3.0301, 3.0302, 3.0303, =#
#=                                    3.0401, 3.0402, 3.0403, =#
#=                                    3.0501, 3.0502, 3.0503, =#
#=                                    3.0601, 3.0602, 3.0603, 450.0, 50.0, =#
#=                                    4.0101, 4.0102, 4.0103, =#
#=                                    4.0201, 4.0202, 4.0203, =#
#=                                    4.0301, 4.0302, 4.0303, =#
#=                                    4.0401, 4.0402, 4.0403, =#
#=                                    4.0501, 4.0502, 4.0503, =#
#=                                    4.0601, 4.0602, 4.0603] =#
#=     spk14 = os.path.join(cwd, "test14.bsp") =#
#=     if exists(spk14): =#
#=         os.remove(spk14) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(spk14, 'Type 14 SPK internal file name.', 1024) =#
#=     init_size = os.path.getsize(spk14) =#
#=     spk14b(handle, "SAMPLE_SPK_TYPE_14_SEGMENT", 399, 0, "J2000", 100.0, 400.0, 2) =#
#=     spk14a(handle, 4, cheby_coeffs14, discrete_epochs) =#
#=     spk14e(handle) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(spk14) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(spk14): =#
#=         os.remove(spk14) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spk14bstress" begin =#
#=     for i in range(30): =#
#=         test_spk14a() =#
#=  =#
#=  =#
#= @testset "spk14b" begin =#
#=     # Same as test_spk14a =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0] =#
#=     cheby_coeffs14 = [150.0, 50.0, 1.0101, 1.0102, 1.0103, =#
#=                                    1.0201, 1.0202, 1.0203, =#
#=                                    1.0301, 1.0302, 1.0303, =#
#=                                    1.0401, 1.0402, 1.0403, =#
#=                                    1.0501, 1.0502, 1.0503, =#
#=                                    1.0601, 1.0602, 1.0603, 250.0, 50.0, =#
#=                                    2.0101, 2.0102, 2.0103, =#
#=                                    2.0201, 2.0202, 2.0203, =#
#=                                    2.0301, 2.0302, 2.0303, =#
#=                                    2.0401, 2.0402, 2.0403, =#
#=                                    2.0501, 2.0502, 2.0503, =#
#=                                    2.0601, 2.0602, 2.0603, 350.0, 50.0, =#
#=                                    3.0101, 3.0102, 3.0103, =#
#=                                    3.0201, 3.0202, 3.0203, =#
#=                                    3.0301, 3.0302, 3.0303, =#
#=                                    3.0401, 3.0402, 3.0403, =#
#=                                    3.0501, 3.0502, 3.0503, =#
#=                                    3.0601, 3.0602, 3.0603, 450.0, 50.0, =#
#=                                    4.0101, 4.0102, 4.0103, =#
#=                                    4.0201, 4.0202, 4.0203, =#
#=                                    4.0301, 4.0302, 4.0303, =#
#=                                    4.0401, 4.0402, 4.0403, =#
#=                                    4.0501, 4.0502, 4.0503, =#
#=                                    4.0601, 4.0602, 4.0603] =#
#=     spk14 = os.path.join(cwd, "test14.bsp") =#
#=     if exists(spk14): =#
#=         os.remove(spk14) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(spk14, 'Type 14 SPK internal file name.', 1024) =#
#=     init_size = os.path.getsize(spk14) =#
#=     spk14b(handle, "SAMPLE_SPK_TYPE_14_SEGMENT", 399, 0, "J2000", 100.0, 400.0, 2) =#
#=     spk14a(handle, 4, cheby_coeffs14, discrete_epochs) =#
#=     spk14e(handle) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(spk14) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(spk14): =#
#=         os.remove(spk14) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spk14e" begin =#
#=     # Same as test_spk14a =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0] =#
#=     cheby_coeffs14 = [150.0, 50.0, 1.0101, 1.0102, 1.0103, =#
#=                                    1.0201, 1.0202, 1.0203, =#
#=                                    1.0301, 1.0302, 1.0303, =#
#=                                    1.0401, 1.0402, 1.0403, =#
#=                                    1.0501, 1.0502, 1.0503, =#
#=                                    1.0601, 1.0602, 1.0603, 250.0, 50.0, =#
#=                                    2.0101, 2.0102, 2.0103, =#
#=                                    2.0201, 2.0202, 2.0203, =#
#=                                    2.0301, 2.0302, 2.0303, =#
#=                                    2.0401, 2.0402, 2.0403, =#
#=                                    2.0501, 2.0502, 2.0503, =#
#=                                    2.0601, 2.0602, 2.0603, 350.0, 50.0, =#
#=                                    3.0101, 3.0102, 3.0103, =#
#=                                    3.0201, 3.0202, 3.0203, =#
#=                                    3.0301, 3.0302, 3.0303, =#
#=                                    3.0401, 3.0402, 3.0403, =#
#=                                    3.0501, 3.0502, 3.0503, =#
#=                                    3.0601, 3.0602, 3.0603, 450.0, 50.0, =#
#=                                    4.0101, 4.0102, 4.0103, =#
#=                                    4.0201, 4.0202, 4.0203, =#
#=                                    4.0301, 4.0302, 4.0303, =#
#=                                    4.0401, 4.0402, 4.0403, =#
#=                                    4.0501, 4.0502, 4.0503, =#
#=                                    4.0601, 4.0602, 4.0603] =#
#=     spk14 = os.path.join(cwd, "test14.bsp") =#
#=     if exists(spk14): =#
#=         os.remove(spk14) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(spk14, 'Type 14 SPK internal file name.', 1024) =#
#=     init_size = os.path.getsize(spk14) =#
#=     spk14b(handle, "SAMPLE_SPK_TYPE_14_SEGMENT", 399, 0, "J2000", 100.0, 400.0, 2) =#
#=     spk14a(handle, 4, cheby_coeffs14, discrete_epochs) =#
#=     spk14e(handle) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(spk14) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(spk14): =#
#=         os.remove(spk14) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkacs" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2000 JAN 1 12:00:00 TDB") =#
#=     state, lt, dlt = spkacs(301, et, "J2000", "lt+s", 399) =#
#=     expected_state = [-2.91584616594972088933e+05,  -2.66693402359092258848e+05, =#
#=                       -7.60956475582799030235e+04,   6.43439144942984264652e-01, =#
#=                       -6.66065882529007446955e-01,  -3.01310065348405708985e-01] =#
#=     expected_lt = 1.3423106103603615 =#
#=     expected_dlt = 1.073169085424106e-07 =#
#=     npt.assert_almost_equal(expected_lt, lt) =#
#=     npt.assert_almost_equal(expected_dlt, dlt) =#
#=     npt.assert_array_almost_equal(state, expected_state) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkapo" begin =#
#=     kclear() =#
#=     MARS = 499 =#
#=     MOON = 301 =#
#=     EPOCH = 'Jan 1 2004 5:00 PM' =#
#=     REF = 'J2000' =#
#=     ABCORR = 'LT+S' =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et(EPOCH) =#
#=     state = spkssb(MOON, et, REF) =#
#=     pos_vec, ltime = spkapo(MARS, et, REF, state, ABCORR) =#
#=     expectedPos = [1.64534472413454592228e+08,   2.51219951337271928787e+07, =#
#=                    1.11454124484200235456e+07] =#
#=     npt.assert_array_almost_equal(pos_vec, expectedPos, decimal=5) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkapp" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('Jan 1 2004 5:00 PM') =#
#=     state = spkssb(301, et, 'J2000') =#
#=     state_vec, ltime = spkapp(499, et, 'J2000', state, 'LT+S') =#
#=     expected_vec = [1.64534472413454592228e+08,   2.51219951337271928787e+07, =#
#=                     1.11454124484200235456e+07,   1.23119770045260814584e+01, =#
#=                     1.98884005139675998919e+01,   9.40678685353050170193e+00] =#
#=     npt.assert_array_almost_equal(state_vec, expected_vec, decimal=6) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkaps" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2000 JAN 1 12:00:00 TDB") =#
#=     stobs = spkssb(399, et, 'J2000') =#
#=     state0 = array(spkssb(399, et - 1, 'J2000')) =#
#=     state2 = array(spkssb(399, et + 1, 'J2000')) =#
#=     # qderiv proc =#
#=     acc = vlcomg(3, 0.5 / 1.0, state0 + 3, -0.5 / 1.0, state2 + 3) =#
#=     acc = [acc[0], acc[1], acc[2], 0.0, 0.0, 0.0] =#
#=     state, lt, dlt = spkaps(301, et, "j2000", "lt+s", stobs, acc) =#
#=     kclear() =#
#=     expectedLt = 1.3423106103603615 =#
#=     expectedDlt = 1.073169085424106e-07 =#
#=     expectedState = [-2.91584616594972088933e+05,  -2.66693402359092258848e+05, =#
#=                      -7.60956475582799030235e+04,   1.59912685775666059129e+01, =#
#=                      -1.64471169612870582455e+01,  -3.80333369259831766129e+00] =#
#=     npt.assert_almost_equal(expectedLt, lt) =#
#=     npt.assert_almost_equal(expectedDlt, dlt) =#
#=     npt.assert_array_almost_equal(state, expectedState, decimal=5) =#
#=  =#
#=  =#
#= @testset "spkcls" begin =#
#=     # Same as test_spkw02 =#
#=     SPK2 = os.path.join(cwd, "test2.bsp") =#
#=     if exists(SPK2): =#
#=         os.remove(SPK2) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK2, 'Type 2 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK2) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     cheby_coeffs02 = [1.0101, 1.0102, 1.0103, 1.0201, 1.0202, 1.0203, 1.0301, 1.0302, =#
#=                       1.0303, 2.0101, 2.0102, 2.0103, 2.0201, 2.0202, 2.0203, 2.0301, =#
#=                       2.0302, 2.0303, 3.0101, 3.0102, 3.0103, 3.0201, 3.0202, 3.0203, =#
#=                       3.0301, 3.0302, 3.0303, 4.0101, 4.0102, 4.0103, 4.0201, 4.0202, =#
#=                       4.0203, 4.0301, 4.0302, 4.0303] =#
#=     segid = 'SPK type 2 test segment' =#
#=     intlen = discrete_epochs[1] - discrete_epochs[0] =#
#=     spkw02(handle, 3, 10, "J2000", discrete_epochs[0], =#
#=                  discrete_epochs[4], segid, intlen, 4, 2, cheby_coeffs02, discrete_epochs[0]) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK2) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK2): =#
#=         os.remove(SPK2) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkcov" begin =#
#=     kclear() =#
#=      =#
#=     ids = spkobj(CoreKernels.spk) =#
#=     tempObj = ids[0] =#
#=      =#
#=     #Checks for defaults =#
#=     cover=spkcov(CoreKernels.spk, tempObj) =#
#=     result = [x for x in cover] =#
#=     expected = [-94651137.81606464, 315662463.18395346] =#
#=     npt.assert_array_almost_equal(result, expected) =#
#=      =#
#=     #Checks for old way, where if cover is pre-set, it should remain set =#
#=     cover = cell_double(2000) =#
#=     scard(0, cover) =#
#=     spkcov(CoreKernels.spk, tempObj, cover) =#
#=     result = [x for x in cover] =#
#=     expected = [-94651137.81606464, 315662463.18395346] =#
#=     npt.assert_array_almost_equal(result, expected) =#
#=      =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkcpo" begin =#
#=     kclear() =#
#=     furnsh(ExtraKernels.earthStnSpk) =#
#=     furnsh(ExtraKernels.earthHighPerPck) =#
#=     furnsh(ExtraKernels.earthTopoTf ) =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2003 Oct 13 06:00:00") =#
#=     obspos = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439] =#
#=     state, lt = spkcpo("SUN", et, "DSS-14_TOPO", "OBSERVER", "CN+S", obspos, "EARTH", "ITRF93") =#
#=     kclear() =#
#=     expected_lt = 497.93167787805714 =#
#=     expected_state = [6.25122733012810498476e+07,   5.89674929926417097449e+07, =#
#=                      -1.22059095879866167903e+08,   2.47597313358008614159e+03, =#
#=                      -9.87026711803482794494e+03,  -3.49990805659246507275e+03] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(state, expected_state, decimal=6) =#
#=  =#
#=  =#
#= @testset "spkcpt" begin =#
#=     kclear() =#
#=     furnsh(ExtraKernels.earthStnSpk) =#
#=     furnsh(ExtraKernels.earthHighPerPck) =#
#=     furnsh(ExtraKernels.earthTopoTf ) =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     obstime = str2et("2003 Oct 13 06:00:00") =#
#=     trgpos = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439] =#
#=     state, lt = spkcpt(trgpos, "EARTH", "ITRF93", obstime, "ITRF93", "TARGET", "CN+S", "SUN") =#
#=     kclear() =#
#=     expected_lt = 497.9321928250503 =#
#=     expected_state = [-3.41263006568005401641e+06,  -1.47916331564148992300e+08, =#
#=                       1.98124035009580813348e+07,  -1.07582448117249587085e+04, =#
#=                       2.50028331500427839273e+02,   1.11355285621842696742e+01] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(state, expected_state, decimal=6) =#
#=  =#
#=  =#
#= @testset "spkcvo" begin =#
#=     kclear() =#
#=     furnsh(ExtraKernels.earthStnSpk) =#
#=     furnsh(ExtraKernels.earthHighPerPck) =#
#=     furnsh(ExtraKernels.earthTopoTf ) =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     obstime = str2et("2003 Oct 13 06:00:00") =#
#=     obstate = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439, -0.00000000000057086, 0.00000000000020549, =#
#=                -0.00000000000012171] =#
#=     state, lt = spkcvo("SUN", obstime, "DSS-14_TOPO", "OBSERVER", "CN+S", obstate, 0.0, "EARTH", "ITRF93") =#
#=     kclear() =#
#=     expected_lt = 497.93167787798325 =#
#=     expected_state = [6.25122733012975975871e+07,   5.89674929925705492496e+07, =#
#=                      -1.22059095879864960909e+08,   2.47597313358015026097e+03, =#
#=                      -9.87026711803497346409e+03,  -3.49990805659256830040e+03] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(state, expected_state, decimal=6) =#
#=  =#
#=  =#
#= @testset "spkcvt" begin =#
#=     kclear() =#
#=     furnsh(ExtraKernels.earthStnSpk) =#
#=     furnsh(ExtraKernels.earthHighPerPck) =#
#=     furnsh(ExtraKernels.earthTopoTf ) =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     obstime = str2et("2003 Oct 13 06:00:00") =#
#=     trgstate = [-2353.6213656676991, -4641.3414911499403, 3677.0523293197439, -0.00000000000057086, 0.00000000000020549, =#
#=                 -0.00000000000012171] =#
#=     state, lt = spkcvt(trgstate, 0.0, "EARTH", "ITRF93", obstime, "ITRF93", "TARGET", "CN+S", "SUN") =#
#=     kclear() =#
#=     expected_lt = 497.932192824968 =#
#=     expected_state = [-3.41263006574816117063e+06,  -1.47916331564124494791e+08, =#
#=                       1.98124035009435638785e+07,  -1.07582448117247804475e+04, =#
#=                       2.50028331500423831812e+02,   1.11355285621839659171e+01] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(state, expected_state, decimal=6) =#
#=  =#
#=  =#
#= @testset "spkez" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('July 4, 2003 11:00 AM PST') =#
#=     state, lt = spkez(499, et, 'J2000', 'LT+S', 399) =#
#=     expected_lt = 269.6898813661505 =#
#=     expected_state = [7.38222353105354905128e+07,  -2.71279189984722770751e+07, =#
#=                       -1.87413063014898747206e+07,  -6.80851334001380692484e+00, =#
#=                        7.51399612408221173609e+00,   3.00129849265935222391e+00] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(state, expected_state) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkezp" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('July 4, 2003 11:00 AM PST') =#
#=     pos, lt = spkezp(499, et, 'J2000', 'LT+S', 399) =#
#=     expected_lt = 269.6898813661505 =#
#=     expected_pos = [73822235.31053550541400909424, -27127918.99847228080034255981, =#
#=                     -18741306.30148987472057342529] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(pos, expected_pos) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkezr" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('July 4, 2003 11:00 AM PST') =#
#=     state, lt = spkezr("Mars", et, "J2000", "LT+S", "Earth") =#
#=     expected_lt = 269.6898813661505 =#
#=     expected_state = [7.38222353105354905128e+07,  -2.71279189984722770751e+07, =#
#=                       -1.87413063014898747206e+07,  -6.80851334001380692484e+00, =#
#=                        7.51399612408221173609e+00,   3.00129849265935222391e+00] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(state, expected_state) =#
#=     kclear() =#
#=  =#
#= @testset "spkezr_vectorized" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = full((100,), str2et('July 4, 2003 11:00 AM PST')) =#
#=     state, lt = spkezr("Mars", et, "J2000", "LT+S", "Earth") =#
#=     expected_lt = full((100,), 269.6898816177049) =#
#=     expected_state = full((100, 6), [73822235.33116072, -27127919.178592984, =#
#=                                         -18741306.284863796, =#
#=                                         -6.808513317178952, 7.513996167680786, =#
#=                                         3.001298515816776]) =#
#=     npt.assert_allclose(lt, expected_lt) =#
#=     npt.assert_allclose(state, expected_state) =#
#=     kclear() =#
#=  =#
#= @testset "spkgeo" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('July 4, 2003 11:00 AM PST') =#
#=     state, lt = spkgeo(499, et, 'J2000', 399) =#
#=     expected_lt = 269.70264751151603 =#
#=     expected_state = [7.38262164145559966564e+07,  -2.71280305524311661720e+07, =#
#=                       -1.87419738849752545357e+07,  -6.80950358877040429206e+00, =#
#=                        7.51381423681132254444e+00,   3.00129002640705921934e+00] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(state, expected_state) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkgps" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('July 4, 2003 11:00 AM PST') =#
#=     pos, lt = spkgps(499, et, 'J2000', 399) =#
#=     expected_lt = 269.70264751151603 =#
#=     expected_pos = [73826216.41455599665641784668, -27128030.55243116617202758789, =#
#=                     -18741973.88497525453567504883] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(pos, expected_pos) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spklef" begin =#
#=     kclear() =#
#=     handle = spklef(CoreKernels.spk) =#
#=     assert handle != -1 =#
#=     spkuef(handle) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkltc" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2000 JAN 1 12:00:00 TDB") =#
#=     stobs = spkssb(399, et, "j2000") =#
#=     state, lt, dlt = spkltc(301, et, "j2000", "lt", stobs) =#
#=     expectedOneWayLt = 1.342310610325 =#
#=     expectedLt = 1.07316909e-07 =#
#=     expectedState = [-2.91569268313527107239e+05,  -2.66709183005481958389e+05, =#
#=                      -7.60991494675353169441e+04,   6.43530600728670520994e-01, =#
#=                      -6.66081825882520739412e-01,  -3.01322833716675120286e-01] =#
#=     npt.assert_almost_equal(lt, expectedOneWayLt) =#
#=     npt.assert_almost_equal(dlt, expectedLt) =#
#=     npt.assert_array_almost_equal(state, expectedState, decimal=5) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkobj" begin =#
#=     # Same as test_spkcov =#
#=     kclear() =#
#=     cover = cell_double(2000) =#
#=     ids = spkobj(CoreKernels.spk) =#
#=     tempObj = ids[0] =#
#=     scard(0, cover) =#
#=     spkcov(CoreKernels.spk, tempObj, cover) =#
#=     result = [x for x in cover] =#
#=     expected = [-94651137.81606464, 315662463.18395346] =#
#=     npt.assert_array_almost_equal(result, expected) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkopa" begin =#
#=     SPKOPA = os.path.join(cwd, "testspkopa.bsp") =#
#=     if exists(SPKOPA): =#
#=         os.remove(SPKOPA) # pragma: no cover =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2002 APR 27 00:00:00.000 TDB") =#
#=     # load subset from kernels =#
#=     handle, descr, ident = spksfs(5, et, 41) =#
#=     body, center, frame, otype, first, last, begin, end = spkuds(descr) =#
#=     # create empty spk kernel =#
#=     handle_test = spkopn(SPKOPA, 'Test Kernel for spkopa unit test.', 4) =#
#=     # created empty spk kernel, write to it =#
#=     spksub(handle, descr, ident, first, last, handle_test) =#
#=     # close kernel =#
#=     spkcls(handle_test) =#
#=     # open the file to append to it =#
#=     handle_spkopa = spkopa(SPKOPA) =#
#=     et2 = str2et("2003 APR 27 00:00:00.000 TDB") =#
#=     handle, descr, ident = spksfs(5, et2, 41) =#
#=     body, center, frame, otype, first, last, begin, end = spkuds(descr) =#
#=     spksub(handle, descr, ident, first, last, handle_spkopa) =#
#=     spkcls(handle_spkopa) =#
#=     # clean up =#
#=     if exists(SPKOPA): =#
#=         os.remove(SPKOPA) # pragma: no cover =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkopn" begin =#
#=     # Same as test_spkw02 =#
#=     SPK2 = os.path.join(cwd, "test2.bsp") =#
#=     if exists(SPK2): =#
#=         os.remove(SPK2) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK2, 'Type 2 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK2) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     cheby_coeffs02 = [1.0101, 1.0102, 1.0103, 1.0201, 1.0202, 1.0203, 1.0301, 1.0302, =#
#=                       1.0303, 2.0101, 2.0102, 2.0103, 2.0201, 2.0202, 2.0203, 2.0301, =#
#=                       2.0302, 2.0303, 3.0101, 3.0102, 3.0103, 3.0201, 3.0202, 3.0203, =#
#=                       3.0301, 3.0302, 3.0303, 4.0101, 4.0102, 4.0103, 4.0201, 4.0202, =#
#=                       4.0203, 4.0301, 4.0302, 4.0303] =#
#=     segid = 'SPK type 2 test segment' =#
#=     intlen = discrete_epochs[1] - discrete_epochs[0] =#
#=     spkw02(handle, 3, 10, "J2000", discrete_epochs[0], =#
#=                  discrete_epochs[4], segid, intlen, 4, 2, cheby_coeffs02, discrete_epochs[0]) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK2) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK2): =#
#=         os.remove(SPK2) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkpds" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2002 APR 27 00:00:00.000 TDB") =#
#=     handle, descr, ident = spksfs(5, et, 41) =#
#=     body, center, frame, otype, first, last, begin, end  = spkuds(descr) =#
#=     outframe = frmnam(frame) =#
#=     spkpds_output = spkpds(body, center, outframe, otype, first, last) =#
#=     npt.assert_almost_equal(spkpds_output, descr) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkpos" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('July 4, 2003 11:00 AM PST') =#
#=     pos, lt = spkpos("Mars", et, "J2000", "LT+S", "Earth") =#
#=     expected_lt = 269.6898813661505 =#
#=     expected_pos = [73822235.31053550541400909424, -27127918.99847228080034255981, =#
#=                     -18741306.30148987472057342529] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(pos, expected_pos) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkpos_vectorized" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et(['July 4, 2003 11:00 AM PST', 'July 11, 2003 11:00 AM PST']) =#
#=     pos, lt = spkpos("Mars", et, "J2000", "LT+S", "Earth") =#
#=     expected_lt = [269.68988136615047324085,  251.44204326148698669385] =#
#=     expected_pos = [[73822235.31053550541400909424, -27127918.99847228080034255981, =#
#=                      -18741306.30148987472057342529], [69682765.52989411354064941406, =#
#=                      -23090281.18098583817481994629, -17127756.93968883529305458069]] =#
#=     npt.assert_almost_equal(lt, expected_lt) =#
#=     npt.assert_array_almost_equal(pos, expected_pos) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkpvn" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2002 APR 27 00:00:00.000 TDB") =#
#=     handle, descr, ident = spksfs(5, et, 41) =#
#=     refid, state, center = spkpvn(handle, descr, et) =#
#=     expected_state = [-2.70063336478468656540e+08,   6.69404818553274393082e+08, =#
#=                       2.93505043081457614899e+08,  -1.24191493217698472051e+01, =#
#=                      -3.70147572019018955558e+00,  -1.28422514561611489370e+00] =#
#=     npt.assert_array_almost_equal(state, expected_state) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spksfs" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     idcode = bodn2c("PLUTO BARYCENTER") =#
#=     et = str2et("2001 FEB 18 UTC") =#
#=     handle, descr, ident = spksfs(idcode, et, 41) =#
#=     assert ident == "DE-405" =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkssb" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     targ1 = 499 =#
#=     epoch = 'July 4, 2003 11:00 AM PST' =#
#=     frame = 'J2000' =#
#=     targ2 = 399 =#
#=     et = str2et(epoch) =#
#=     state1 = spkssb(targ1, et, frame) =#
#=     state2 = spkssb(targ2, et, frame) =#
#=     dist = vdist(state1[0:3], state2[0:3]) =#
#=     npt.assert_approx_equal(dist, 80854820., significant=7) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spksub" begin =#
#=     SPKSUB = os.path.join(cwd, "testspksub.bsp") =#
#=     if exists(SPKSUB): =#
#=         os.remove(SPKSUB) # pragma: no cover =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2002 APR 27 00:00:00.000 TDB") =#
#=     # load subset from kernels =#
#=     handle, descr, ident = spksfs(5, et, 41) =#
#=     body, center, frame, otype, first, last, begin, end = spkuds(descr) =#
#=     # create empty spk kernel =#
#=     handle_test = spkopn(SPKSUB, 'Test Kernel for spksub unit test.', 4) =#
#=     # created empty spk kernel, write to it =#
#=     spksub(handle, descr, ident, first, last, handle_test) =#
#=     # close kernel =#
#=     spkcls(handle_test) =#
#=     if exists(SPKSUB): =#
#=         os.remove(SPKSUB) # pragma: no cover =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkuds" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("2002 APR 27 00:00:00.000 TDB") =#
#=     handle, descr, ident = spksfs(5, et, 41) =#
#=     body, center, frame, otype, first, last, begin, end  = spkuds(descr) =#
#=     assert body == 5 =#
#=     assert begin == 54073 =#
#=     assert end == 57950 =#
#=     assert otype == 2 =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkuef" begin =#
#=     kclear() =#
#=     handle = spklef(CoreKernels.spk) =#
#=     assert handle != -1 =#
#=     spkuef(handle) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkw02" begin =#
#=     SPK2 = os.path.join(cwd, "test2.bsp") =#
#=     if exists(SPK2): =#
#=         os.remove(SPK2) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK2, 'Type 2 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK2) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     cheby_coeffs02 = [1.0101, 1.0102, 1.0103, 1.0201, 1.0202, 1.0203, 1.0301, 1.0302, =#
#=                       1.0303, 2.0101, 2.0102, 2.0103, 2.0201, 2.0202, 2.0203, 2.0301, =#
#=                       2.0302, 2.0303, 3.0101, 3.0102, 3.0103, 3.0201, 3.0202, 3.0203, =#
#=                       3.0301, 3.0302, 3.0303, 4.0101, 4.0102, 4.0103, 4.0201, 4.0202, =#
#=                       4.0203, 4.0301, 4.0302, 4.0303] =#
#=     segid = 'SPK type 2 test segment' =#
#=     intlen = discrete_epochs[1] - discrete_epochs[0] =#
#=     spkw02(handle, 3, 10, "J2000", discrete_epochs[0], =#
#=                  discrete_epochs[4], segid, intlen, 4, 2, cheby_coeffs02, discrete_epochs[0]) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK2) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK2): =#
#=         os.remove(SPK2) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw03" begin =#
#=     SPK3 = os.path.join(cwd, "test3.bsp") =#
#=     if exists(SPK3): =#
#=         os.remove(SPK3) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK3, 'Type 3 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK3) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     cheby_coeffs03 = [1.0101, 1.0102, 1.0103, 1.0201, 1.0202, 1.0203, 1.0301, 1.0302, 1.0303, =#
#=                       1.0401, 1.0402, 1.0403, 1.0501, 1.0502, 1.0503, 1.0601, 1.0602, 1.0603, =#
#=                       2.0101, 2.0102, 2.0103, 2.0201, 2.0202, 2.0203, 2.0301, 2.0302, 2.0303, =#
#=                       2.0401, 2.0402, 2.0403, 2.0501, 2.0502, 2.0503, 2.0601, 2.0602, 2.0603, =#
#=                       3.0101, 3.0102, 3.0103, 3.0201, 3.0202, 3.0203, 3.0301, 3.0302, 3.0303, =#
#=                       3.0401, 3.0402, 3.0403, 3.0501, 3.0502, 3.0503, 3.0601, 3.0602, 3.0603, =#
#=                       4.0101, 4.0102, 4.0103, 4.0201, 4.0202, 4.0203, 4.0301, 4.0302, 4.0303, =#
#=                       4.0401, 4.0402, 4.0403, 4.0501, 4.0502, 4.0503, 4.0601, 4.0602, 4.0603] =#
#=     segid = 'SPK type 3 test segment' =#
#=     intlen = discrete_epochs[1] - discrete_epochs[0] =#
#=     spkw03(handle, 3, 10, "J2000", discrete_epochs[0], =#
#=                  discrete_epochs[4], segid, intlen, 4, 2, cheby_coeffs03, discrete_epochs[0]) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK3) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK3): =#
#=         os.remove(SPK3) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw05" begin =#
#=     SPK5 = os.path.join(cwd, "test5.bsp") =#
#=     if exists(SPK5): =#
#=         os.remove(SPK5) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK5, 'Type 5 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK5) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     discrete_states = [ =#
#=         [101.0, 201.0, 301.0, 401.0, 501.0, 601.0], =#
#=         [102.0, 202.0, 302.0, 402.0, 502.0, 602.0], =#
#=         [103.0, 203.0, 303.0, 403.0, 503.0, 603.0], =#
#=         [104.0, 204.0, 304.0, 404.0, 504.0, 604.0], =#
#=         [105.0, 205.0, 305.0, 405.0, 505.0, 605.0], =#
#=         [106.0, 206.0, 306.0, 406.0, 506.0, 606.0], =#
#=         [107.0, 207.0, 307.0, 407.0, 507.0, 607.0], =#
#=         [108.0, 208.0, 308.0, 408.0, 508.0, 608.0], =#
#=         [109.0, 209.0, 309.0, 409.0, 509.0, 609.0] =#
#=     ] =#
#=     segid = 'SPK type 5 test segment' =#
#=     spkw05(handle, 3, 10, "J2000", discrete_epochs[0], discrete_epochs[-1], segid, =#
#=                  132712440023.310, 9, discrete_states, discrete_epochs) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK5) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK5): =#
#=         os.remove(SPK5) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw08" begin =#
#=     SPK8 = os.path.join(cwd, "test8.bsp") =#
#=     if exists(SPK8): =#
#=         os.remove(SPK8) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK8, 'Type 8 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK8) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     discrete_states = [ =#
#=         [101.0, 201.0, 301.0, 401.0, 501.0, 601.0], =#
#=         [102.0, 202.0, 302.0, 402.0, 502.0, 602.0], =#
#=         [103.0, 203.0, 303.0, 403.0, 503.0, 603.0], =#
#=         [104.0, 204.0, 304.0, 404.0, 504.0, 604.0], =#
#=         [105.0, 205.0, 305.0, 405.0, 505.0, 605.0], =#
#=         [106.0, 206.0, 306.0, 406.0, 506.0, 606.0], =#
#=         [107.0, 207.0, 307.0, 407.0, 507.0, 607.0], =#
#=         [108.0, 208.0, 308.0, 408.0, 508.0, 608.0], =#
#=         [109.0, 209.0, 309.0, 409.0, 509.0, 609.0] =#
#=     ] =#
#=     segid = 'SPK type 8 test segment' =#
#=     step = discrete_epochs[1] - discrete_epochs[0] =#
#=     spkw08(handle, 3, 10, "J2000", discrete_epochs[0], discrete_epochs[-1], segid, =#
#=                  3, 9, discrete_states, discrete_epochs[0], step) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK8) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK8): =#
#=         os.remove(SPK8) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw09" begin =#
#=     SPK9 = os.path.join(cwd, "test9.bsp") =#
#=     if exists(SPK9): =#
#=         os.remove(SPK9) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK9, 'Type 9 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK9) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     discrete_states = [ =#
#=         [101.0, 201.0, 301.0, 401.0, 501.0, 601.0], =#
#=         [102.0, 202.0, 302.0, 402.0, 502.0, 602.0], =#
#=         [103.0, 203.0, 303.0, 403.0, 503.0, 603.0], =#
#=         [104.0, 204.0, 304.0, 404.0, 504.0, 604.0], =#
#=         [105.0, 205.0, 305.0, 405.0, 505.0, 605.0], =#
#=         [106.0, 206.0, 306.0, 406.0, 506.0, 606.0], =#
#=         [107.0, 207.0, 307.0, 407.0, 507.0, 607.0], =#
#=         [108.0, 208.0, 308.0, 408.0, 508.0, 608.0], =#
#=         [109.0, 209.0, 309.0, 409.0, 509.0, 609.0] =#
#=     ] =#
#=     segid = 'SPK type 9 test segment' =#
#=     spkw09(handle, 3, 10, "J2000", discrete_epochs[0], discrete_epochs[-1], segid, =#
#=                  3, 9, discrete_states, discrete_epochs) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK9) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK9): =#
#=         os.remove(SPK9) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw10" begin =#
#=     SPK10 = os.path.join(cwd, "test10.bsp") =#
#=     kclear() =#
#=     tle = ['1 18123U 87 53  A 87324.61041692 -.00000023  00000-0 -75103-5 0 00675', =#
#=            '2 18123  98.8296 152.0074 0014950 168.7820 191.3688 14.12912554 21686', =#
#=            '1 18123U 87 53  A 87326.73487726  .00000045  00000-0  28709-4 0 00684', =#
#=            '2 18123  98.8335 154.1103 0015643 163.5445 196.6235 14.12912902 21988', =#
#=            '1 18123U 87 53  A 87331.40868801  .00000104  00000-0  60183-4 0 00690', =#
#=            '2 18123  98.8311 158.7160 0015481 149.9848 210.2220 14.12914624 22644', =#
#=            '1 18123U 87 53  A 87334.24129978  .00000086  00000-0  51111-4 0 00702', =#
#=            '2 18123  98.8296 161.5054 0015372 142.4159 217.8089 14.12914879 23045', =#
#=            '1 18123U 87 53  A 87336.93227900 -.00000107  00000-0 -52860-4 0 00713', =#
#=            '2 18123  98.8317 164.1627 0014570 135.9191 224.2321 14.12910572 23425', =#
#=            '1 18123U 87 53  A 87337.28635487  .00000173  00000-0  10226-3 0 00726', =#
#=            '2 18123  98.8284 164.5113 0015289 133.5979 226.6438 14.12916140 23475', =#
#=            '1 18123U 87 53  A 87339.05673569  .00000079  00000-0  47069-4 0 00738', =#
#=            '2 18123  98.8288 166.2585 0015281 127.9985 232.2567 14.12916010 24908', =#
#=            '1 18123U 87 53  A 87345.43010859  .00000022  00000-0  16481-4 0 00758', =#
#=            '2 18123  98.8241 172.5226 0015362 109.1515 251.1323 14.12915487 24626', =#
#=            '1 18123U 87 53  A 87349.04167543  .00000042  00000-0  27370-4 0 00764', =#
#=            '2 18123  98.8301 176.1010 0015565 100.0881 260.2047 14.12916361 25138'] =#
#=     epoch_x = [] =#
#=     elems_x = [] =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     for i in range(0, 18, 2): =#
#=         lines = [tle[i], tle[i + 1]] =#
#=         epoch, elems = getelm(1950, 75, lines) =#
#=         epoch_x.append(epoch) =#
#=         elems_x.extend(elems) =#
#=     first = epoch_x[0] - 0.5 * spd() =#
#=     last = epoch_x[-1] + 0.5 * spd() =#
#=     consts = [1.082616e-3, -2.538813e-6, -1.65597e-6, 7.43669161e-2, 120.0, 78.0, 6378.135, 1.0] =#
#=     if exists(SPK10): =#
#=         os.remove(SPK10) # pragma: no cover =#
#=     handle = spkopn(SPK10, 'Type 10 SPK internal file name.', 100) =#
#=     init_size = os.path.getsize(SPK10) =#
#=     spkw10(handle, -118123, 399, "J2000", first, last, "DMSP F8", consts, 9, elems_x, epoch_x) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK10) =#
#=     assert end_size != init_size =#
#=     kclear() =#
#=     if exists(SPK10): =#
#=         os.remove(SPK10) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw12" begin =#
#=     SPK12 = os.path.join(cwd, "test12.bsp") =#
#=     if exists(SPK12): =#
#=         os.remove(SPK12) # pragma: no cover =#
#=     kclear() =#
#=     handle = spkopn(SPK12, 'Type 12 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK12) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     discrete_states = [ =#
#=         [101.0, 201.0, 301.0, 401.0, 501.0, 601.0], =#
#=         [102.0, 202.0, 302.0, 402.0, 502.0, 602.0], =#
#=         [103.0, 203.0, 303.0, 403.0, 503.0, 603.0], =#
#=         [104.0, 204.0, 304.0, 404.0, 504.0, 604.0], =#
#=         [105.0, 205.0, 305.0, 405.0, 505.0, 605.0], =#
#=         [106.0, 206.0, 306.0, 406.0, 506.0, 606.0], =#
#=         [107.0, 207.0, 307.0, 407.0, 507.0, 607.0], =#
#=         [108.0, 208.0, 308.0, 408.0, 508.0, 608.0], =#
#=         [109.0, 209.0, 309.0, 409.0, 509.0, 609.0] =#
#=     ] =#
#=     segid = 'SPK type 12 test segment' =#
#=     step = discrete_epochs[1] - discrete_epochs[0] =#
#=     spkw12(handle, 3, 10, "J2000", discrete_epochs[0], discrete_epochs[-1], segid, =#
#=                  3, 9, discrete_states, discrete_epochs[0], step) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK12) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK12): =#
#=         os.remove(SPK12) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw13" begin =#
#=     SPK13 = os.path.join(cwd, "test13.bsp") =#
#=     if exists(SPK13): =#
#=         os.remove(SPK13) # pragma: no cover  =#
#=     kclear() =#
#=     handle = spkopn(SPK13, 'Type 13 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK13) =#
#=     discrete_epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     discrete_states = [ =#
#=         [101.0, 201.0, 301.0, 401.0, 501.0, 601.0], =#
#=         [102.0, 202.0, 302.0, 402.0, 502.0, 602.0], =#
#=         [103.0, 203.0, 303.0, 403.0, 503.0, 603.0], =#
#=         [104.0, 204.0, 304.0, 404.0, 504.0, 604.0], =#
#=         [105.0, 205.0, 305.0, 405.0, 505.0, 605.0], =#
#=         [106.0, 206.0, 306.0, 406.0, 506.0, 606.0], =#
#=         [107.0, 207.0, 307.0, 407.0, 507.0, 607.0], =#
#=         [108.0, 208.0, 308.0, 408.0, 508.0, 608.0], =#
#=         [109.0, 209.0, 309.0, 409.0, 509.0, 609.0] =#
#=     ] =#
#=     segid = 'SPK type 13 test segment' =#
#=     spkw13(handle, 3, 10, "J2000", discrete_epochs[0], discrete_epochs[-1], segid, =#
#=                  3, 9, discrete_states, discrete_epochs) =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK13) =#
#=     kclear() =#
#=     assert end_size != init_size =#
#=     if exists(SPK13): =#
#=         os.remove(SPK13) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw15" begin =#
#=     discrete_epochs = [100.0, 900.0] =#
#=     kclear() =#
#=     # =#
#=     SPK15 = os.path.join(cwd, "test15.bsp") =#
#=     if exists(SPK15): =#
#=         os.remove(SPK15)  # pragma: no cover =#
#=     # create the test kernel =#
#=     handle = spkopn(SPK15, 'Type 13 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK15) =#
#=     # load kernels =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('Dec 25, 2007') =#
#=     state, ltime = spkezr('Moon', et, 'J2000', 'NONE', 'EARTH') =#
#=     dim, mu = bodvrd('EARTH', 'GM', 1) =#
#=     elts = oscelt(state, et, mu[0]) =#
#=     # From these collect the eccentricity and semi-latus =#
#=     ecc = elts[1] =#
#=     p   = elts[0] * (1.0 + ecc) =#
#=     # Next get the trajectory pole vector and the periapsis vector. =#
#=     state = state[0:3] =#
#=     tp = ucrss(state, state+4) =#
#=     pa = vhat(state) =#
#=     # Enable both J2 corrections. =#
#=     j2flg = 0.0 =#
#=     # other constants, as I don't need real values =#
#=     pv = [1.0, 2.0, 3.0] =#
#=     gm = 398600.436 =#
#=     j2 = 1.0 =#
#=     radius = 6000.0 =#
#=     # now call spkw15 =#
#=     spkw15(handle, 3, 10, 'J2000', discrete_epochs[0], discrete_epochs[-1], "Test SPKW15", et, tp, pa, p, ecc, j2flg, pv, gm, j2, radius) =#
#=     # close the kernel =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK15) =#
#=     # cleanup =#
#=     assert end_size != init_size =#
#=     if exists(SPK15): =#
#=         os.remove(SPK15)  # pragma: no cover =#
#=     # =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkw17" begin =#
#=     discrete_epochs = [100.0, 900.0] =#
#=     kclear() =#
#=     # =#
#=     SPK17 = os.path.join(cwd, "test17.bsp") =#
#=     if exists(SPK17): =#
#=         os.remove(SPK17)  # pragma: no cover =#
#=     # create the test kernel =#
#=     handle = spkopn(SPK17, 'Type 17 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK17) =#
#=     # load kernels =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et('Dec 25, 2007') =#
#=     # make the eqel vector and the rapol and decpol floats =#
#=     p = 10000.0 =#
#=     gm = 398600.436 =#
#=     ecc = 0.1 =#
#=     a = p / (1.0 - ecc) =#
#=     n = sqrt(gm / a) / a =#
#=     argp   = 30. * rpd() =#
#=     node   = 15. * rpd() =#
#=     inc    = 10. * rpd() =#
#=     m0     = 45. * rpd() =#
#=     eqel   = [a, ecc * sin(argp + node), ecc * cos(argp + node), m0 + argp + node, =#
#=               tan(inc / 2.0) * sin(node), tan(inc / 2.0) * cos(node), 0.0, n, 0.0] =#
#=     rapol  = halfpi() * -1 =#
#=     decpol = halfpi() =#
#=     # now call spkw17 =#
#=     spkw17(handle, 3, 10, 'J2000', discrete_epochs[0], discrete_epochs[-1], "Test SPKW17", et, eqel, rapol, decpol) =#
#=     # close the kernel =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK17) =#
#=     # cleanup =#
#=     assert end_size != init_size =#
#=     if exists(SPK17): =#
#=         os.remove(SPK17)  # pragma: no cover =#
#=     # =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "spkw18" begin =#
#=     kclear() =#
#=     # =#
#=     SPK18 = os.path.join(cwd, "test18.bsp") =#
#=     if exists(SPK18): =#
#=         os.remove(SPK18)  # pragma: no cover =#
#=     # make a new kernel =#
#=     handle = spkopn(SPK18, 'Type 18 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK18) =#
#=     # test data =#
#=     body = 3 =#
#=     center = 10 =#
#=     ref =  "J2000" =#
#=     epochs = [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] =#
#=     states = [ =#
#=         [101., 201., 301., 401., 501., 601., 1., 1., 1., 1., 1., 1.], =#
#=         [102., 202., 302., 402., 502., 602., 1., 1., 1., 1., 1., 1.], =#
#=         [103., 203., 303., 403., 503., 603., 1., 1., 1., 1., 1., 1.], =#
#=         [104., 204., 304., 404., 504., 604., 1., 1., 1., 1., 1., 1.], =#
#=         [105., 205., 305., 405., 505., 605., 1., 1., 1., 1., 1., 1.], =#
#=         [106., 206., 306., 406., 506., 606., 1., 1., 1., 1., 1., 1.], =#
#=         [107., 207., 307., 407., 507., 607., 1., 1., 1., 1., 1., 1.], =#
#=         [108., 208., 308., 408., 508., 608., 1., 1., 1., 1., 1., 1.], =#
#=         [109., 209., 309., 409., 509., 609., 1., 1., 1., 1., 1., 1.], =#
#=     ] =#
#=     # test spkw18 with S18TP0 =#
#=     spkw18(handle, stypes.SpiceSPK18Subtype.S18TP0, body, center, ref, epochs[0], epochs[-1], "SPK type 18 test segment", 3, states, epochs) =#
#=     # close the kernel =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK18) =#
#=     assert end_size != init_size =#
#=     # test reading data =#
#=     handle = spklef(SPK18) =#
#=     state, lt = spkgeo(body, epochs[0], ref, center) =#
#=     npt.assert_array_equal(state, [101., 201., 301., 1., 1., 1., ]) =#
#=     state, lt = spkgeo(body, epochs[1], ref, center) =#
#=     npt.assert_array_equal(state, [102., 202., 302., 1., 1., 1., ]) =#
#=     spkcls(handle) =#
#=     kclear() =#
#=     # cleanup =#
#=     if exists(SPK18): =#
#=         os.remove(SPK18)  # pragma: no cover =#
#=  =#
#=  =#
#= @testset "spkw20" begin =#
#=     kclear() =#
#=     # =#
#=     SPK20 = os.path.join(cwd, "test20.bsp") =#
#=     if exists(SPK20): =#
#=         os.remove(SPK20)  # pragma: no cover =#
#=     # create the test kernel =#
#=     handle = spkopn(SPK20, 'Type 20 SPK internal file name.', 4) =#
#=     init_size = os.path.getsize(SPK20) =#
#=     # now call spkw20, giving fake data from f_spk20.c from tspice =#
#=     intlen = 5.0 =#
#=     n = 100 =#
#=     polydg = 1 =#
#=     cdata = arange(1.0, 198000.0) # =#
#=     dscale = 1.0 =#
#=     tscale = 1.0 =#
#=     initjd = 2451545.0 =#
#=     initfr = 0.25 =#
#=     first  = (initjd - j2000() + initfr) * spd() =#
#=     last   = ((initjd - j2000()) + initfr + n*intlen) * spd() =#
#=     spkw20(handle, 301, 3, "J2000", first, last, "Test SPKW20", intlen, n, polydg, cdata, dscale, tscale, initjd, initfr) =#
#=     # close the kernel =#
#=     spkcls(handle) =#
#=     end_size = os.path.getsize(SPK20) =#
#=     # cleanup =#
#=     assert end_size != init_size =#
#=     if exists(SPK20): =#
#=         os.remove(SPK20)  # pragma: no cover =#
#=     # =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "srfc2s" begin =#
#=     kclear() =#
#=     kernel = os.path.join(cwd, 'srfc2s_ex1.tm') =#
#=     if exists(kernel): =#
#=         os.remove(kernel) # pragma: no cover =#
#=     with open(kernel, 'w') as kernelFile: =#
#=         kernelFile.write('\\begindata\n') =#
#=         kernelFile.write("NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n") =#
#=         kernelFile.write("                       'MGS MOLA 128 pixel/deg',\n") =#
#=         kernelFile.write("                       'PHOBOS GASKELL Q512'     )\n") =#
#=         kernelFile.write("NAIF_SURFACE_CODE += (   1,   2,    1 )\n") =#
#=         kernelFile.write("NAIF_SURFACE_BODY += ( 499, 499,  401 )\n") =#
#=         kernelFile.write("\\begintext\n") =#
#=         kernelFile.close() =#
#=     furnsh(kernel) =#
#=     assert srfc2s(1, 499)   == "MGS MOLA  64 pixel/deg" =#
#=     assert srfc2s(1, 401) == "PHOBOS GASKELL Q512" =#
#=     assert srfc2s(2, 499)    == "MGS MOLA 128 pixel/deg" =#
#=     with pytest.raises(stypes.SpiceyError): =#
#=         srfc2s(1, -1) =#
#=     reset() =#
#=     kclear() =#
#=     if exists(kernel): =#
#=         os.remove(kernel)  # pragma: no cover =#
#=  =#
#=  =#
#= @testset "srfcss" begin =#
#=     kclear() =#
#=     kernel = os.path.join(cwd, 'srfcss_ex1.tm') =#
#=     if exists(kernel): =#
#=         os.remove(kernel) # pragma: no cover =#
#=     with open(kernel, 'w') as kernelFile: =#
#=         kernelFile.write('\\begindata\n') =#
#=         kernelFile.write("NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n") =#
#=         kernelFile.write("                       'MGS MOLA 128 pixel/deg',\n") =#
#=         kernelFile.write("                       'PHOBOS GASKELL Q512'     )\n") =#
#=         kernelFile.write("NAIF_SURFACE_CODE += (   1,   2,    1 )\n") =#
#=         kernelFile.write("NAIF_SURFACE_BODY += ( 499, 499,  401 )\n") =#
#=         kernelFile.write("\\begintext\n") =#
#=         kernelFile.close() =#
#=     furnsh(kernel) =#
#=     assert srfcss(1, "MARS")   == "MGS MOLA  64 pixel/deg" =#
#=     assert srfcss(1, "PHOBOS") == "PHOBOS GASKELL Q512" =#
#=     assert srfcss(2, "499")    == "MGS MOLA 128 pixel/deg" =#
#=     with pytest.raises(stypes.SpiceyError): =#
#=         srfcss(1, "ZZZ") =#
#=     reset() =#
#=     kclear() =#
#=     if exists(kernel): =#
#=         os.remove(kernel)  # pragma: no cover =#
#=  =#
#=  =#
#= @testset "srfnrm" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.pck) =#
#=     furnsh(ExtraKernels.phobosDsk) =#
#=     srfpts = latsrf("DSK/UNPRIORITIZED", "phobos", 0.0, "iau_phobos", =#
#=                           [[0.0, 45.0], [60.0, 45.0]]) =#
#=     normals = srfnrm("DSK/UNPRIORITIZED", "phobos", 0.0, "iau_phobos", =#
#=                            srfpts) =#
#=     srf_rad = array([recrad(x) for x in srfpts]) =#
#=     nrm_rad = array([recrad(x) for x in normals]) =#
#=     assert any(not_equal(srf_rad, nrm_rad)) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "srfrec" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     x = srfrec(399, 100.0 * rpd(), 35.0 * rpd()) =#
#=     expected = [-906.24919474, 5139.59458217, 3654.29989637] =#
#=     npt.assert_array_almost_equal(x, expected) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "srfs2c" begin =#
#=     kclear() =#
#=     kernel = os.path.join(cwd, 'srfs2c_ex1.tm') =#
#=     if exists(kernel): =#
#=         os.remove(kernel) # pragma: no cover =#
#=     with open(kernel, 'w') as kernelFile: =#
#=         kernelFile.write('\\begindata\n') =#
#=         kernelFile.write("NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n") =#
#=         kernelFile.write("                       'MGS MOLA 128 pixel/deg',\n") =#
#=         kernelFile.write("                       'PHOBOS GASKELL Q512'     )\n") =#
#=         kernelFile.write("NAIF_SURFACE_CODE += (   1,   2,    1 )\n") =#
#=         kernelFile.write("NAIF_SURFACE_BODY += ( 499, 499,  401 )\n") =#
#=         kernelFile.write("\\begintext\n") =#
#=         kernelFile.close() =#
#=     furnsh(kernel) =#
#=     assert srfs2c("MGS MOLA  64 pixel/deg", "MARS") == 1 =#
#=     assert srfs2c("PHOBOS GASKELL Q512", "PHOBOS")  == 1 =#
#=     assert srfs2c("MGS MOLA 128 pixel/deg", "MARS") == 2 =#
#=     assert srfs2c("MGS MOLA  64 pixel/deg", "499")  == 1 =#
#=     assert srfs2c("1", "PHOBOS") == 1 =#
#=     assert srfs2c("2", "499") == 2 =#
#=     with pytest.raises(stypes.SpiceyError): =#
#=         srfs2c("ZZZ", "MARS") =#
#=     reset() =#
#=     kclear() =#
#=     if exists(kernel): =#
#=         os.remove(kernel)  # pragma: no cover =#
#=  =#
#=  =#
#= @testset "srfscc" begin =#
#=     kclear() =#
#=     kernel = os.path.join(cwd, 'srfscc_ex1.tm') =#
#=     if exists(kernel): =#
#=         os.remove(kernel) # pragma: no cover =#
#=     with open(kernel, 'w') as kernelFile: =#
#=         kernelFile.write('\\begindata\n') =#
#=         kernelFile.write("NAIF_SURFACE_NAME += ( 'MGS MOLA  64 pixel/deg',\n") =#
#=         kernelFile.write("                       'MGS MOLA 128 pixel/deg',\n") =#
#=         kernelFile.write("                       'PHOBOS GASKELL Q512'     )\n") =#
#=         kernelFile.write("NAIF_SURFACE_CODE += (   1,   2,    1 )\n") =#
#=         kernelFile.write("NAIF_SURFACE_BODY += ( 499, 499,  401 )\n") =#
#=         kernelFile.write("\\begintext\n") =#
#=         kernelFile.close() =#
#=     furnsh(kernel) =#
#=     assert srfscc("MGS MOLA  64 pixel/deg", 499) == 1 =#
#=     assert srfscc("PHOBOS GASKELL Q512", 401)  == 1 =#
#=     assert srfscc("MGS MOLA 128 pixel/deg", 499) == 2 =#
#=     assert srfscc("1", 401) == 1 =#
#=     assert srfscc("2", 499) == 2 =#
#=     with pytest.raises(stypes.SpiceyError): =#
#=         srfscc("ZZZ", 499) =#
#=     reset() =#
#=     kclear() =#
#=     if exists(kernel): =#
#=         os.remove(kernel)  # pragma: no cover =#
#=  =#
#=  =#
#= @testset "srfxpt" begin =#
#=     kclear() =#
#=     # load kernels =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     furnsh(CassiniKernels.cassSclk) =#
#=     furnsh(CassiniKernels.cassFk) =#
#=     furnsh(CassiniKernels.cassPck) =#
#=     furnsh(CassiniKernels.cassIk) =#
#=     furnsh(CassiniKernels.cassSclk) =#
#=     furnsh(CassiniKernels.satSpk) =#
#=     furnsh(CassiniKernels.cassTourSpk) =#
#=     furnsh(CassiniKernels.cassCk) =#
#=     # start test =#
#=     et = str2et("2013 FEB 25 11:50:00 UTC") =#
#=     camid = bodn2c("CASSINI_ISS_NAC") =#
#=     shape, frame, bsight, n, bounds = getfov(camid, 4) =#
#=     # run srfxpt on boresight vector =#
#=     spoint, dist, trgepc, obspos = srfxpt("Ellipsoid", 'Enceladus', et, "LT+S", "CASSINI", frame, bsight) =#
#=     npt.assert_almost_equal(dist, 683459.6415073496) =#
#=     npt.assert_almost_equal(trgepc, 415065064.9055491) =#
#=     expected_spoint = [-143.56046006834264971985,  202.9004595420923067195, =#
#=                        -27.99454299292458969717] =#
#=     expected_obspos = [329627.25001832831185311079,  557847.97086489037610590458, =#
#=                        -217744.02422016291529871523] =#
#=     npt.assert_array_almost_equal(spoint, expected_spoint) =#
#=     npt.assert_array_almost_equal(obspos, expected_obspos) =#
#=     # Iterable ET argument:  et-10, et, et+10 =#
#=     ets = [et - 10.0, et, et + 10.0] =#
#=     spoints, dists, trgepcs, obsposs = srfxpt("Ellipsoid", 'Enceladus', ets, "LT+S", "CASSINI", frame, bsight) =#
#=     assert 0. == vnorm(vsub(spoints[1], spoint)) =#
#=     assert 0. == (dists[1] - dist) =#
#=     assert 0. == (trgepcs[1] - trgepc) =#
#=     assert 0. == vnorm(vsub(obsposs[1], obspos)) =#
#=     # Cleanup =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "ssize" begin =#
#=     cell = cell_double(10) =#
#=     assert cell.size == 10 =#
#=     ssize(5, cell) =#
#=     assert cell.size == 5 =#
#=  =#
#=  =#
#= @testset "stelab" begin =#
#=     IDOBS = 399 =#
#=     IDTARG = 301 =#
#=     UTC = 'July 4 2004' =#
#=     FRAME = 'J2000' =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et(UTC) =#
#=     sobs = spkssb(IDOBS, et, FRAME) =#
#=     starg, ltime = spkapp(IDTARG, et, FRAME, sobs, 'LT') =#
#=     expected_starg = [2.01738718005936592817e+05,  -2.60893145259797573090e+05, =#
#=                       -1.47722589585214853287e+05,   9.24727104822839152121e-01, =#
#=                        5.32379608845730878386e-01,   2.17669748758417824774e-01] =#
#=     npt.assert_array_almost_equal(starg, expected_starg) =#
#=     cortarg = stelab(starg[0:3], starg[3:6]) =#
#=     expected_cortarg = [201739.80378842627396807075, -260892.46619604207808151841, -147722.30606629714020527899] =#
#=     npt.assert_array_almost_equal(expected_cortarg, cortarg) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "stpool" begin =#
#=     kclear() =#
#=     kernel = os.path.join(cwd, 'stpool_t.ker') =#
#=     if exists(kernel): =#
#=         os.remove(kernel) # pragma: no cover =#
#=     with open(kernel, 'w') as kernelFile: =#
#=         kernelFile.write('\\begindata\n') =#
#=         kernelFile.write("SPK_FILES = ( 'this_is_the_full_path_specification_*',\n") =#
#=         kernelFile.write("              'of_a_file_with_a_long_name',\n") =#
#=         kernelFile.write("              'this_is_the_full_path_specification_*',\n") =#
#=         kernelFile.write("              'of_a_second_file_name' )\n") =#
#=         kernelFile.close() =#
#=     furnsh(kernel) =#
#=     string, n = stpool("SPK_FILES", 0, "*") =#
#=     assert n == 62 =#
#=     assert string == "this_is_the_full_path_specification_of_a_file_with_a_long_name" =#
#=     string, n = stpool("SPK_FILES", 1, "*") =#
#=     assert n == 57 =#
#=     assert string == "this_is_the_full_path_specification_of_a_second_file_name" =#
#=     kclear() =#
#=     if exists(kernel): =#
#=         os.remove(kernel) # pragma: no cover =#
#=  =#
#=  =#
#= @testset "str2et" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     date = 'Thu Mar 20 12:53:29 PST 1997' =#
#=     et = str2et(date) =#
#=     npt.assert_almost_equal(et, -87836728.81438904) =#
#=     kclear() =#
#=      =#
#= @testset "datetime2et" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     date = datetime(1997,3,20,12,53,29) =#
#=     et = datetime2et(date) =#
#=     npt.assert_almost_equal(et, -87865528.8143913) =#
#=      =#
#=     expecteds=[-87865528.8143913,-792086354.8170365,-790847954.8166842] =#
#=     dates = [datetime(1997,3,20,12,53,29), =#
#=              datetime(1974,11,25,20,0,0), =#
#=              datetime(1974,12,10,4,0,0)] =#
#=               =#
#=     results = datetime2et(dates) =#
#=     for expected, result in zip(expecteds, results): =#
#=         npt.assert_almost_equal(result, expected) =#
#=     kclear() =#
#=  =#
#=  =#
    @testset "subpnt" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk))
            et = str2et("2008 aug 11 00:00:00")
            re, _, rp = bodvrd("MARS", "RADII", 3)
            f = (re - rp) / re
            methods = ["Intercept:  ellipsoid", "Near point: ellipsoid"]
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
                spoint, trgepc, srfvec = subpnt(method, "Mars", et, "IAU_MARS", "earth", abcorr="LT+S")
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
#= @testset "subpt" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     et = str2et("JAN 1, 2006") =#
#=     point1, alt1 = array(subpt("near point", "earth", et, "lt+s", "moon")) =#
#=     point2, alt2 = array(subpt("intercept", "earth", et, "lt+s", "moon")) =#
#=     dist = linalg.norm(subtract(point1, point2)) =#
#=     sep = vsep(point1, point2) * dpr() =#
#=     npt.assert_almost_equal(dist, 16.705476097706171) =#
#=     npt.assert_almost_equal(sep, 0.15016657506598063) =#
#=     # Iterable ET argument to subpt() =#
#=     points, alts = subpt("near point", "earth", [et-20., et, et+20.], "lt+s", "moon") =#
#=     assert 0. == vnorm(vsub(points[1], point1)) =#
#=     assert 0. == (alts[1] - alt1) =#
#=     # Cleanup =#
#=     kclear() =#
#=  =#
#=  =#
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
                spoint, trgepc, srfvec = subslr(method, "Mars", et, "IAU_MARS", "Earth", abcorr="LT+S")
                spglon, spglat, spgalt = recpgr("mars", spoint, re, f)

                @test spgalt ≈ expected[1] atol=sqrt(eps())
                @test rad2deg(spglon) ≈ expected[2]
                @test rad2deg(spglat) ≈ expected[3]
                spcrad, spclon, spclat = reclat(spoint)
                @test rad2deg(spclon) ≈ expected[4]
                @test rad2deg(spclat) ≈ expected[5]
                sunpos, sunlt = spkpos("sun", trgepc, "iau_mars", "mars", abcorr="LT+S")
                supgln, supglt, supgal = recpgr("mars", sunpos, re, f)
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
#= @testset "subsol" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     point = subsol('near point', 'earth', 0.0, 'lt+s', 'mars') =#
#=     npt.assert_array_almost_equal(point, [5850.44947427, 509.68837118, -2480.24722673], decimal=4) =#
#=     intercept = subsol('intercept', 'earth', 0.0, 'lt+s', 'mars') =#
#=     npt.assert_array_almost_equal(intercept, [5844.4362338, 509.16450054, -2494.39569089], decimal=4) =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "sumad" begin =#
#=     assert sumad([1.0, 2.0, 3.0]) == 6.0 =#
#=  =#
#=  =#
#= @testset "sumai" begin =#
#=     assert sumai([1, 2, 3]) == 6 =#
#=  =#
#=  =#
#= @testset "surfnm" begin =#
#=     point = [0.0, 0.0, 3.0] =#
#=     npt.assert_array_almost_equal(surfnm(1.0, 2.0, 3.0, point), [0.0, 0.0, 1.0]) =#
#=  =#
#=  =#
    @testset "surfpt" begin
        position = [2.0, 0.0, 0.0]
        u = [-1.0, 0.0, 0.0]
        point = surfpt(position, u, 1.0, 2.0, 3.0)
        @test point ≈ [1.0, 0.0, 0.0]
    end


#= @testset "surfpv" begin =#
#=     stvrtx = [2.0, 0.0, 0.0, 0.0, 0.0, 3.0] =#
#=     stdir = [-1.0, 0.0, 0.0, 0.0, 0.0, 4.0] =#
#=     stx = surfpv(stvrtx, stdir, 1.0, 2.0, 3.0) =#
#=     expected = [1.0, 0.0, 0.0, 0.0, 0.0, 7.0] =#
#=     npt.assert_array_almost_equal(expected, stx) =#
#=  =#
#=  =#
#= @testset "swpool" begin =#
#=     kclear() =#
#=     # add TEST_VAR_SWPOOL =#
#=     pdpool("TEST_VAR_SWPOOL", [-666.0]) =#
#=     # establish check for TEST_VAR_SWPOOL =#
#=     swpool("TEST_SWPOOL", 1, 16, ["TEST_VAR_SWPOOL"]) =#
#=     # update TEST_VAR_SWPOOL =#
#=     pdpool("TEST_VAR_SWPOOL", [555.0]) =#
#=     # check for updated variable =#
#=     updated = cvpool("TEST_SWPOOL") =#
#=     value = gdpool("TEST_VAR_SWPOOL", 0, 1) =#
#=     assert len(value) == 1 =#
#=     assert value[0] == 555.0 =#
#=     clpool() =#
#=     kclear() =#
#=     assert updated is True =#
#=  =#
#=  =#
#= @testset "sxform" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     lon = 118.25 * rpd() =#
#=     lat = 34.05 * rpd() =#
#=     alt = 0.0 =#
#=     utc = 'January 1, 1990' =#
#=     et = str2et(utc) =#
#=     len, abc = bodvrd('EARTH', 'RADII', 3) =#
#=     equatr = abc[0] =#
#=     polar = abc[2] =#
#=     f = (equatr - polar) / equatr =#
#=     estate = georec(lon, lat, alt, equatr, f) =#
#=     estate = append(estate, [0.0, 0.0, 0.0]) =#
#=     xform = array(sxform('IAU_EARTH', 'J2000', et)) =#
#=     kclear() =#
#=     jstate = dot(xform, estate) =#
#=     expected = array([-4131.45969, -3308.36805, 3547.02462, 0.241249619, -0.301019201, 0.000234215666]) =#
#=     npt.assert_array_almost_equal(jstate, expected, decimal=4) =#
#=  =#
#=  =#
#= @testset "sxform_vectorized" begin =#
#=     kclear() =#
#=     furnsh(CoreKernels.testMetaKernel) =#
#=     utc1 = 'January 1, 1990' =#
#=     utc2 = 'January 1, 2010' =#
#=     et1 = str2et(utc1) =#
#=     et2 = str2et(utc2) =#
#=     step = (et2 - et1) / 240.0 =#
#=     et = arange(240) * step + et1 =#
#=     xform = sxform('IAU_EARTH', 'J2000', et) =#
#=     assert len(xform) == 240 =#
#=     kclear() =#
#=  =#
#=  =#
#= @testset "szpool" begin =#
#=     assert szpool("MAXVAR") == 26003 =#
#=     assert szpool("MAXLEN") == 32 =#
#=     assert szpool("MAXVAL") == 400000 =#
#=     assert szpool("MXNOTE") == 130015 =#
#=     assert szpool("MAXAGT") == 1000 =#
#=     assert szpool("MAXCHR") == 80 =#
#=     assert szpool("MAXLIN") == 15000 =#
#=  =#
end

