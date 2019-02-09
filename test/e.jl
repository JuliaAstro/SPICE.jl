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
            # umbral
            trgepc, obspos, trmpts = edterm("UMBRAL", "SUN", "MOON", et, "IAU_MOON", "EARTH", 3, abcorr="LT+S")
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
            trgepc, obspos, trmpts = edterm("PENUMBRAL", "SUN", "MOON", et, "IAU_MOON", "EARTH", 3, abcorr="LT+S")
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
#=     @testset "ekacec" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekacec.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "test_table_ekacec", ["c1"], ["DATATYPE = CHARACTER*(*), NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacec(handle, segno, recno, "c1", 2, ["1.0", "2.0"], False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekaced" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekaced.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "test_table_ekaced", ["c1"], ["DATATYPE = DOUBLE PRECISION, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekaced(handle, segno, recno, "c1", 2, [1.0, 2.0], False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekmany" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekmany.ek") =#
#=         tablename = "test_table_ekmany" =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         # Create new EK and new segment with table =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         decls = ["DATATYPE = CHARACTER*(10),   NULLS_OK = FALSE, SIZE = VARIABLE", =#
#=                  "DATATYPE = DOUBLE PRECISION, NULLS_OK = FALSE, SIZE = VARIABLE", =#
#=                  "DATATYPE = INTEGER,          NULLS_OK = FALSE, SIZE = VARIABLE"] =#
#=         segno = ekbseg(handle, tablename, ['c1', 'd1', 'i1'], decls) =#
#=         # Insert records:  1, 2, and 3 entries at rows 0, 1, 2, respectively =#
#=         c_data = [['100'], ['101', '101'], ['102', '102', '102']] =#
#=         d_data = [[100.0], [101.0, 101.0], [102.0, 102.0, 102.0]] =#
#=         i_data = [[100], [101, 101], [102, 102, 102]] =#
#=         for r in range(0, 3): =#
#=             ekinsr(handle, segno, r) =#
#=             ekacec(handle, segno, r, "c1", len(c_data[r]), c_data[r], False) =#
#=             ekaced(handle, segno, r, "d1", len(d_data[r]), d_data[r], False) =#
#=             ekacei(handle, segno, r, "i1", len(i_data[r]), i_data[r], False) =#
#=         # Try record insertion beyond the next available, verify the exception =#
#=         with pytest.raises(stypes.SpiceyError): =#
#=             ekinsr(handle, segno, 4) =#
#=         # Close EK, then reopen for reading =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         # =#
#=         # Start of part two =#
#=         # =#
#=         handle = eklef(ekpath) =#
#=         @test handle is not None =#
#=         # Test query using ekpsel =#
#=         query = "SELECT c1, d1, i1 from {}".format(tablename) =#
#=         n, xbegs, xends, xtypes, xclass, tabs, cols, err, errmsg = ekpsel(query, 99, 99, 99) =#
#=         @test n == 3 =#
#=         @test stypes.SpiceEKDataType.SPICE_CHR == xtypes[0] =#
#=         @test stypes.SpiceEKDataType.SPICE_DP  == xtypes[1] =#
#=         @test stypes.SpiceEKDataType.SPICE_INT == xtypes[2] =#
#=         @test ([stypes.SpiceEKExprClass.SPICE_EK_EXP_COL]*3) == list(xclass) =#
#=         @test (["TEST_TABLE_EKMANY"]*3) == tabs =#
#=         @test "C1 D1 I1".split() == cols =#
#=         @test not err =#
#=         @test "" == errmsg =#
#=         # Run query to retrieve the row count =#
#=         nmrows, error, errmsg = ekfind(query, 99) =#
#=         @test nmrows == 3 =#
#=         @test not error =#
#=         @test '' == errmsg =#
#=         # test fail case for eknelt =#
#=         with pytest.raises(stypes.SpiceyError): =#
#=             eknelt(0, nmrows+1) =#
#=         # Validate the content of each field, including exceptions when =#
#=         # Loop over rows, test .ekgc/.ekgd/.ekgi =#
#=         for r in range(nmrows): =#
#=             # get number of elements in this row =#
#=             n_elm = eknelt(0, r) =#
#=             @test  n_elm == r + 1 =#
#=             for e in range(0, n_elm): =#
#=                 # get row int data =#
#=                 i_datum, i_null = ekgi(2, r, e) =#
#=                 @test not i_null =#
#=                 @test i_datum == i_data[r][e] =#
#=                 # get row double data =#
#=                 d_datum, d_null = ekgd(1, r, e) =#
#=                 @test not d_null =#
#=                 @test d_datum == d_data[r][e] =#
#=                 # get row char data =#
#=                 c_datum, c_null = ekgc(0, r, e) =#
#=                 @test not c_null =#
#=                 @test c_datum == c_data[r][e] =#
#=         # Loop over rows, test .ekrcec/.ekrced/.ekrcei =#
#=         for r in range(nmrows): =#
#=             # get row int data =#
#=             ni_vals, ri_data, i_null = ekrcei(handle, segno, r, "i1") =#
#=             @test not i_null =#
#=             @test ni_vals == r + 1 =#
#=             npt.@test_array_equal(ri_data, i_data[r]) =#
#=             # get row double data =#
#=             nd_vals, rd_data, d_null = ekrced(handle, segno, r, "d1") =#
#=             @test not d_null =#
#=             @test nd_vals == r + 1 =#
#=             npt.@test_array_equal(rd_data, d_data[r]) =#
#=             # get row char data =#
#=             nc_vals, rc_data, c_null = ekrcec(handle, segno, r, "c1", 11) =#
#=             @test not c_null =#
#=             @test nc_vals == r + 1 =#
#=             @test rc_data == c_data[r] =#
#=         # test out of bounds =#
#=         with pytest.raises(stypes.SpiceyError): =#
#=             ekrcei(handle, segno, 3, "i1") =#
#=         with pytest.raises(stypes.SpiceyError): =#
#=             ekrced(handle, segno, 3, "d1") =#
#=         #with pytest.raises(stypes.SpiceyError): TODO: FIX =#
#=         #    ekrcec(handle, segno, 4, "c1", 4) # this causes a SIGSEGV =#
#=         # =#
#=         # Part 3 =#
#=         # =#
#=         # Close file, re-open for writing =#
#=         ekuef(handle) =#
#=         handle = ekopw(ekpath) =#
#=         # Loop over rows, update values using .ekucec/.ekuced/.ekucei =#
#=         c_data = [['200'], ['201', '201'], ['202', '202', '202']] =#
#=         d_data = [[200.0], [201.0, 201.0], [202.0, 202.0, 202.0]] =#
#=         i_data = [[200], [201, 201], [202, 202, 202]] =#
#=         for r in range(0, 3): =#
#=             ekucec(handle, segno, r, "c1", len(c_data[r]), c_data[r], False) =#
#=             ekuced(handle, segno, r, "d1", len(d_data[r]), d_data[r], False) =#
#=             ekucei(handle, segno, r, "i1", len(i_data[r]), i_data[r], False) =#
#=         # Test invalid updates =#
#=         with pytest.raises(stypes.SpiceyError): =#
#=             ekucec(handle, segno, 3, "c1", 1, ['300'], False) =#
#=         with pytest.raises(stypes.SpiceyError): =#
#=             ekuced(handle, segno, 3, "d1", 1, [300.0], False) =#
#=         with pytest.raises(stypes.SpiceyError): =#
#=             ekucei(handle, segno, 3, "i1", 1, [300], False) =#
#=         # Loop over rows, use .ekrcec/.ekrced/.ekrcei to test updates =#
#=         for r in range(nmrows): =#
#=             # get row int data =#
#=             ni_vals, ri_data, i_null = ekrcei(handle, segno, r, "i1") =#
#=             @test not i_null =#
#=             @test ni_vals == r + 1 =#
#=             npt.@test_array_equal(ri_data, i_data[r]) =#
#=             # get row double data =#
#=             nd_vals, rd_data, d_null = ekrced(handle, segno, r, "d1") =#
#=             @test not d_null =#
#=             @test nd_vals == r + 1 =#
#=             npt.@test_array_equal(rd_data, d_data[r]) =#
#=             # get row char data =#
#=             nc_vals, rc_data, c_null = ekrcec(handle, segno, r, "c1", 11) =#
#=             @test not c_null =#
#=             @test nc_vals == r + 1 =#
#=             @test rc_data == c_data[r] =#
#=         # Cleanup =#
#=         ekcls(handle) =#
#=         @test not failed() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=  =#
#=  =#
#=     @testset "ekaclc" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekaclc.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekaclc", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = CHARACTER*(*), INDEXED  = TRUE"]) =#
#=         ekaclc(handle, segno, "c1", 10, ["1.0", "2.0"], [4, 4], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekacld" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekacld.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekacld", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = DOUBLE PRECISION, NULLS_OK = FALSE"]) =#
#=         ekacld(handle, segno, "c1", [1.0, 2.0], [1, 1], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekacli" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekacli.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekacli", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = TRUE"]) =#
#=         ekacli(handle, segno, "c1", [1, 2], [1, 1], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekacli_stress" begin =#
#=         for i in range(10): =#
#=             test_ekacli() =#
#=  =#
#=  =#
#=     @testset "ekappr" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekappr.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "test_table_ekappr", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekbseg" begin =#
#=         ekpath = os.path.join(cwd, "example_ekbseg.ek") =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, "Test EK", 100) =#
#=         cnames = ['INT_COL_1'] =#
#=         cdecls = ["DATATYPE=INTEGER, INDEXED=TRUE, NULLS_OK=TRUE"] =#
#=         segno = ekbseg(handle, "SCALAR_DATA", cnames, cdecls) =#
#=         recno = ekappr(handle, segno) =#
#=         @test recno != -1 =#
#=         ordids = [x for x in range(5)] =#
#=         ekacei(handle, segno, recno, 'INT_COL_1', 5, ordids, False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekbseg_stress" begin =#
#=         for i in range(10): =#
#=             test_ekbseg() =#
#=  =#
#=  =#
#=     @testset "ekccnt" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekccnt.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "TEST_TABLE_EKCCNT", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         furnsh(ekpath) =#
#=         @test ekntab() == 1 =#
#=         @test ektnam(0, 100) == "TEST_TABLE_EKCCNT" =#
#=         @test ekccnt("TEST_TABLE_EKCCNT") == 1 =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekcii" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekcii.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "TEST_TABLE_EKCII", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         furnsh(ekpath) =#
#=         @test ekntab() == 1 =#
#=         @test ektnam(0, 100) == "TEST_TABLE_EKCII" =#
#=         @test ekccnt("TEST_TABLE_EKCII") == 1 =#
#=         column, attdsc = ekcii("TEST_TABLE_EKCII", 0, 30) =#
#=         kclear() =#
#=         @test column == "C1" =#
#=         @test attdsc.cclass == 1 =#
#=         @test attdsc.dtype == 2 =#
#=         @test attdsc.size == 1 =#
#=         @test attdsc.strlen == 1 =#
#=         @test not attdsc.indexd =#
#=         @test attdsc.nullok # this used to be false, although clearly it should be true given the call to ekbseg =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekcls" begin =#
#=         kclear()  # same as ekopn test =#
#=         ekpath = os.path.join(cwd, "example_ekcls.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 80) =#
#=         ekcls(handle) =#
#=         @test exists(ekpath) =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         kclear() =#
#=  =#
#=  =#
#=     @testset "ekdelr" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekdelr.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekdelr", 1, 10, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = TRUE"]) =#
#=         ekacli(handle, segno, "c1", [1, 2], [1], [False, False], rcptrs, [1]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekdelr(handle, segno, 2) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekdelr_stress" begin =#
#=         for i in range(10): =#
#=             test_ekdelr() =#
#=  =#
#=  =#
#=     @testset "ekffld" begin =#
#=         # same as test_ekacli =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekffld.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekffld", 1, 10, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = TRUE"]) =#
#=         ekacli(handle, segno, "c1", [1, 2], [1], [False, False], rcptrs, [1]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekffld_stress" begin =#
#=         for i in range(10): =#
#=             test_ekffld() =#
#=  =#
#=  =#
#=     @testset "ekfind" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekfind.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekfind", 1, 2, 200, ["cc1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = TRUE"]) =#
#=         ekacli(handle, segno, "cc1", [1, 2], [1, 1], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         furnsh(ekpath) =#
#=         nmrows, error, errmsg = ekfind("SELECT CC1 FROM TEST_TABLE_EKFIND WHERE CC1 > 0", 100) =#
#=         @test nmrows != 0  # should be 2 but I am not concerned about correctness in this case =#
#=         @test not error =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekfind_stess" begin =#
#=         for i in range(10): =#
#=             test_ekfind() =#
#=  =#
#=  =#
#=     @testset "ekgc" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekgc.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekgc", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = CHARACTER*(*), INDEXED  = TRUE"]) =#
#=         ekaclc(handle, segno, "c1", 10, ["1.0", "2.0"], [4, 4], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         furnsh(ekpath) =#
#=         nmrows, error, errmsg = ekfind("SELECT C1 FROM TEST_TABLE_EKGC", 100) =#
#=         @test not error =#
#=         c, null = ekgc(0, 0, 0, 4) =#
#=         @test not null =#
#=         @test c == "1.0" =#
#=         c, null = ekgc(0, 1, 0, 4) =#
#=         @test not null =#
#=         # @test c == "2.0" this fails, c is an empty string despite found being true. =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekgd" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekgd.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekgd", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = DOUBLE PRECISION, NULLS_OK = TRUE"]) =#
#=         ekacld(handle, segno, "c1", [1.0, 2.0], [1, 1], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         furnsh(ekpath) =#
#=         nmrows, error, errmsg = ekfind("SELECT C1 FROM TEST_TABLE_EKGD", 100) =#
#=         @test not error =#
#=         d, null = ekgd(0, 0, 0) =#
#=         @test not null =#
#=         @test d == 1.0 =#
#=         d, null = ekgd(0, 1, 0) =#
#=         @test not null =#
#=         @test d == 2.0 =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekgi" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekgi.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekgi", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = FALSE"]) =#
#=         ekacli(handle, segno, "c1", [1, 2], [1, 1], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         furnsh(ekpath) =#
#=         nmrows, error, errmsg = ekfind("SELECT C1 FROM TEST_TABLE_EKGI", 100) =#
#=         @test not error =#
#=         i, null = ekgi(0, 0, 0) =#
#=         @test not null =#
#=         @test i == 1 =#
#=         i, null = ekgi(0, 1, 0) =#
#=         @test not null =#
#=         @test i == 2 =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekifld" begin =#
#=         # Same as test_ekacli =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekifld.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekifld", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = TRUE"]) =#
#=         ekacli(handle, segno, "c1", [1, 2], [1, 1], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "eklef" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_eklef.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "test_table_eklef", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         handle = eklef(ekpath) =#
#=         @test handle is not None =#
#=         ekuef(handle) =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=  =#
#=  =#
#=     @testset "eknseg" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_eknseg.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "TEST_TABLE_EKNSEG", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], False) =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         handle = ekopr(ekpath) =#
#=         @test eknseg(handle) == 1 =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ekntab" begin =#
#=         @test ekntab() == 0 =#
#=  =#
#=  =#
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
#=  =#
#=  =#
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
#=  =#
#=  =#
#=     @testset "ekops" begin =#
#=         kclear() =#
#=         handle = ekops() =#
#=         @test handle is not None =#
#=         ekcls(handle) =#
#=         kclear() =#
#=  =#
#=  =#
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
#=  =#
#=  =#
#=     @testset "ekssum" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ekssum.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno, rcptrs = ekifld(handle, "test_table_ekssum", 1, 2, 200, ["c1"], 200, =#
#=                                      ["DATATYPE = INTEGER, NULLS_OK = TRUE"]) =#
#=         ekacli(handle, segno, "c1", [1, 2], [1, 1], [False, False], rcptrs, [0, 0]) =#
#=         ekffld(handle, segno, rcptrs) =#
#=         segsum = ekssum(handle, segno) =#
#=         @test segsum.ncols == 1 =#
#=         @test segsum.nrows == 2 =#
#=         @test segsum.cnames == ["C1"] =#
#=         @test segsum.tabnam == "TEST_TABLE_EKSSUM" =#
#=         c1descr = segsum.cdescrs[0] =#
#=         @test c1descr.dtype == 2 =#
#=         @test c1descr.indexd is False =#
#=         # @test c1descr.null == True, for some reason this is actually false, SpikeEKAttDsc may not be working correctly =#
#=         ekcls(handle) =#
#=         kclear() =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         @test not exists(ekpath) =#
#=  =#
#=  =#
#=     @testset "ektnam" begin =#
#=         kclear() =#
#=         ekpath = os.path.join(cwd, "example_ektnam.ek") =#
#=         if exists(ekpath): =#
#=             os.remove(ekpath) # pragma: no cover =#
#=         handle = ekopn(ekpath, ekpath, 0) =#
#=         segno = ekbseg(handle, "TEST_TABLE_EKTNAM", ["c1"], ["DATATYPE  = INTEGER, NULLS_OK = TRUE"]) =#
#=         recno = ekappr(handle, segno) =#
#=         ekacei(handle, segno, recno, "c1", 2, [1, 2], False) =#
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
#=  =#
#=  =#
#=     @testset "ekucec" begin =#
#=         @test 1 =#
#=  =#
#=  =#
#=     @testset "ekuced" begin =#
#=         @test 1 =#
#=  =#
#=  =#
#=     @testset "ekucei" begin =#
#=         @test 1 =#
#=  =#
#=  =#
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
#=  =#
#=  =#
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
#=  =#
#=  =#
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
#=  =#
#=  =#
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
#=  =#
#=  =#
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
#=  =#
#=  =#
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
#=  =#
#=  =#
#=     @testset "eqstr" begin =#
#=         @test eqstr("A short string    ", "ashortstring") =#
#=         @test eqstr("Embedded        blanks", "Em be dd ed bl an ks") =#
#=         @test eqstr("One word left out", "WORD LEFT OUT") is False =#
#=  =#
#=  =#
#=     @testset "erract" begin =#
#=         @test erract("GET", 10, "") == "RETURN" =#
#=         @test erract("GET", 10) == "RETURN" =#
#=  =#
#=  =#
#=     @testset "errch" begin =#
#=         setmsg("test errch value: #") =#
#=         errch("#", "some error") =#
#=         sigerr("some error") =#
#=         message = getmsg("LONG", 2000) =#
#=         @test message == "test errch value: some error" =#
#=         reset() =#
#=  =#
#=  =#
#=     @testset "errdev" begin =#
#=         @test errdev("GET", 10, "Screen") == "NULL" =#
#=  =#
#=  =#
#=     @testset "errdp" begin =#
#=         setmsg("test errdp value: #") =#
#=         errdp("#", 42.1) =#
#=         sigerr("some error") =#
#=         message = getmsg("LONG", 2000) =#
#=         @test message == "test errdp value: 4.2100000000000E+01" =#
#=         reset() =#
#=  =#
#=  =#
#=     @testset "errint" begin =#
#=         setmsg("test errint value: #") =#
#=         errint("#", 42) =#
#=         sigerr("some error") =#
#=         message = getmsg("LONG", 2000) =#
#=         @test message == "test errint value: 42" =#
#=         reset() =#
#=  =#
#=  =#
#=     @testset "errprt" begin =#
#=         @test errprt("GET", 40, "ALL") == "NULL" =#
#=  =#
#=  =#
#=     @testset "esrchc" begin =#
#=         array = ["This", "is", "a", "test"] =#
#=         @test esrchc("This", array) == 0 =#
#=         @test esrchc("is", array) == 1 =#
#=         @test esrchc("a", array) == 2 =#
#=         @test esrchc("test", array) == 3 =#
#=         @test esrchc("fail", array) == -1 =#
#=  =#
#=  =#
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
#=  =#
#=  =#
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
#=  =#
#=  =#
#=     @testset "exists" begin =#
#=         @test exists(CoreKernels.testMetaKernel) =#
#=  =#
#=  =#
#=     @testset "expool" begin =#
#=         kclear() =#
#=         textbuf = ['DELTET/K = 1.657D-3', 'DELTET/EB = 1.671D-2'] =#
#=         lmpool(textbuf) =#
#=         @test expool('DELTET/K') =#
#=         @test expool('DELTET/EB') =#
#=         kclear() =#
#=  =#
#=  =#
#=     @testset "expoolstress" begin =#
#=         # this is to show that the bug in lmpool is fixed (lenvals needs +=1) =#
#=         for i in range(500): =#
#=         test_expool() =#
end

