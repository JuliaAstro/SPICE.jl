@testset "E" begin
    @testset "edlimb" begin
        viewpt = [2.0, 0.0, 0.0]
        limb = edlimb(sqrt(2), 2.0 * sqrt(2), sqrt(2), viewpt)
        expected_sminor = [0.0, 0.0, -1.0]
        expected_smajor = [0.0, 2.0, 0.0]
        expected_center = [1.0, 0.0, 0.0]
        @test center(limb) ≈ expected_center
        @test semi_major(limb) ≈ expected_smajor
        @test semi_minor(limb) ≈ expected_sminor
        @test_throws ArgumentError edlimb(sqrt(2), 2.0 * sqrt(2), sqrt(2), viewpt[1:2])
        @test_throws SpiceError edlimb(sqrt(2), 2.0 * sqrt(2), -sqrt(2), viewpt)
    end
    @testset "edterm" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et = str2et("2007 FEB 3 00:00:00.000")
            trgepc, obspos, trmpts = edterm("UMBRAL", "SUN", "MOON", et, "IAU_MOON", "LT+S", "EARTH", 3)
            expected_trgepc = 223732863.86351674795
            expected_obspos = [394721.1024056578753516078,
                               27265.11780063395417528227,
                               -19069.08478859506431035697]
            expected_trmpts0 = [-1.53978381936825627463e+02,
                                -1.73056331949840728157e+03,
                                1.22893325627419600088e-01]
            expected_trmpts1 = [ 87.37506200891714058798,
                                864.40670594653545322217,
                                1504.56817899807947469526]
            expected_trmpts2 = [ 42.21324376177891224415,
                                868.21134635239388899208,
                                -1504.3223923468244720425]
            expected_trmpts = [ -1.53978381936825627463e+02,
                               -1.73056331949840728157e+03,
                               1.22893325627419600088e-01,
                               87.37506200891714058798,
                               864.40670594653545322217,
                               1504.56817899807947469526,
                               42.21324376177891224415,
                               868.21134635239388899208,
                               -1504.3223923468244720425]

            @test trgepc ≈ expected_trgepc
            @test obspos[1] ≈ expected_obspos[1]
            @test obspos[2] ≈ expected_obspos[2]
            @test obspos[3] ≈ expected_obspos[3]

            @testset for i in eachindex(trmpts, expected_trmpts)
            @test obspos[1] ≈ expected_obspos[1]
                @test trmpts[i] ≈ expected_trmpts[i]
            end
            iluet0, srfvec0, phase0, solar0, emissn0 = ilumin("Ellipsoid", "MOON", et, "IAU_MOON",
                                                              "EARTH", trmpts[:,1], abcorr="LT+S")
            @test rad2deg(solar0) ≈ 90.269765819
            iluet1, srfvec1, phase1, solar1, emissn1 = ilumin("Ellipsoid", "MOON", et, "IAU_MOON",
                                                              "EARTH", trmpts[:,2], abcorr="LT+S")
            @test rad2deg(solar1) ≈ 90.269765706
            iluet2, srfvec2, phase2, solar2, emissn2 = ilumin("Ellipsoid", "MOON", et, "IAU_MOON",
                                                              "EARTH", trmpts[:,3], abcorr="LT+S")
            @test rad2deg(solar2) ≈ 90.269765730
            # penumbral
            trgepc, obspos, trmpts = edterm("PENUMBRAL", "SUN", "MOON", et, "IAU_MOON", "LT+S", "EARTH", 3)
            expected_trmpts = [1.54019056755619715204e+02,
                               1.73055969989532059117e+03,
                               -1.23508409498995316844e-01,
                               -87.33436047798454637814,
                               -864.41003834758112134296,
                               -1504.56862757530461749411,
                               -42.17254722919552278881,
                               -868.21467833235510624945,
                               1504.32161075630597224517]
            @test trgepc ≈ expected_trgepc
            @test obspos[1] ≈ expected_obspos[1]
            @test obspos[2] ≈ expected_obspos[2]
            @test obspos[3] ≈ expected_obspos[3]
            @testset for i in eachindex(trmpts, expected_trmpts)
                @test trmpts[i] ≈ expected_trmpts[i]
            end
            iluet0, srfvec0, phase0, solar0, emissn0 = ilumin("Ellipsoid", "MOON", et, "IAU_MOON",
                                                              "EARTH", trmpts[:,1], abcorr="LT+S")
            @test rad2deg(solar0) ≈ 89.730234406
            iluet1, srfvec1, phase1, solar1, emissn1 = ilumin("Ellipsoid", "MOON", et, "IAU_MOON",
                                                              "EARTH", trmpts[:,2], abcorr="LT+S")
            @test rad2deg(solar1) ≈ 89.730234298
            iluet2, srfvec2, phase2, solar2, emissn2 = ilumin("Ellipsoid", "MOON", et, "IAU_MOON",
                                                              "EARTH", trmpts[:,3], abcorr="LT+S")
            @test rad2deg(solar2) ≈ 89.730234322
        finally
            kclear()
        end
    end
    @testset "ekacec" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno = ekbseg(handle, "test_table_ekacec", ["c1"],
                           ["DATATYPE = CHARACTER*(*), NULLS_OK = TRUE"])
            recno = ekappr(handle, segno)
            ekacec(handle, segno, recno, "c1", ["1.0", "2.0"], false)
            ekcls(handle)
        finally
            kclear()
        end
    end
    @testset "ekaced" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno = ekbseg(handle, "test_table_ekaced", ["c1"],
                           ["DATATYPE = DOUBLE PRECISION, NULLS_OK = TRUE"])
            recno = ekappr(handle, segno)
            ekaced(handle, segno, recno, "c1", [1.0, 2.0], false)
            ekcls(handle)
        finally
            kclear()
        end
    end
    @testset "ekacei" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno = ekbseg(handle, "test_table_ekacei", ["c1"],
                           ["DATATYPE = INTEGER, NULLS_OK = TRUE"])
            recno = ekappr(handle, segno)
            ekacei(handle, segno, recno, "c1", [1, 2], false)
            ekcls(handle)
        finally
            kclear()
        end
    end
    @testset "ekntab/ektnam/ekccnt" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno = ekbseg(handle, "TEST_TABLE_EKCCNT", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"])
            recno = ekappr(handle, segno)
            ekacei(handle, segno, recno, "c1", [1, 2], false)
            ekcls(handle)
            kclear()
            furnsh(ekpath)
            @test ekntab() == 1
            @test ektnam(1) == "TEST_TABLE_EKCCNT"
            @test ekccnt("TEST_TABLE_EKCCNT") == 1
        finally
            kclear()
        end
    end
    @testset "ekcii" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno = ekbseg(handle, "TEST_TABLE_EKCII", ["c1"], ["DATATYPE = INTEGER, NULLS_OK = TRUE"])
            recno = ekappr(handle, segno)
            ekacei(handle, segno, recno, "c1", [1, 2], false)
            ekcls(handle)
            kclear()
            furnsh(ekpath)
            @test ekntab() == 1
            @test ektnam(1) == "TEST_TABLE_EKCII"
            @test ekccnt("TEST_TABLE_EKCII") == 1
            column, attdsc = ekcii("TEST_TABLE_EKCII", 1)
            @test column == "C1"
            @test attdsc.cclass == 1
            @test attdsc.dtype == 2
            @test attdsc.size == 1
            @test attdsc.strlen == 1
            @test attdsc.indexd == 0
            @test attdsc.nullok == 1
        finally
            kclear()
        end
    end
    @testset "ekdelr" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno, rcptrs = ekifld(handle, "TEST_TABLE_EKDELR", 2, ["c1"],
                                   ["DATATYPE = INTEGER, NULLS_OK = TRUE"])
            ekacli(handle, segno, "c1", [[1], [2]], [false, false], rcptrs)
            ekffld(handle, segno, rcptrs)
            ekdelr(handle, segno, 1)
            ekcls(handle)
        finally
            kclear()
        end
    end
    @testset "ekfind" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno, rcptrs = ekifld(handle, "test_table_ekfind", 2, ["cc1"],
                                   ["DATATYPE = INTEGER, NULLS_OK = TRUE"])
            ekacli(handle, segno, "cc1", [[1], [2]], [false, false], rcptrs)
            ekffld(handle, segno, rcptrs)
            ekcls(handle)
            kclear()
            furnsh(ekpath)
            nmrows = ekfind("SELECT CC1 FROM TEST_TABLE_EKFIND WHERE CC1 > 0", 100)
            @test nmrows == 2
        finally
            kclear()
        end
    end
    @testset "ekclc/ekgc" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno, rcptrs = ekifld(handle, "TEST_TABLE_EKGC", 3, ["c1"],
                                   ["DATATYPE = CHARACTER*(*), INDEXED = TRUE, NULLS_OK = TRUE"])
            ekaclc(handle, segno, "c1", ["1.0", "2.0", ""], [false, false, true], rcptrs)
            ekffld(handle, segno, rcptrs)
            ekcls(handle)
            kclear()
            furnsh(ekpath)
            nmrows = ekfind("SELECT C1 FROM TEST_TABLE_EKGC", 100)
            @test nmrows == 3
            c = ekgc(1, 1, 1)
            @test c == "1.0"
            c = ekgc(1, 2, 1)
            @test c == "2.0"
            c = ekgc(1, 3, 1)
            @test c === missing
        finally
            kclear()
        end
    end
    @testset "ekcld/ekgd" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno, rcptrs = ekifld(handle, "TEST_TABLE_EKGD", 3, ["c1"],
                                   ["DATATYPE = DOUBLE PRECISION, NULLS_OK = TRUE"])
            ekacld(handle, segno, "c1", [[1.0], [2.0], [1.0]], [false, false, true], rcptrs)
            ekffld(handle, segno, rcptrs)
            ekcls(handle)
            kclear()
            furnsh(ekpath)
            nmrows = ekfind("SELECT C1 FROM TEST_TABLE_EKGD", 100)
            @test nmrows == 3
            d = ekgd(1, 1, 1)
            @test d == 1.0
            d = ekgd(1, 2, 1)
            @test d == 2.0
            d = ekgd(1, 3, 1)
            @test d === missing
        finally
            kclear()
        end
    end
    @testset "ekcli/ekgi" begin
        try
            ekpath = tempname()
            handle = ekopn(ekpath, ekpath, 0)
            segno, rcptrs = ekifld(handle, "TEST_TABLE_EKGI", 3, ["c1"],
                                   ["DATATYPE = INTEGER, NULLS_OK = TRUE"])
            ekacli(handle, segno, "c1", [[1, 2], [2, 3], [1, 1]], [false, false, true], rcptrs)
            ekffld(handle, segno, rcptrs)
            ekcls(handle)
            kclear()
            furnsh(ekpath)
            nmrows = ekfind("SELECT C1 FROM TEST_TABLE_EKGI", 100)
            @test nmrows == 3
            d = ekgi(1, 1, 1)
            @test d == 1
            d = ekgi(1, 2, 1)
            @test d == 2
            d = ekgi(1, 3, 1)
            @test d === missing
        finally
            kclear()
        end
    end
#=     @testset "eklef" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_eklef.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "test_table_eklef", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], false) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         handle = eklef(ekpath) =#
#=         @test handle is not None =#
#=         ekuef(handle) =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=     @testset "eknseg" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_eknseg.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "TEST_TABLE_EKNSEG", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], false) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         handle = ekopr(ekpath) =#
#=         @test eknseg(handle) == 1 =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=     @testset "ekntab" begin =#
#=         @test ekntab() == 0 =#
#=     @testset "ekopn" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ek.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 80) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         @test exists(ekpath) =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=     @testset "ekopr" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekopr.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 80) =#
#=         ekcls(handle) =#
#=         @test exists(ekpath) =#
#=         testhandle = ekopr(ekpath) =#
#=         @test testhandle is not None =#
#=         ekcls(testhandle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=     @testset "ekops" begin =#
#=         kclear() =#
#=         handle = ekops() =#
#=         @test handle is not None =#
#=         ekcls(handle) =#
#=         kclear() =#
#=     @testset "ekopw" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekopw.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 80) =#
#=         ekcls(handle) =#
#=         @test exists(ekpath) =#
#=         testhandle = ekopw(ekpath) =#
#=         @test testhandle is not None =#
#=         ekcls(testhandle) =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         kclear() =#
#=     @testset "ekssum" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekssum.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekssum", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = TRUE"]) =#
#=         ekacli(handle, segno, "c1", [1, 2], [1, 1], [false, false], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         segsum = ekssum(handle, segno) =#
#=         @test segsum.ncols == 1 =#
#=         @test segsum.nrows == 2 =#
#=         @test segsum.cnames == ["C1"] =#
#=         @test segsum.tabnam == "TEST_TABLE_EKSSUM" =#
#=         c1descr = segsum.cdescrs[0] =#
#=         @test c1descr.dtype == 2 =#
#=         @test c1descr.indexd is false =#
#=         # @test c1descr.null == true, for some reason this is actually false, SpikeEKAttDsc may not be working correctly =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=     @testset "ektnam" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ektnam.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "TEST_TABLE_EKTNAM", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], false) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         furnsh(ekpath) =#
#=         @test ekntab() == 1 =#
#=         @test ektnam(0, 100) == "TEST_TABLE_EKTNAM" =#
#=         @test ekccnt("TEST_TABLE_EKTNAM") == 1 =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=     @testset "ekucec" begin =#
#=         @test 1 =#
#=     @testset "ekuced" begin =#
#=         @test 1 =#
#=     @testset "ekucei" begin =#
#=         @test 1 =#
#=     @testset "ekuef" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekuef.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 80) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         @test exists(ekpath) =#
#=         testhandle = ekopr(ekpath) =#
#=         @test testhandle is not None =#
#=         ekuef(testhandle) =#
#=         ekcls(testhandle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=     @testset "el2cgv" begin =#
#=         vec1 = [1.0, 1.0, 1.0] =#
#=         vec2 = [1.0, -1.0, 1.0] =#
#=         center = [1.0, 1.0, 1.0] =#
#=         smajor, sminor = saelgv(vec1, vec2) =#
#=         ellipse = cgv2el(center, smajor, sminor) =#
#=         outCenter, outSmajor, outSminor = el2cgv(ellipse) =#
#=         expectedCenter = [1.0, 1.0, 1.0] =#
#=         expectedSmajor = [sqrt(2.0), 0.0, sqrt(2.0)] =#
#=         expectedSminor = [0.0, sqrt(2.0), 0.0] =#
#=         npt.@test_array_almost_equal(outCenter, expectedCenter) =#
#=         npt.@test_array_almost_equal(outSmajor, expectedSmajor) =#
#=         npt.@test_array_almost_equal(outSminor, expectedSminor) =#
#=     @testset "elemc" begin =#
#=         testCellOne = cell_char(10, 10) =#
#=         insrtc("one", testCellOne) =#
#=         insrtc("two", testCellOne) =#
#=         insrtc("three", testCellOne) =#
#=         @test elemc("one", testCellOne) =#
#=         @test elemc("two", testCellOne) =#
#=         @test elemc("three", testCellOne) =#
#=         @test not elemc("not", testCellOne) =#
#=         @test not elemc("there", testCellOne) =#
#=     @testset "elemd" begin =#
#=         testCellOne = cell_double(8) =#
#=         insrtd(1.0, testCellOne) =#
#=         insrtd(2.0, testCellOne) =#
#=         insrtd(3.0, testCellOne) =#
#=         @test elemd(1.0, testCellOne) =#
#=         @test elemd(2.0, testCellOne) =#
#=         @test elemd(3.0, testCellOne) =#
#=         @test not elemd(4.0, testCellOne) =#
#=         @test not elemd(-1.0, testCellOne) =#
#=     @testset "elemi" begin =#
#=         testCellOne = cell_int(8) =#
#=         insrti(1, testCellOne) =#
#=         insrti(2, testCellOne) =#
#=         insrti(3, testCellOne) =#
#=         @test elemi(1, testCellOne) =#
#=         @test elemi(2, testCellOne) =#
#=         @test elemi(3, testCellOne) =#
#=         @test not elemi(4, testCellOne) =#
#=         @test not elemi(-1, testCellOne) =#
#=     @testset "eqncpv" begin =#
#=         p = 10000.0 =#
#=         gm = 398600.436 =#
#=         ecc = 0.1 =#
#=         a = p / (1.0 - ecc) =#
#=         n = sqrt(gm / a) / a =#
#=         argp = 30. * rpd() =#
#=         node = 15. * rpd() =#
#=         inc = 10. * rpd() =#
#=         m0 = 45. * rpd() =#
#=         t0 = -100000000.0 =#
#=         eqel = [a, ecc * sin(argp + node), ecc * cos(argp + node), m0 + argp + node, =#
#=                 tan(inc / 2.0) * sin(node), tan(inc / 2.0) * cos(node), 0.0, n, 0.0] =#
#=         state = eqncpv(t0 - 9750.0, t0, eqel, halfpi() * -1, halfpi()) =#
#=         expected = [-10732.167433285387, 3902.505790600528, 1154.4516152766892, =#
#=                     -2.540766899262123, -5.15226920298345, -0.7615758062877463] =#
#=         npt.@test_array_almost_equal(expected, state, decimal=5) =#
#=     @testset "eqstr" begin =#
#=         @test eqstr("A short string    ", "ashortstring") =#
#=         @test eqstr("Embedded        blanks", "Em be dd ed bl an ks") =#
#=         @test eqstr("One word left out", "WORD LEFT OUT") is false =#
#=     @testset "erract" begin =#
#=         @test erract("GET", 10, "") == "RETURN" =#
#=         @test erract("GET", 10) == "RETURN" =#
#=     @testset "errch" begin =#
#=         setmsg("test errch value: #") =#
#=         errch("#", "some error") =#
#=         sigerr("some error") =#
#=         message = getmsg("LONG", 2000) =#
#=         @test message == "test errch value: some error" =#
#=         reset() =#
#=     @testset "errdev" begin =#
#=         @test errdev("GET", 10, "Screen") == "NULL" =#
#=     @testset "errdp" begin =#
#=         setmsg("test errdp value: #") =#
#=         errdp("#", 42.1) =#
#=         sigerr("some error") =#
#=         message = getmsg("LONG", 2000) =#
#=         @test message == "test errdp value: 4.2100000000000E+01" =#
#=         reset() =#
#=     @testset "errint" begin =#
#=         setmsg("test errint value: #") =#
#=         errint("#", 42) =#
#=         sigerr("some error") =#
#=         message = getmsg("LONG", 2000) =#
#=         @test message == "test errint value: 42" =#
#=         reset() =#
#=     @testset "errprt" begin =#
#=         @test errprt("GET", 40, "ALL") == "NULL" =#
#=     @testset "esrchc" begin =#
#=         array = ["This", "is", "a", "test"] =#
#=         @test esrchc("This", array) == 0 =#
#=         @test esrchc("is", array) == 1 =#
#=         @test esrchc("a", array) == 2 =#
#=         @test esrchc("test", array) == 3 =#
#=         @test esrchc("fail", array) == -1 =#
#=     @testset "et2lst" begin =#
#=         kclear() =#
#=         furnsh(CoreKernels.testMetaKernel) =#
#=         et = str2et("2004 may 17 16:30:00") =#
#=         hr, mn, sc, time, ampm = et2lst(et, 399, 281.49521300000004 * rpd(), "planetocentric", 51, 51) =#
#=         @test hr == 11 =#
#=         @test mn == 19 =#
#=         @test sc == 22 =#
#=         @test time == "11:19:22" =#
#=         @test ampm == '11:19:22 A.M.' =#
#=         kclear() =#
    @testset "et2utc" begin
        try
            furnsh(path(CORE, :lsk))
            et = -527644192.5403653
            output = et2utc(et, :J, 6)
            @test output == "JD 2445438.006415"
            @test_throws SpiceError et2utc(et, :NORBERT, 6)
        finally
            kclear()
        end
    end
    @testset "etcal" begin
        et = 0.0
        cal = etcal(et)
        @test cal == "2000 JAN 01 12:00:00.000"
    end
    @testset "eul2m" begin
        act = eul2m(3, 2, 1, 3, 2, 1)
        @test size(act) == (3, 3)
        exp = [0.411982245665683 -0.6812427202564033 0.6051272472413688;
               0.05872664492762098 -0.642872836134547 -0.7637183366502791;
               0.9092974268256817 0.35017548837401463  -0.2248450953661529]
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
    end
#=     @testset "eul2xf" begin =#
#=         kclear() =#
#=         furnsh(CoreKernels.testMetaKernel) =#
#=         et = str2et("Jan 1, 2009") =#
#=         expected = sxform('IAU_EARTH', 'J2000', et) =#
#=         eul = [1.571803284049681, 0.0008750002978301174, 2.9555269829740034, =#
#=                3.5458495690569166e-12, 3.080552365717176e-12, -7.292115373266558e-05] =#
#=         out = eul2xf(eul, 3, 1, 3) =#
#=         npt.@test_array_almost_equal(out, expected) =#
#=         kclear() =#
#=     @testset "exists" begin =#
#=         @test exists(CoreKernels.testMetaKernel) =#
    @testset "expool" begin
        try
            textbuf = ["DELTET/K = 1.657D-3", "DELTET/EB = 1.671D-2"]
            lmpool(textbuf)
            @test expool("DELTET/K")
            @test expool("DELTET/EB")
        finally
            kclear()
        end
    end
end

