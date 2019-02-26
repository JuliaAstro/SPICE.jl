@testset "D" begin
    @testset "dafac/dafdc/dafec" begin
        try
            dafpath = tempname()
            handle = ckopn(dafpath, "TEST_ex_dafac", 140)
            cmnts = ["a", "bc", "def", "ghij"]
            dafac(handle, cmnts)
            dafcls(handle)
            handle = dafopr(dafpath)
            cmnts_out = dafec(handle)
            @test cmnts_out == cmnts
            cmnts_out = dafec(handle, bufsiz=1)
            @test cmnts_out == cmnts
            dafcls(handle)
            handle = dafopw(dafpath)
            dafac(handle, cmnts)
            cmnts_out = dafec(handle)
            @test cmnts_out == repeat(cmnts, 2)
            dafdc(handle)
            cmnts_out = dafec(handle)
            @test cmnts_out == String[]
        finally
            kclear()
        end
    end
    @testset "dafbbs/daffpa" begin
        try
            handle = dafopr(path(CORE, :spk))
            dafbbs(handle)
            found = daffpa()
            @test found
        finally
            kclear()
        end
    end
    @testset "dafbfs/daffna" begin
        try
            handle = dafopr(path(CORE, :spk))
            dafbfs(handle)
            found = daffna()
            @test found
        finally
            kclear()
        end
    end
    @testset "dafcs" begin
        try
            handle = dafopr(path(CORE, :spk))
            dafbbs(handle)
            dafcs(handle)
            found = daffpa()
            @test found
        finally
            kclear()
        end
    end
    @testset "dafgda" begin
        try
            handle = dafopr(path(CORE, :spk))
            elements = dafgda(handle, 1026, 1027)
            @test elements == [691200.0 / 2]
        finally
            kclear()
        end
    end
    @testset "dafgh" begin
        try
            handle = dafopr(path(CORE, :spk))
            dafbbs(handle)
            dafcs(handle)
            search_handle = dafgh()
            @test search_handle == handle
        finally
            kclear()
        end
    end
    @testset "dafgn/dafgs" begin
        try
            handle = dafopr(path(CORE, :spk))
            dafbfs(handle)
            found = daffna()
            @test found
            out = zeros(2)
            dafgs!(out)
            @test out ≈ [-9.46511378160646408796e+07, 3.15662463183953464031e+08]
            outname = dafgn(100)
            @test outname == "DE-405"
        finally
            kclear()
        end
    end
    @testset "dafgsr/dafrfr/dafus" begin
        try
            handle = dafopr(path(CORE, :spk))
            nd, ni, ifname, fward, bward, free = dafrfr(handle)
            @test nd == 2
            @test ni == 6
            ss = nd + ((ni+1) >> 1)

            while fward > 0
                recno = fward
                fward, bward, n_ss = drec = Int.(dafgsr(handle, recno, 1, 3))
                @test recno == 7
                @test fward == 0
                @test bward == 0
                @test n_ss == 15
                first_word = 4
                last_end_word = 1024
                for _ in 1:n_ss
                    drec = dafgsr(handle, recno, first_word, first_word + ss - 1)
                    dc, ic = dafus(drec, nd, ni)
                    body, center, frame, spk_type, start_word, end_word = ic
                    @test dc ≈ [-9.46511378160646408796e+07, 3.15662463183953464031e+08]
                    @test body ÷ 100 == center
                    @test frame == 1
                    @test spk_type == 2
                    @test last_end_word + 1 == start_word
                    first_word += ss
                    last_end_word = end_word
                end
                @test fward == 0
            end
        finally
            kclear()
        end
    end
    #= @testset "dafopr" begin =#
    #=     kclear() =#
    #=     handle = dafopr(CoreKernels.spk) =#
    #=     dafbfs(handle) =#
    #=     found = daffna() =#
    #=     @test found =#
    #=     dafcls(handle) =#
    #=     kclear() =#
    #= @testset "dafopw" begin =#
    #=     kclear() =#
    #=     handle = dafopw(CoreKernels.spk) =#
    #=     dafbfs(handle) =#
    #=     found = daffna() =#
    #=     @test found =#
    #=     dafcls(handle) =#
    #=     kclear() =#
    #= @testset "dafps_dafrs" begin =#
    #=     kclear() =#
    #=     dafpath = os.path.join(cwd, "ckopenkernel_dafps.bc") =#
    #=     if exists(dafpath): =#
    #=         os.remove(dafpath) # pragma: no cover =#
    #=     IFNAME = "Test CK type 1 segment created by cspice_ckw01" =#
    #=     handle = ckopn(dafpath, IFNAME, 10) =#
    #=     ckw01(handle, 1.0, 10.0, -77701, "J2000", True, "Test type 1 CK segment", =#
    #=                 2 - 1, [1.1, 4.1], [[1.0, 1.0, 1.0, 1.0], [2.0, 2.0, 2.0, 2.0]], =#
    #=                 [[0.0, 0.0, 1.0], [0.0, 0.0, 2.0]]) =#
    #=     ckcls(handle) =#
    #=     kclear() =#
    #=     # reload =#
    #=     handle = dafopw(dafpath) =#
    #=     @test handle is not None =#
    #=     # begin forward search =#
    #=     dafbfs(handle) =#
    #=     found = daffna() =#
    #=     @test found =#
    #=     out = dafgs(n=124) =#
    #=     dc, ic = dafus(out, 2, 6) =#
    #=     # change the id code and repack =#
    #=     ic[0] = -1999 =#
    #=     ic[1] = -2999 =#
    #=     summ = dafps(2, 6, dc, ic) =#
    #=     dafrs(summ) =#
    #=     # finished. =#
    #=     dafcls(handle) =#
    #=     kclear() =#
    #=     # reload the kernel and verify the ic"s got updated =#
    #=     handle = dafopr(dafpath) =#
    #=     @test handle is not None =#
    #=     # begin forward search =#
    #=     dafbfs(handle) =#
    #=     found = daffna() =#
    #=     @test found =#
    #=     out = dafgs(n=124) =#
    #=     dc, ic = dafus(out, 2, 6) =#
    #=     @test ic[0] == -1999 =#
    #=     @test ic[1] == -2999 =#
    #=     # cleanup =#
    #=     dafcls(handle) =#
    #=     kclear() =#
    #=     if exists(dafpath): =#
    #=         os.remove(dafpath) # pragma: no cover =#
    #= @testset "dafrda" begin =#
    #=     reset() =#
    #=     kclear() =#
    #=     # Open DAF =#
    #=     # N.B. The SPK used must use the LTL-IEEE double byte-ordering and format =#
    #=     # This should be de405s.bsp from the test kernel set =#
    #=     handle = dafopr(CoreKernels.spk) =#
    #=     # get ND, NI (N.B. for SPKs, ND=2 and NI=6), =#
    #=     # and first, last and free record numbers =#
    #=     nd, ni, ifname, fward, bward, free = dafrfr(handle) =#
    #=     @test nd == 2 and ni == 6 =#
    #=     # Calculate Single Summary size =#
    #=     ss = nd + ((ni+1) >> 1)  =#
    #=     iRecno = fward =#
    #=     # Get first three words at summary record (DAF record iRecno) =#
    #=     # * drec(1) NEXT forward pointer to next summary record =#
    #=     # * drec(2) PREV backward pointer (not used here) =#
    #=     # * drec(3) NSUM Number of single summaries in this DAF record =#
    #=     fward, bward, nSS = drec = map(int, dafgsr(handle, iRecno, 1, 3)) =#
    #=     # There is only one summary record in de405s.bsp =#
    #=     @test iRecno == 7 and fward is 0 and bward is 0 and nSS == 15 =#
    #=     # Set index to first word of first summary =#
    #=     firstWord = 4 =#
    #=     # Set DAF word before first segments first word (641 for de405s.bsp) =#
    #=     lastIEndWord = 1024 =#
    #=     # Loop over single summaries =#
    #=     for iSS in range(int(nSS)): =#
    #=         # Get packed summary =#
    #=         drec = dafgsr(handle, iRecno, firstWord, firstWord+ss-1) =#
    #=         # Unpack summary =#
    #=         dc, ic = dafus(drec, nd, ni) =#
    #=         iBody, iCenter, iFrame, iSPKtype, iStartWord, iEndWord = ic =#
    #=         # SPK de405s.bsp ephemerides run from [1997 JAN 01 00:01:02.183 (TDB)] to [2010 JAN 02 00:01:03.183 (TDB)] =#
    #=         @test_array_almost_equal(dc, [-9.46511378160646408796e+07,   3.15662463183953464031e+08]) =#
    #=         # Solar System body barycenters (IDs 1-10) centers are the Solar System Barycenter (ID=0) =#
    #=         # All other bodies" centers (e.g. 301; Moon) are their systems barycenter (e.g. 3 Earth-Moon Barycenter) =#
    #=         @test (iBody // 100) == iCenter =#
    #=         # All de405s.bsp ephemeris segments are in the J2000 frame (ID 1), =#
    #=         # are Type 2 SPK segments, and start immediately after the last =#
    #=         # word (lastIEndWord) for the previous segment =#
    #=         @test iFrame == 1 and iSPKtype == 2 and (lastIEndWord+1) == iStartWord =#
    #=         # Get the four-word directory at the end of the segment =#
    #=         segmentInit, segmentIntlen, segmentRsize, segmentN = segmentLast4 = dafrda(handle, ic[5]-3, ic[5]) =#
    #=         # Check segment word count (1+END-BEGIN) against directory word content =#
    #=         # Type 2 SPK segment word count: =#
    #=         # - A count of [segmentN] Chebyshev polynomial records @ RSIZE words per Cheby. poly. record =#
    #=         # - A four-word directory at the end of the segment =#
    #=         # So ((RSIZE * N) + 4) == (1 + END - BEGIN) =#
    #=         # - cf. https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/req/spk.html#Type%202:%20Chebyshev%20%28position%20only%29 =#
    #=         @test (3 + (segmentRsize * segmentN)) == (ic[5] - ic[4]) =#
    #=         # Setup for next segment:  advance BEGIN word of next single summary =#
    #=         firstWord += ss =#
    #=         lastIEndWord = iEndWord =#
    #=     # Cleanup =#
    #=     dafcls(handle) =#
    #=     reset() =#
    #=     kclear() =#
    #= @testset "dafrfr" begin =#
    #=     kclear() =#
    #=     handle = dafopr(CoreKernels.spk) =#
    #=     nd, ni, ifname, fward, bward, free = dafrfr(handle) =#
    #=     dafcls(handle) =#
    #=     @test nd == 2 =#
    #=     @test ni == 6 =#
    #=     @test ifname == "" =#
    #=     @test fward == 7 =#
    #=     @test bward == 7 =#
    #=     kclear() =#
    #= @testset "dafus" begin =#
    #=     kclear() =#
    #=     handle = dafopr(CoreKernels.spk) =#
    #=     dafbfs(handle) =#
    #=     found = daffna() =#
    #=     @test found =#
    #=     out = dafgs(n=124) =#
    #=     dc, ic = dafus(out, 2, 6) =#
    #=     dafcls(handle) =#
    #=     @test_array_almost_equal(dc, [-9.46511378160646408796e+07,   3.15662463183953464031e+08]) =#
    #=     @test_array_almost_equal(ic, [1, 0, 1, 2, 1025, 27164]) =#
    #=     kclear() =#
    #= @testset "dasac_dasopr_dasec_dasdc" begin =#
    #=     kclear() =#
    #=     daspath = os.path.join(cwd, "ex_dasac.das") =#
    #=     if exists(daspath): =#
    #=         os.remove(daspath) # pragma: no cover =#
    #=     handle = dasonw(daspath, "TEST", "ex_dasac", 140) =#
    #=     @test handle is not None =#
    #=     # write some comments =#
    #=     dasac(handle, ["spice", "naif", "python"]) =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #=     reset() =#
    #=     # we wrote to the test kernel, now load it in read mode =#
    #=     handle = dasopr(daspath) =#
    #=     @test handle is not None =#
    #=     # check that dashfn points to the correct path =#
    #=     @test dashfn(handle) == daspath =#
    #=     # extract out the comment, say we only want 3 things out =#
    #=     n, comments, done = dasec(handle, bufsiz=3) =#
    #=     @test n == 3 =#
    #=     @test set(comments) == {"spice", "naif", "python"} & set(comments) =#
    #=     # close the das file =#
    #=     dascls(handle) =#
    #=     ############################################### =#
    #=     # now test dasrfr =#
    #=     handle = dasopr(daspath) =#
    #=     @test handle is not None =#
    #=     idword, ifname, nresvr, nresvc, ncomr, ncomc = dasrfr(handle) =#
    #=     @test idword is not None =#
    #=     @test idword == "DAS/TEST" =#
    #=     @test ifname == "ex_dasac" =#
    #=     @test nresvr == 0 =#
    #=     @test nresvc == 0 =#
    #=     @test ncomr  == 140 =#
    #=     @test ncomc  == 18 =#
    #=     # close the das file =#
    #=     dascls(handle) =#
    #=     ############################################### =#
    #=     # now reload the kernel and delete the commnets =#
    #=     handle = dasopw(daspath) =#
    #=     @test handle is not None =#
    #=     # delete the comments =#
    #=     dasdc(handle) =#
    #=     # close the das file =#
    #=     dascls(handle) =#
    #=     # open again for reading =#
    #=     handle = dasopr(daspath) =#
    #=     @test handle is not None =#
    #=     # extract out the comments, hopefully nothing =#
    #=     n, comments, done = dasec(handle) =#
    #=     @test n == 0 =#
    #=     # close it again =#
    #=     dascls(handle) =#
    #=     # done, so clean up =#
    #=     if exists(daspath): =#
    #=         os.remove(daspath) # pragma: no cover =#
    #=     kclear() =#
    #= @testset "dasopw_dascls_dasopr" begin =#
    #=     kclear() =#
    #=     daspath = os.path.join(cwd, "ex_das.das") =#
    #=     if exists(daspath): =#
    #=         os.remove(daspath) # pragma: no cover =#
    #=     handle = dasonw(daspath, "TEST", daspath, 0) =#
    #=     @test handle is not None =#
    #=     dascls(handle) =#
    #=     handle = dasopw(daspath) =#
    #=     @test handle is not None =#
    #=     dascls(handle) =#
    #=     handle = dasopr(daspath) =#
    #=     dascls(handle) =#
    #=     @test handle is not None =#
    #=     if exists(daspath): =#
    #=         os.remove(daspath) # pragma: no cover =#
    #=     kclear() =#
    #= @testset "dcyldr" begin =#
    #=     output = dcyldr(1.0, 0.0, 0.0) =#
    #=     expected = [[1.0, 0.0, 0.0], =#
    #=                 [0.0, 1.0, 0.0], =#
    #=                 [0.0, 0.0, 1.0]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #= @testset "deltet" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     UTC_1997 = "Jan 1 1997" =#
    #=     UTC_2004 = "Jan 1 2004" =#
    #=     et_1997 = str2et(UTC_1997) =#
    #=     et_2004 = str2et(UTC_2004) =#
    #=     delt_1997 = deltet(et_1997, "ET") =#
    #=     delt_2004 = deltet(et_2004, "ET") =#
    #=     @test_almost_equal(delt_1997, 62.1839353, decimal=6) =#
    #=     @test_almost_equal(delt_2004, 64.1839116, decimal=6) =#
    #=     kclear() =#
    #= @testset "det" begin =#
    #=     m1 = np.array([[5.0, -2.0, 1.0], [0.0, 3.0, -1.0], [2.0, 0.0, 7.0]]) =#
    #=     expected = 103 =#
    #=     @test det(m1) == expected =#
    #= @testset "dgeodr" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     size, radii = bodvrd("EARTH", "RADII", 3) =#
    #=     flat = (radii[0] - radii[2]) / radii[0] =#
    #=     lon = 118.0 * rpd() =#
    #=     lat = 32.0 * rpd() =#
    #=     alt = 0.0 =#
    #=     kclear() =#
    #=     rec = latrec(lon, lat, alt) =#
    #=     output = dgeodr(rec[0], rec[1], rec[2], radii[0], flat) =#
    #=     expected = [[-0.25730624850202866, 0.41177607401581356, 0.0], =#
    #=                 [-0.019818463887750683, -0.012383950685377182, 0.0011247386599188864], =#
    #=                 [0.040768073853231314, 0.02547471988726025, 0.9988438330394612]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #= @testset "diags2" begin =#
    #=     mat = [[1.0, 4.0], [4.0, -5.0]] =#
    #=     diag, rot = diags2(mat) =#
    #=     expectedDiag = [[3.0, 0.0], [0.0, -7.0]] =#
    #=     expectedRot = [[0.89442719, -0.44721360], [0.44721360, 0.89442719]] =#
    #=     @test_array_almost_equal(diag, expectedDiag) =#
    #=     @test_array_almost_equal(rot, expectedRot) =#
    #= @testset "diff" begin =#
    #=     # SPICEINT_CELL =#
    #=     testCellOne = cell_int(8) =#
    #=     testCellTwo = cell_int(8) =#
    #=     insrti(1, testCellOne) =#
    #=     insrti(2, testCellOne) =#
    #=     insrti(3, testCellOne) =#
    #=     insrti(2, testCellTwo) =#
    #=     insrti(3, testCellTwo) =#
    #=     insrti(4, testCellTwo) =#
    #=     outCell = diff(testCellOne, testCellTwo) =#
    #=     @test [x for x in outCell] == [1] =#
    #=     outCell = diff(testCellTwo, testCellOne) =#
    #=     @test [x for x in outCell] == [4] =#
    #=     # SPICECHAR_CELL =#
    #=     testCellOne = cell_char(8, 8) =#
    #=     testCellTwo = cell_char(8, 8) =#
    #=     insrtc("1", testCellOne) =#
    #=     insrtc("2", testCellOne) =#
    #=     insrtc("3", testCellOne) =#
    #=     insrtc("2", testCellTwo) =#
    #=     insrtc("3", testCellTwo) =#
    #=     insrtc("4", testCellTwo) =#
    #=     outCell = diff(testCellOne, testCellTwo) =#
    #=     @test [x for x in outCell] == ["1"] =#
    #=     outCell = diff(testCellTwo, testCellOne) =#
    #=     @test [x for x in outCell] == ["4"] =#
    #=     # SPICEDOUBLE_CELL =#
    #=     testCellOne = cell_double(8) =#
    #=     testCellTwo = cell_double(8) =#
    #=     insrtd(1.0, testCellOne) =#
    #=     insrtd(2.0, testCellOne) =#
    #=     insrtd(3.0, testCellOne) =#
    #=     insrtd(2.0, testCellTwo) =#
    #=     insrtd(3.0, testCellTwo) =#
    #=     insrtd(4.0, testCellTwo) =#
    #=     outCell = diff(testCellOne, testCellTwo) =#
    #=     @test [x for x in outCell] == [1.0] =#
    #=     outCell = diff(testCellTwo, testCellOne) =#
    #=     @test [x for x in outCell] == [4.0] =#
    #=     # SPICEBOOLEAN_CELL; dtype=4 =#
    #=     testCellOne = cell_bool(9) =#
    #=     testCellTwo = cell_bool(9) =#
    #=     with pytest.raises(NotImplementedError): =#
    #=         diff(testCellOne, testCellTwo) =#
    #= @testset "dlabfs" begin =#
    #=     kclear() =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     current = dlabfs(handle) =#
    #=     @test current is not None =#
    #=     @test current.dsize == 1300 =#
    #=     with pytest.raises(stypes.SpiceyError): =#
    #=         next = dlafns(handle, current) =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dlabbs" begin =#
    #=     kclear() =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     current = dlabbs(handle) =#
    #=     @test current is not None =#
    #=     @test current.dsize == 1300 =#
    #=     with pytest.raises(stypes.SpiceyError): =#
    #=         prev = dlafps(handle, current) =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dlatdr" begin =#
    #=     output = dlatdr(1.0, 0.0, 0.0) =#
    #=     expected = [[1.0, 0.0, 0.0], =#
    #=                 [0.0, 1.0, 0.0], =#
    #=                 [0.0, 0.0, 1.0]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #= @testset "dp2hx" begin =#
    #=     @test dp2hx(2.0e-9) == "89705F4136B4A8^-7" =#
    #=     @test dp2hx(1.0) == "1^1" =#
    #=     @test dp2hx(-1.0) == "-1^1" =#
    #=     @test dp2hx(1024.0) == "4^3" =#
    #=     @test dp2hx(-1024.0) == "-4^3" =#
    #=     @test dp2hx(521707.0) == "7F5EB^5" =#
    #=     @test dp2hx(27.0) == "1B^2" =#
    #=     @test dp2hx(0.0) == "0^0" =#
    #= @testset "dpgrdr" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     n, radii = bodvrd("MARS", "RADII", 3) =#
    #=     re = radii[0] =#
    #=     rp = radii[2] =#
    #=     f = (re - rp) / re =#
    #=     output = dpgrdr("Mars", 90.0 * rpd(), 45 * rpd(), 300, re, f) =#
    #=     expected = [[0.25464790894703276, -0.5092958178940655, -0.0], =#
    #=                 [-0.002629849831988239, -0.0013149249159941194, 1.5182979166821334e-05], =#
    #=                 [0.004618598844358383, 0.0023092994221791917, 0.9999866677515724]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #=     kclear() =#
    #= @testset "dpmax" begin =#
    #=     @test dpmax() >= 1.0e37 =#
    #= @testset "dpmin" begin =#
    #=     @test dpmin() <= -1.0e37 =#
    #= @testset "dpr" begin =#
    #=     @test dpr() == 180.0 / np.arccos(-1.0) =#
    #= @testset "drdcyl" begin =#
    #=     output = drdcyl(1.0, np.deg2rad(180.0), 1.0) =#
    #=     expected = [[-1.0, 0.0, 0.0], =#
    #=                 [0.0, -1.0, 0.0], =#
    #=                 [0.0, 0.0, 1.0]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #= @testset "drdgeo" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     size, radii = bodvrd("EARTH", "RADII", 3) =#
    #=     flat = (radii[0] - radii[2]) / radii[0] =#
    #=     lon = 118.0 * rpd() =#
    #=     lat = 32.0 * rpd() =#
    #=     alt = 0.0 =#
    #=     kclear() =#
    #=     output = drdgeo(lon, lat, alt, radii[0], flat) =#
    #=     expected = [[-4780.329375996193, 1580.5982261675397, -0.3981344650201568], =#
    #=                 [-2541.7462156656084, -2972.6729150327574, 0.7487820251299121], =#
    #=                 [0.0, 5387.9427815962445, 0.5299192642332049]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #= @testset "drdlat" begin =#
    #=     output = drdlat(1.0, 90.0 * rpd(), 0.0) =#
    #=     expected = [[0.0, -1.0, -0.0], =#
    #=                 [1.0, 0.0, -0.0], =#
    #=                 [0.0, 0.0, 1.0]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #= @testset "drdpgr" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     n, radii = bodvrd("MARS", "RADII", 3) =#
    #=     re = radii[0] =#
    #=     rp = radii[2] =#
    #=     f = (re - rp) / re =#
    #=     output = drdpgr("Mars", 90.0 * rpd(), 45 * rpd(), 300, re, f) =#
    #=     expected = [[-2620.6789148181783, 0.0, 0.0], =#
    #=                 [0.0, 2606.460468253308, -0.7071067811865476], =#
    #=                 [-0.0, 2606.460468253308, 0.7071067811865475]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #=     kclear() =#
    #= @testset "drdsph" begin =#
    #=     output = drdsph(1.0, np.pi / 2, np.pi) =#
    #=     expected = [[-1.0, 0.0, 0.0], =#
    #=                 [0.0, 0.0, -1.0], =#
    #=                 [0.0, -1.0, 0.0]] =#
    #=     @test_array_almost_equal(output, expected) =#
    #= @testset "dskgtl_dskstl" begin =#
    #=     SPICE_DSK_KEYXFR = 1 =#
    #=     @test dskgtl(SPICE_DSK_KEYXFR) == pytest.approx(1.0e-10) =#
    #=     dskstl(SPICE_DSK_KEYXFR, 1.0e-8) =#
    #=     @test dskgtl(SPICE_DSK_KEYXFR) == pytest.approx(1.0e-8) =#
    #=     dskstl(SPICE_DSK_KEYXFR, 1.0e-10) =#
    #=     @test dskgtl(SPICE_DSK_KEYXFR) == pytest.approx(1.0e-10) =#
    #= @testset "dskobj_dsksrf" begin =#
    #=     reset() =#
    #=     kclear() =#
    #=     bodyids = dskobj(ExtraKernels.phobosDsk) =#
    #=     @test 401 in bodyids =#
    #=     srfids = dsksrf(ExtraKernels.phobosDsk, 401) =#
    #=     @test 401 in srfids =#
    #=     kclear() =#
    #=     reset() =#
    #= @testset "dskopn_dskcls" begin =#
    #=     kclear() =#
    #=     dskpath = os.path.join(cwd, "TEST.dsk") =#
    #=     if exists(dskpath): =#
    #=         os.remove(dskpath) # pragma: no cover =#
    #=     handle = dskopn(dskpath, "TEST.DSK/NAIF/NJB/20-OCT-2006/14:37:00", 0) =#
    #=     @test handle is not None =#
    #=     dskcls(handle) =#
    #=     if exists(dskpath): =#
    #=         os.remove(dskpath) # pragma: no cover =#
    #=     kclear() =#
    #= @testset "dskb02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # test dskb02 =#
    #=     nv, nump, nvxtot, vtxbds, voxsiz, voxori, vgrext, cgscal, vtxnpl, voxnpt, voxnpl = dskb02(handle, dladsc) =#
    #=     # test results =#
    #=     @test nv == 422 =#
    #=     @test nump == 840 =#
    #=     @test nvxtot == 8232 =#
    #=     @test cgscal == 7 =#
    #=     @test vtxnpl == 0 =#
    #=     @test voxnpt == 2744 =#
    #=     @test voxnpl == 3257 =#
    #=     @test voxsiz == pytest.approx(3.320691339664286) =#
    #=     # cleanup =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dskd02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # Fetch the vertex =#
    #=     values = dskd02(handle, dladsc, 19, 0, 3) =#
    #=     @test len(values) > 0 =#
    #=     @test_almost_equal(values, [5.12656957900699912362e-16,  -0.00000000000000000000e+00, =#
    #=                                      -8.37260000000000026432e+00]) =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dskgd" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get dskdsc for target radius =#
    #=     dskdsc = dskgd(handle, dladsc) =#
    #=     # test results =#
    #=     @test dskdsc.surfce == 401 =#
    #=     @test dskdsc.center == 401 =#
    #=     @test dskdsc.dclass == 1 =#
    #=     @test dskdsc.dtype  == 2 =#
    #=     @test dskdsc.frmcde == 10021 =#
    #=     @test dskdsc.corsys == 1 =#
    #=     @test_almost_equal(dskdsc.corpar, np.zeros(10)) =#
    #=     @test dskdsc.co1min == pytest.approx(-3.141593) =#
    #=     @test dskdsc.co1max == pytest.approx(3.141593) =#
    #=     @test dskdsc.co2min == pytest.approx(-1.570796) =#
    #=     @test dskdsc.co2max == pytest.approx(1.570796) =#
    #=     @test dskdsc.co3min == pytest.approx(8.181895873588292) =#
    #=     @test dskdsc.co3max == pytest.approx(13.89340000000111) =#
    #=     @test dskdsc.start  == pytest.approx(-1577879958.816059) =#
    #=     @test dskdsc.stop   == pytest.approx(1577880066.183913) =#
    #=     # cleanup =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dski02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # Find the number of plates in the model =#
    #=     # SPICE_DSK02_KWNP == 2 =#
    #=     num_plates = dski02(handle, dladsc, 2, 0, 3) =#
    #=     @test len(num_plates) > 0 =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dskn02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get the normal vector for first plate =#
    #=     normal = dskn02(handle, dladsc, 1) =#
    #=     @test_almost_equal(normal, [0.20813166897151150203,  0.07187012861854354118, =#
    #=                                      -0.97545676120650637309]) =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dskp02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get the first plate =#
    #=     plates = dskp02(handle, dladsc, 1, 2) =#
    #=     @test_almost_equal(plates[0], [1, 9, 2]) =#
    #=     @test_almost_equal(plates[1], [1, 2, 3]) =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dskv02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # read the vertices =#
    #=     vrtces = dskv02(handle, dladsc, 1, 1) =#
    #=     @test_almost_equal(vrtces[0], [5.12656957900699912362e-16,  -0.00000000000000000000e+00, =#
    #=                                         -8.37260000000000026432e+00]) =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dskw02_dskrb2_dskmi2" begin =#
    #=     kclear() =#
    #=     dskpath = os.path.join(cwd, "TESTdskw02.dsk") =#
    #=     if exists(dskpath): =#
    #=         os.remove(dskpath)  # pragma: no cover =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # declare some variables =#
    #=     finscl = 5.0 =#
    #=     corscl = 4 =#
    #=     center = 401 =#
    #=     surfid = 1 =#
    #=     dclass = 2 =#
    #=     frame = "IAU_PHOBOS" =#
    #=     first = -50 * jyear() =#
    #=     last  =  50 * jyear() =#
    #=     # stuff from spicedsk.h =#
    #=     SPICE_DSK02_MAXVRT = 16000002 // 128 # divide to lower memory usage =#
    #=     SPICE_DSK02_MAXPLT = 2 * (SPICE_DSK02_MAXVRT - 2) =#
    #=     SPICE_DSK02_MAXVXP = SPICE_DSK02_MAXPLT // 2 =#
    #=     SPICE_DSK02_MAXCEL = 60000000 // 128 # divide to lower memory usage =#
    #=     SPICE_DSK02_MXNVLS = SPICE_DSK02_MAXCEL + (SPICE_DSK02_MAXVXP // 2) =#
    #=     SPICE_DSK02_MAXCGR = 100000   // 128 # divide to lower memory usage =#
    #=     SPICE_DSK02_IXIFIX = SPICE_DSK02_MAXCGR + 7 =#
    #=     SPICE_DSK02_MAXNPV = 3 * (SPICE_DSK02_MAXPLT // 2) + 1 =#
    #=     SPICE_DSK02_SPAISZ = SPICE_DSK02_IXIFIX + SPICE_DSK02_MAXVXP + SPICE_DSK02_MXNVLS + SPICE_DSK02_MAXVRT + SPICE_DSK02_MAXNPV =#
    #=     worksz = SPICE_DSK02_MAXCEL =#
    #=     voxpsz = SPICE_DSK02_MAXVXP =#
    #=     voxlsz = SPICE_DSK02_MXNVLS =#
    #=     spaisz = SPICE_DSK02_SPAISZ =#
    #=     # get verts, number from dskb02 test =#
    #=     vrtces = dskv02(handle, dladsc, 1, 422) =#
    #=     # get plates, number from dskb02 test =#
    #=     plates = dskp02(handle, dladsc, 1, 840) =#
    #=     # close the input kernel =#
    #=     dskcls(handle) =#
    #=     kclear() =#
    #=     # open new dsk file =#
    #=     handle = dskopn(dskpath, "TESTdskw02.dsk/AA/29-SEP-2017", 0) =#
    #=     # create spatial index =#
    #=     spaixd, spaixi = dskmi2(vrtces, plates, finscl, corscl, worksz, voxpsz, voxlsz, False, spaisz) =#
    #=     # do stuff =#
    #=     corsys = 1 =#
    #=     mncor1 = -pi() =#
    #=     mxcor1 = pi() =#
    #=     mncor2 = -pi() / 2 =#
    #=     mxcor2 = pi() / 2 =#
    #=     # Compute plate model radius bounds. =#
    #=     corpar = np.zeros(10) =#
    #=     mncor3, mxcor3 = dskrb2(vrtces, plates, corsys, corpar) =#
    #=     # Write the segment to the file =#
    #=     dskw02(handle, center, surfid, dclass, frame, corsys, corpar, =#
    #=                  mncor1, mxcor1, mncor2, mxcor2, mncor3, mxcor3, first, =#
    #=                  last, vrtces, plates, spaixd, spaixi) =#
    #=     # Close the dsk file =#
    #=     dskcls(handle, optmiz=True) =#
    #=     # cleanup =#
    #=     if exists(dskpath): =#
    #=         os.remove(dskpath)  # pragma: no cover =#
    #=     kclear() =#
    #= @testset "dskx02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get dskdsc for target radius =#
    #=     dskdsc = dskgd(handle, dladsc) =#
    #=     r = 2.0 * dskdsc.co3max =#
    #=     # Produce a ray vertex =#
    #=     vertex = latrec(r, 0.0, 0.0) =#
    #=     raydir = vminus(vertex) =#
    #=     plid, xpt, found = dskx02(handle, dladsc, vertex, raydir) =#
    #=     # test results =#
    #=     @test found =#
    #=     @test plid == 421 =#
    #=     @test_almost_equal(xpt, [12.36679999999999957083, 0.0, 0.0]) =#
    #=     # cleanup =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dskxsi" begin =#
    #=     kclear() =#
    #=     # load kernels =#
    #=     furnsh(ExtraKernels.phobosDsk) =#
    #=     # get handle =#
    #=     dsk1, filtyp, source, handle = kdata(0, "DSK", 256, 5, 256) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get dskdsc for target radius =#
    #=     dskdsc = dskgd(handle, dladsc) =#
    #=     target = bodc2n(dskdsc.center) =#
    #=     fixref = frmnam(dskdsc.frmcde) =#
    #=     r = 1.0e10 =#
    #=     vertex = latrec(r, 0.0, 0.0) =#
    #=     raydir = vminus(vertex) =#
    #=     srflst = [dskdsc.surfce] =#
    #=     # call dskxsi =#
    #=     xpt, handle, dladsc2, dskdsc2, dc, ic  = dskxsi(False, target, srflst, 0.0, fixref, vertex, raydir) =#
    #=     # check output =#
    #=     @test handle is not None =#
    #=     @test ic[0] == 420 =#
    #=     @test dc[0] == pytest.approx(0.0) =#
    #=     @test_almost_equal(xpt, [12.36679999999999957083, 0.0, 0.0]) =#
    #=     kclear() =#
    #= @testset "dskxv" begin =#
    #=     kclear() =#
    #=     # load kernels =#
    #=     furnsh(ExtraKernels.phobosDsk) =#
    #=     # get handle =#
    #=     dsk1, filtyp, source, handle = kdata(0, "DSK", 256, 5, 256) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get dskdsc for target radius =#
    #=     dskdsc = dskgd(handle, dladsc) =#
    #=     target = bodc2n(dskdsc.center) =#
    #=     fixref = frmnam(dskdsc.frmcde) =#
    #=     r = 1.0e10 =#
    #=     vertex = latrec(r, 0.0, 0.0) =#
    #=     raydir = vminus(vertex) =#
    #=     srflst = [dskdsc.surfce] =#
    #=     # call dskxsi =#
    #=     xpt, foundarray = dskxv(False, target, srflst, 0.0, fixref, [vertex], [raydir]) =#
    #=     # check output =#
    #=     @test len(xpt) == 1 =#
    #=     @test len(foundarray) == 1 =#
    #=     @test foundarray[0] =#
    #=     @test_almost_equal(xpt[0], [12.36679999999999957083, 0.0, 0.0]) =#
    #=     kclear() =#
    #= @testset "dskxv_2" begin =#
    #=     kclear() =#
    #=     # load kernels =#
    #=     furnsh(ExtraKernels.phobosDsk) =#
    #=     # get handle =#
    #=     dsk1, filtyp, source, handle = kdata(0, "DSK", 256, 5, 256) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get dskdsc for target radius =#
    #=     dskdsc = dskgd(handle, dladsc) =#
    #=     target = bodc2n(dskdsc.center) =#
    #=     fixref = frmnam(dskdsc.frmcde) =#
    #=     r = 1.0e10 =#
    #=     polmrg = 0.5 =#
    #=     latstp = 1.0 =#
    #=     lonstp = 2.0 =#
    #=     nhits = 0 =#
    #=     nderr = 0 =#
    #=     lon = -180.0 =#
    #=     lat = 90.0 =#
    #=     nlstep = 0 =#
    #=     nrays = 0 =#
    #=     verticies = [] =#
    #=     raydirs = [] =#
    #=     while lon < 180.0: =#
    #=         while nlstep <= 180: =#
    #=             if lon == 180.0: =#
    #=                 lat = 90.0 - nlstep*latstp =#
    #=             else: =#
    #=                 if nlstep == 0: =#
    #=                     lat = 90.0 - polmrg =#
    #=                 elif nlstep == 180: =#
    #=                     lat = -90.0 + polmrg =#
    #=                 else: =#
    #=                     lat = 90.0 - nlstep*latstp =#
    #=                 vertex = latrec(r, np.radians(lon), np.radians(lat)) =#
    #=                 raydir = vminus(vertex) =#
    #=                 verticies.append(vertex) =#
    #=                 raydirs.append(raydir) =#
    #=                 nrays += 1 =#
    #=                 nlstep += 1 =#
    #=         lon += lonstp =#
    #=         lat = 90.0 =#
    #=         nlstep = 0 =#
    #=     srflst = [dskdsc.surfce] =#
    #=     # call dskxsi =#
    #=     xpt, foundarray = dskxv(False, target, srflst, 0.0, fixref, verticies, raydirs) =#
    #=     # check output =#
    #=     @test len(xpt) == 32580 =#
    #=     @test len(foundarray) == 32580 =#
    #=     @test foundarray.all() =#
    #=     kclear() =#
    #= @testset "dskz02" begin =#
    #=     kclear() =#
    #=     # open the dsk file =#
    #=     handle = dasopr(ExtraKernels.phobosDsk) =#
    #=     # get the dladsc from the file =#
    #=     dladsc = dlabfs(handle) =#
    #=     # get vertex and plate counts =#
    #=     nv, nplates = dskz02(handle, dladsc) =#
    #=     @test nv > 0 =#
    #=     @test nplates > 0 =#
    #=     dascls(handle) =#
    #=     kclear() =#
    #= @testset "dsphdr" begin =#
    #=     output = dsphdr(-1.0, 0.0, 0.0) =#
    #=     expected = [[-1.0, 0.0, 0.0], =#
    #=                 [0.0, 0.0, -1.0], =#
    #=                 [0.0, -1.0, 0.0]] =#
    #=     @test_array_almost_equal(output, expected) =#
    @testset "dtpool" begin
        try
            lmpoolNames = ["DELTET/DELTA_T_A", "DELTET/K", "DELTET/EB",
                           "DELTET/M", "DELTET/DELTA_AT"]
            lmpoolLens = [1, 1, 1, 2, 46]
            textbuf = ["DELTET/DELTA_T_A = 32.184",
                       "DELTET/K         = 1.657D-3",
                       "DELTET/EB        = 1.671D-2",
                       "DELTET/M         = ( 6.239996 1.99096871D-7 )",
                       "DELTET/DELTA_AT  = ( 10, @1972-JAN-1",
                       "                     11, @1972-JUL-1",
                       "                     12, @1973-JAN-1",
                       "                     13, @1974-JAN-1",
                       "                     14, @1975-JAN-1",
                       "                     15, @1976-JAN-1",
                       "                     16, @1977-JAN-1",
                       "                     17, @1978-JAN-1",
                       "                     18, @1979-JAN-1",
                       "                     19, @1980-JAN-1",
                       "                     20, @1981-JUL-1",
                       "                     21, @1982-JUL-1",
                       "                     22, @1983-JUL-1",
                       "                     23, @1985-JUL-1",
                       "                     24, @1988-JAN-1",
                       "                     25, @1990-JAN-1",
                       "                     26, @1991-JAN-1",
                       "                     27, @1992-JUL-1",
                       "                     28, @1993-JUL-1",
                       "                     29, @1994-JUL-1",
                       "                     30, @1996-JAN-1",
                       "                     31, @1997-JUL-1",
                       "                     32, @1999-JAN-1 )"]
            lmpool(textbuf)
            for (var, expectLen) in zip(lmpoolNames, lmpoolLens)
                n, vartype = dtpool(var)
                @test expectLen == n
                @test vartype == :N
            end
        finally
            kclear()
        end
    end
    #= @testset "ducrss" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     z_earth = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0] =#
    #=     et = str2et("Jan 1, 2009") =#
    #=     trans = sxform("IAU_EARTH", "J2000", et) =#
    #=     z_j2000 = np.dot(np.array(trans), np.array(z_earth)) =#
    #=     state, ltime = spkezr("Sun", et, "J2000", "LT+S", "Earth") =#
    #=     z_new = ducrss(state, z_j2000) =#
    #=     z_expected = [-0.9798625180326394, -0.1996715076226282, 0.0008572038510904833, =#
    #=                   4.453114222872359e-08, -2.1853106962531453e-07, -3.6140021238340607e-11] =#
    #=     @test_array_almost_equal(z_new, z_expected) =#
    #=     kclear() =#
    #= @testset "dvcrss" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     z_earth = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0] =#
    #=     et = str2et("Jan 1, 2009") =#
    #=     trans = sxform("IAU_EARTH", "J2000", et) =#
    #=     z_j2000 = np.dot(np.array(trans), np.array(z_earth)) =#
    #=     state, ltime = spkezr("Sun", et, "J2000", "LT+S", "Earth") =#
    #=     z = dvcrss(state, z_j2000) =#
    #=     kclear() =#
    #=     expected = [-1.32672690582546606660e+08,  -2.70353812480484284461e+07, =#
    #=                 1.16064793997540167766e+05,   5.12510726479525757782e+00, =#
    #=                 -2.97732415336074147660e+01,  -4.10216496370272454969e-03] =#
    #=     @test_almost_equal(z, expected) =#
    #= @testset "dvdot" begin =#
    #=     @test dvdot([1.0, 0.0, 1.0, 0.0, 1.0, 0.0], [0.0, 1.0, 0.0, 1.0, 0.0, 1.0]) == 3.0 =#
    #= @testset "dvhat" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     et = str2et("Jan 1, 2009") =#
    #=     state, ltime = spkezr("Sun", et, "J2000", "LT+S", "Earth") =#
    #=     x_new = dvhat(state) =#
    #=     kclear() =#
    #=     expected = [0.1834466376334262, -0.9019196633282948, -0.39100927360200305, =#
    #=                 2.0244976750658316e-07, 3.4660106111045445e-08, 1.5033141925267006e-08] =#
    #=     @test_array_almost_equal(expected, x_new) =#
    #= @testset "dvnorm" begin =#
    #=     mag = np.array([-4.0, 4, 12]) =#
    #=     x = np.array([1.0, np.sqrt(2.0), np.sqrt(3.0)]) =#
    #=     s1 = np.array([x * 10.0 ** mag[0], x]).flatten() =#
    #=     s2 = np.array([x * 10.0 ** mag[1], -x]).flatten() =#
    #=     s3 = np.array([[0.0, 0.0, 0.0], x * 10 ** mag[2]]).flatten() =#
    #=     @test_approx_equal(dvnorm(s1), 2.4494897) =#
    #=     @test_approx_equal(dvnorm(s2), -2.4494897) =#
    #=     @test_approx_equal(dvnorm(s3), 0.0) =#
    #= @testset "dvpool" begin =#
    #=     kclear() =#
    #=     pdpool("DTEST_VAL", [3.1415, 186.0, 282.397]) =#
    #=     @test expool("DTEST_VAL") =#
    #=     dvpool("DTEST_VAL") =#
    #=     @test not expool("DTEST_VAL") =#
    #=     clpool() =#
    #=     kclear() =#
    #= @testset "dvsep" begin =#
    #=     kclear() =#
    #=     furnsh(CoreKernels.testMetaKernel) =#
    #=     et = str2et("JAN 1 2009") =#
    #=     state_e, eltime = spkezr("EARTH", et, "J2000", "NONE", "SUN") =#
    #=     state_m, mltime = spkezr("MOON", et, "J2000", "NONE", "SUN") =#
    #=     dsept = dvsep(state_e, state_m) =#
    #=     @test_approx_equal(dsept, 3.8121194e-09) =#
    #=     kclear() =#
end
