using LinearAlgebra: I

@testset "P" begin
    @testset "pckcov" begin
        try
            ids = SpiceIntCell(1000)
            cover = SpiceDoubleCell(2000)
            pckfrm!(ids, path(EXTRA, :earth_high_per_pck))
            scard!(cover, 0)
            pckcov!(cover, path(EXTRA, :earth_high_per_pck), ids[1])
            expected = [94305664.18380372, 757080064.1838132]
            @test cover ≈ expected
        finally
            kclear()
        end
    end
    @testset "pckfrm" begin
        try
            ids = SpiceIntCell(1000)
            pckfrm!(ids, path(EXTRA, :earth_high_per_pck))
            @test ids[1] == 3000
        finally
            kclear()
        end
    end
    @testset "pcklof" begin
        try
            handle = pcklof(path(EXTRA, :earth_high_per_pck))
            @test handle isa Number
            @test handle != -1
            pckuof(handle)
        finally
            kclear()
        end
        @test_throws SpiceError pcklof("test")
    end
    @testset "pgrrec" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("MARS", "RADII", 3)
            re = radii[1]
            rp = radii[3]
            f = (re - rp) / re
            rectan = pgrrec("Mars", deg2rad(90.0), deg2rad(45), 300, re, f)
            expected = [1.604650025e-13, -2.620678915e+3, 2.592408909e+3]
            @test rectan ≈ expected
            @test_throws SpiceError pgrrec("norbert", deg2rad(90.0), deg2rad(45), 300, re, f)
            @test_throws SpiceError pgrrec("", deg2rad(90.0), deg2rad(45), 300, re, f)
            @test_throws SpiceError pgrrec("Mars", deg2rad(90.0), deg2rad(45), 300, -re, f)
            @test_throws SpiceError pgrrec("Mars", deg2rad(90.0), deg2rad(45), 300, re, f+1)
        finally
            kclear()
        end
    end


# def test_phaseq():
#     relate = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
#     expected = {"=": [0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.575988450,
#                       0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.575988450],
#                 "<": [0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.468279091],
#                 ">": [0.940714974, 0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.575988450],
#                 "LOCMIN": [0.086121423, 0.086121423, 0.079899769, 0.079899769],
#                 "ABSMIN": [0.079899769, 0.079899769],
#                 "LOCMAX": [3.055062862, 3.055062862, 3.074603891, 3.074603891],
#                 "ABSMAX": [3.074603891, 3.074603891]
#     }
#     spice.kclear()
#     spice.furnsh(CoreKernels.testMetaKernel)
#     et0 = spice.str2et('2006 DEC 01')
#     et1 = spice.str2et('2007 JAN 31')
#     cnfine = spice.stypes.SPICEDOUBLE_CELL(2)
#     spice.wninsd(et0, et1, cnfine)
#     result = spice.stypes.SPICEDOUBLE_CELL(10000)
#     for relation in relate:
#         spice.gfpa("Moon", "Sun", "LT+S", "Earth", relation, 0.57598845,
#                    0.0, spice.spd(), 5000, cnfine, result)
#         count = spice.wncard(result)
#         if count > 0:
#             tempResults = []
#             for i in range(0, count):
#                 start, stop = spice.wnfetd(result, i)
#                 startPhase = spice.phaseq(start, "moon", "sun", "earth", "lt+s")
#                 stopPhase = spice.phaseq(stop, "moon", "sun", "earth", "lt+s")
#                 tempResults.append(startPhase)
#                 tempResults.append(stopPhase)
#             npt.assert_array_almost_equal(tempResults, expected.get(relation))
#     spice.kclear()


# def test_pi():
#     assert spice.pi() == np.pi


# def test_pipool():
#     spice.kclear()
#     data = np.arange(0, 10)
#     spice.pipool('pipool_array', data)
#     ivals = spice.gipool('pipool_array', 0, 50)
#     npt.assert_array_almost_equal(data, ivals)
#     spice.kclear()


# def test_pjelpl():
#     center = [1.0, 1.0, 1.0]
#     vec1 = [2.0, 0.0, 0.0]
#     vec2 = [0.0, 1.0, 1.0]
#     normal = [0.0, 0.0, 1.0]
#     plane = spice.nvc2pl(normal, 0.0)
#     elin = spice.cgv2el(center, vec1, vec2)
#     ellipse = spice.pjelpl(elin, plane)
#     expectedSmajor = [2.0, 0.0, 0.0]
#     expectedSminor = [0.0, 1.0, 0.0]
#     expectedCenter = [1.0, 1.0, 0.0]
#     npt.assert_array_almost_equal(expectedCenter, ellipse.center)
#     npt.assert_array_almost_equal(expectedSmajor, ellipse.semi_major)
#     npt.assert_array_almost_equal(expectedSminor, ellipse.semi_minor)


# def test_pl2nvc():
#     normal = [-1.0, 5.0, -3.5]
#     point = [9.0, -0.65, -12.0]
#     plane = spice.nvp2pl(normal, point)
#     normal, constant = spice.pl2nvc(plane)
#     expectedNormal = [-0.16169042, 0.80845208, -0.56591646]
#     npt.assert_almost_equal(constant, 4.8102899, decimal=6)
#     npt.assert_array_almost_equal(expectedNormal, normal, decimal=6)


# def test_pl2nvp():
#     plane_norm = [2.44, -5.0 / 3.0, 11.0 / 9.0]
#     const = 3.141592654
#     plane = spice.nvc2pl(plane_norm, const)
#     norm_vec, point = spice.pl2nvp(plane)
#     expectedPoint = [0.74966576, -0.51206678, 0.37551564]
#     npt.assert_array_almost_equal(expectedPoint, point)


# def test_pl2psv():
#     normal = [-1.0, 5.0, -3.5]
#     point = [9.0, -0.65, -12.0]
#     plane = spice.nvp2pl(normal, point)
#     point, span1, span2 = spice.pl2psv(plane)
#     npt.assert_almost_equal(spice.vdot(point, span1), 0)
#     npt.assert_almost_equal(spice.vdot(point, span2), 0)
#     npt.assert_almost_equal(spice.vdot(span1, span2), 0)


# def test_pltar():
#     vrtces = [[0.0, 0.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
#     plates = [[1, 4, 3], [1, 2, 4], [1, 3, 2], [2, 3, 4]]
#     assert spice.pltar(vrtces, plates) == pytest.approx(2.3660254037844)


# def test_pltexp():
#     iverts = [[np.sqrt(3.0) / 2.0, -0.5, 7.0], [0.0, 1.0, 7.0], [-np.sqrt(3.0) / 2.0, -0.5, 7.0]]
#     overts = spice.pltexp(iverts, 1.0)
#     expected = [[1.732050807569, -1.0, 7.0], [0.0, 2.0, 7.0], [-1.732050807569, -1.0, 7.0]]
#     npt.assert_array_almost_equal(expected, overts)


# def test_pltnp():
#     point = [2.0, 2.0, 2.0]
#     v1 = [1.0, 0.0, 0.0]
#     v2 = [0.0, 1.0, 0.0]
#     v3 = [0.0, 0.0, 1.0]
#     near, distance = spice.pltnp(point, v1, v2, v3)
#     npt.assert_array_almost_equal([1.0/3.0, 1.0/3.0, 1.0/3.0], near)
#     assert distance == pytest.approx(2.8867513)


# def test_pltnrm():
#     v1 = [np.sqrt(3.0)/2.0, -0.5, 0.0]
#     v2 = [0.0, 1.0, 0.0]
#     v3 = [-np.sqrt(3.0)/2.0, -0.5, 0.0]
#     npt.assert_array_almost_equal([0.0, 0.0, 2.59807621135], spice.pltnrm(v1, v2, v3))


# def test_pltvol():
#     vrtces = [[0.0, 0.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
#     plates = [[1, 4, 3], [1, 2, 4], [1, 3, 2], [2, 3, 4]]
#     assert spice.pltvol(vrtces, plates) == pytest.approx(1.0/6.0)


# def test_polyds():
#     result = spice.polyds([1., 3., 0.5, 1., 0.5, -1., 1.], 6, 3, 1)
#     npt.assert_array_almost_equal([6.0, 10.0, 23.0, 78.0], result)


# def test_pos():
#     string = "AN ANT AND AN ELEPHANT        "
#     assert spice.pos(string, "AN", 0) == 0
#     assert spice.pos(string, "AN", 2) == 3
#     assert spice.pos(string, "AN", 5) == 7
#     assert spice.pos(string, "AN", 9) == 11
#     assert spice.pos(string, "AN", 13) == 19
#     assert spice.pos(string, "AN", 21) == -1
#     assert spice.pos(string, "AN", -6) == 0
#     assert spice.pos(string, "AN", -1) == 0
#     assert spice.pos(string, "AN", 30) == -1
#     assert spice.pos(string, "AN", 43) == -1
#     assert spice.pos(string, "AN", 0) == 0
#     assert spice.pos(string, " AN", 0) == 2
#     assert spice.pos(string, " AN ", 0) == 10
#     assert spice.pos(string, " AN  ", 0) == -1


# def test_posr():
#     string = "AN ANT AND AN ELEPHANT        "
#     assert spice.posr(string, "AN", 29) == 19
#     assert spice.posr(string, "AN", 18) == 11
#     assert spice.posr(string, "AN", 10) == 7
#     assert spice.posr(string, "AN", 6) == 3
#     assert spice.posr(string, "AN", 2) == 0
#     assert spice.posr(string, "AN", -6) == -1
#     assert spice.posr(string, "AN", -1) == -1
#     assert spice.posr(string, "AN", 30) == 19
#     assert spice.posr(string, "AN", 43) == 19
#     assert spice.posr(string, " AN", 29) == 10
#     assert spice.posr(string, " AN ", 29) == 10
#     assert spice.posr(string, " AN ", 9) == -1
#     assert spice.posr(string, " AN  ", 29) == -1


# def test_prop2b():
#     mu = 398600.45
#     r = 1.0e8
#     speed = np.sqrt(mu / r)
#     t = spice.pi() * (r / speed)
#     pvinit = np.array([0.0, r / np.sqrt(2.0), r / np.sqrt(2.0), 0.0, -speed / np.sqrt(2.0), speed / np.sqrt(2.0)])
#     state = np.array(spice.prop2b(mu, pvinit, t))
#     npt.assert_array_almost_equal(state, -1.0 * pvinit, decimal=6)


# def test_prsdp():
#     assert spice.prsdp("-1. 000") == -1.0


# def test_prsint():
#     assert spice.prsint("PI") == 3


# def test_psv2pl():
#     spice.kclear()
#     epoch = 'Jan 1 2005'
#     frame = 'ECLIPJ2000'
#     spice.furnsh(CoreKernels.testMetaKernel)
#     et = spice.str2et(epoch)
#     state, ltime = spice.spkezr('EARTH', et, frame, 'NONE', 'Solar System Barycenter')
#     es_plane = spice.psv2pl(state[0:3], state[0:3], state[3:6])
#     es_norm, es_const = spice.pl2nvc(es_plane)
#     mstate, mltime = spice.spkezr('MOON', et, frame, 'NONE', 'EARTH BARYCENTER')
#     em_plane = spice.psv2pl(mstate[0:3], mstate[0:3], mstate[3:6])
#     em_norm, em_const = spice.pl2nvc(em_plane)
#     spice.kclear()
#     npt.assert_almost_equal(spice.vsep(es_norm, em_norm) * spice.dpr(), 5.0424941, decimal=6)


# def test_pxform():
#     spice.kclear()
#     spice.furnsh(CoreKernels.testMetaKernel)
#     lon = 118.25 * spice.rpd()
#     lat = 34.05 * spice.rpd()
#     alt = 0.0
#     utc = 'January 1, 2005'
#     et = spice.str2et(utc)
#     len, abc = spice.bodvrd('EARTH', 'RADII', 3)
#     equatr = abc[0]
#     polar = abc[2]
#     f = (equatr - polar) / equatr
#     epos = spice.georec(lon, lat, alt, equatr, f)
#     rotate = np.array(spice.pxform('IAU_EARTH', 'J2000', et))
#     spice.kclear()
#     jstate = np.dot(epos, rotate)
#     expected = np.array([5042.1309421, 1603.52962986, 3549.82398086])
#     npt.assert_array_almost_equal(jstate, expected, decimal=4)


# def test_pxfrm2():
#     spice.kclear()
#     # load kernels
#     spice.furnsh(CoreKernels.testMetaKernel)
#     spice.furnsh(CassiniKernels.cassSclk)
#     spice.furnsh(CassiniKernels.cassFk)
#     spice.furnsh(CassiniKernels.cassPck)
#     spice.furnsh(CassiniKernels.cassIk)
#     spice.furnsh(CassiniKernels.cassSclk)
#     spice.furnsh(CassiniKernels.satSpk)
#     spice.furnsh(CassiniKernels.cassTourSpk)
#     spice.furnsh(CassiniKernels.cassCk)
#     # start of test
#     etrec = spice.str2et("2013 FEB 25 11:50:00 UTC")
#     camid = spice.bodn2c("CASSINI_ISS_NAC")
#     shape, obsref, bsight, n, bounds = spice.getfov(camid, 4)
#     # run sincpt on boresight vector
#     spoint, etemit, srfvec = spice.sincpt("Ellipsoid", 'Enceladus', etrec, "IAU_ENCELADUS", "CN+S", "CASSINI", obsref, bsight)
#     rotate = spice.pxfrm2(obsref, "IAU_ENCELADUS", etrec, etemit)
#     # get radii
#     num_vals, radii = spice.bodvrd("Enceladus", "RADII", 3)
#     # find position of center with respect to MGS
#     pcassmr = spice.vsub(spoint, srfvec)
#     # rotate into IAU_MARS
#     bndvec = spice.mxv(rotate, spice.vlcom(0.9999,bsight,0.0001,bounds[1]))
#     # get surface point
#     spoint = spice.surfpt(pcassmr, bndvec, radii[0], radii[1], radii[2])
#     radius, lon, lat = spice.reclat(spoint)
#     lon *= spice.dpr()
#     lat *= spice.dpr()
#     # test output
#     npt.assert_almost_equal(radius, 250.14507342586242, decimal=5)
#     npt.assert_almost_equal(lon,    125.42089677611104, decimal=5)
#     npt.assert_almost_equal(lat,    -6.3718522103931585, decimal=5)
#     # end of test
#     spice.kclear()
    @test pxform("J2000", "J2000", 0.) ≈ Matrix{Float64}(I, 3, 3)
    @test_throws SpiceError pxform("Norbert", "J2000",0.)
end
