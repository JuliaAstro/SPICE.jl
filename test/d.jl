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
            out = dafgs(2)
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
    @testset "dafps/dafrs" begin
        try
            dafpath = tempname()
            ifname = "Test CK type 1 segment created by cspice_ckw01"
            handle = ckopn(dafpath, ifname, 10)
            ckw01(handle, 1.1, 4.1, -77701, "J2000", "Test type 1 CK segment",
                  [1.1, 4.1], [[1.0, 1.0, 1.0, 1.0], [2.0, 2.0, 2.0, 2.0]],
                  [[0.0, 0.0, 1.0], [0.0, 0.0, 2.0]])
            ckcls(handle)
            kclear()

            handle = dafopw(dafpath)
            dafbfs(handle)
            found = daffna()
            @test found
            out = dafgs(124)
            dc, ic = dafus(out, 2, 6)
            ic[1] = -1999
            ic[2] = -2999
            summ = dafps(dc, ic)
            dafrs(summ)
            dafcls(handle)
            kclear()

            handle = dafopr(dafpath)
            dafbfs(handle)
            found = daffna()
            @test found
            out = dafgs(124)
            dc, ic = dafus(out, 2, 6)
            @test ic[1] == -1999
            @test ic[2] == -2999
        finally
            kclear()
        end
    end
    @testset "dasac/dascl/dasopr/dasopw/dasec/dasdc" begin
        try
            daspath = tempname()
            handle = dskopn(daspath, "ex_dasac", 140)
            dasac(handle, ["spice", "naif", "julia"])
            dascls(handle)
            kclear()

            handle = dasopr(daspath)
            @test dashfn(handle) == daspath
            comments = dasec(handle, bufsiz=3)
            @test length(comments) == 3
            @test comments  == ["spice", "naif", "julia"]
            dascls(handle)

            handle = dasopr(daspath)
            idword, ifname, nresvr, nresvc, ncomr, ncomc = dasrfr(handle)
            @test idword == "DAS/DSK"
            @test ifname == "ex_dasac"
            @test nresvr == 0
            @test nresvc == 0
            @test ncomr  == 1
            @test ncomc  == 17
            dascls(handle)

            handle = dasopw(daspath)
            dasdc(handle)
            dascls(handle)
            handle = dasopr(daspath)
            comments = dasec(handle)
            @test comments == []
            dascls(handle)
        finally
            kclear()
        end
    end
    @testset "dcyldr" begin
        output = dcyldr(1.0, 0.0, 0.0)
        expected = [1.0 0.0 0.0;
                    0.0 1.0 0.0;
                    0.0 0.0 1.0]
        @test output ≈ expected
        @test_throws SpiceError dcyldr(0.0, 0.0, 1.0)
    end
    @testset "deltet" begin
        try
            furnsh(path(CORE, :lsk))
            UTC_1997 = "Jan 1 1997"
            UTC_2004 = "Jan 1 2004"
            et_1997 = str2et(UTC_1997)
            et_2004 = str2et(UTC_2004)
            delt_1997 = deltet(et_1997, "ET")
            delt_2004 = deltet(et_2004, "ET")
            @test delt_1997 ≈ 62.1839353
            @test delt_2004 ≈ 64.1839116
        finally
            kclear()
        end
    end
    @testset "dgeodr" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("EARTH", "RADII", 3)
            flat = (radii[1] - radii[3]) / radii[1]
            lon = deg2rad(118.0)
            lat = deg2rad(32.0)
            alt = 0.0
            rec = latrec(lon, lat, alt)
            output = dgeodr(rec[1], rec[2], rec[3], radii[1], flat)
            expected = [-0.25730624850202866 0.41177607401581356 0.0;
                        -0.019818463887750683 -0.012383950685377182 0.0011247386599188864;
                        0.040768073853231314 0.02547471988726025 0.9988438330394612]
            @test output ≈ expected
        finally
            kclear()
        end
    end
    @testset "diags2" begin
        mat = [1.0 4.0; 4.0 -5.0]
        diag, rot = diags2(mat)
        expected_diag = [3.0 0.0; 0.0 -7.0]
        expected_rot = [0.89442719 -0.44721360; 0.44721360 0.89442719]
        @test diag ≈ expected_diag
        @test rot ≈ expected_rot
    end
    @testset "diff" begin
        cell1 = SpiceIntCell(8)
        cell2 = SpiceIntCell(8)
        insrti!(cell1, 1)
        insrti!(cell1, 2)
        insrti!(cell1, 3)
        insrti!(cell2, 2)
        insrti!(cell2, 3)
        insrti!(cell2, 4)
        out = diff(cell1, cell2)
        @test out == [1]
        out = diff(cell2, cell1)
        @test out == [4]

        cell1 = SpiceCharCell(8, 8)
        cell2 = SpiceCharCell(8, 8)
        insrtc!(cell1, "1")
        insrtc!(cell1, "2")
        insrtc!(cell1, "3")
        insrtc!(cell2, "2")
        insrtc!(cell2, "3")
        insrtc!(cell2, "4")
        out = diff(cell1, cell2)
        @test out == ["1"]
        out = diff(cell2, cell1)
        @test out == ["4"]

        cell1 = SpiceDoubleCell(8)
        cell2 = SpiceDoubleCell(8)
        insrtd!(cell1, 1.0)
        insrtd!(cell1, 2.0)
        insrtd!(cell1, 3.0)
        insrtd!(cell2, 2.0)
        insrtd!(cell2, 3.0)
        insrtd!(cell2, 4.0)
        out = diff(cell1, cell2)
        @test out == [1.0]
        out = diff(cell2, cell1)
        @test out == [4.0]
    end
    @testset "dlabfs" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            current = dlabfs(handle)
            @test current.dsize == 1300
            @test dlafns(handle, current) === nothing
            dascls(handle)
        finally
            kclear()
        end
    end
    @testset "dlabbs" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            current = dlabbs(handle)
            @test current.dsize == 1300
            @test dlafps(handle, current) === nothing
            dascls(handle)
        finally
            kclear()
        end
    end
    @testset "dlatdr" begin
        output = dlatdr(1.0, 0.0, 0.0)
        expected = [1.0 0.0 0.0;
                    0.0 1.0 0.0;
                    0.0 0.0 1.0]
        @test output ≈ expected
    end
    @testset "dp2hx" begin
        @test dp2hx(2.0e-9) == "89705F4136B4A8^-7"
        @test dp2hx(1.0) == "1^1"
        @test dp2hx(-1.0) == "-1^1"
        @test dp2hx(1024.0) == "4^3"
        @test dp2hx(-1024.0) == "-4^3"
        @test dp2hx(521707.0) == "7F5EB^5"
        @test dp2hx(27.0) == "1B^2"
        @test dp2hx(0.0) == "0^0"
    end
    @testset "dpgrdr" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("MARS", "RADII", 3)
            re = radii[1]
            rp = radii[3]
            f = (re - rp) / re
            output = dpgrdr("Mars", deg2rad(90.0), deg2rad(45.0), 300, re, f)
            expected = [0.25464790894703276 -0.5092958178940655 -0.0;
                        -0.002629849831988239 -0.0013149249159941194 1.5182979166821334e-05;
                        0.004618598844358383 0.0023092994221791917 0.9999866677515724]
            @test output ≈ expected
        finally
            kclear()
        end
    end
    @testset "dpmax" begin
        @test SPICE._dpmax() == prevfloat(typemax(Float64))
    end
    @testset "dpmin" begin
        @test SPICE._dpmin() == nextfloat(typemin(Float64))
    end
    @testset "dpr" begin
        @test SPICE._dpr() == rad2deg(1.0)
    end
    @testset "drdcyl" begin
        output = drdcyl(1.0, deg2rad(180.0), 1.0)
        expected = [-1.0 0.0 0.0;
                    0.0 -1.0 0.0;
                    0.0 0.0 1.0]
        @test output ≈ expected
    end
    @testset "drdgeo" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("EARTH", "RADII", 3)
            flat = (radii[1] - radii[3]) / radii[1]
            lon = deg2rad(118.0)
            lat = deg2rad(32.0)
            alt = 0.0
            output = drdgeo(lon, lat, alt, radii[1], flat)
            expected = [-4780.329375996193 1580.5982261675397 -0.3981344650201568;
                        -2541.7462156656084 -2972.6729150327574 0.7487820251299121;
                        0.0 5387.9427815962445 0.5299192642332049]
            @test output ≈ expected
        finally
            kclear()
        end
    end
    @testset "drdlat" begin
        output = drdlat(1.0, deg2rad(90.0), 0.0)
        expected = [0.0 -1.0 -0.0;
                    1.0 0.0 -0.0;
                    0.0 0.0 1.0]
        @test output ≈ expected
    end
    @testset "drdpgr" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("MARS", "RADII", 3)
            re = radii[1]
            rp = radii[3]
            f = (re - rp) / re
            output = drdpgr("MARS", deg2rad(90.0), deg2rad(45), 300, re, f)
            expected = [-2620.6789148181783 0.0 0.0;
                        0.0 2606.460468253308 -0.7071067811865476;
                        -0.0 2606.460468253308 0.7071067811865475]
            @test output ≈ expected
        finally
            kclear()
        end
    end
    @testset "drdsph" begin
        output = drdsph(1.0, π/2, π)
        expected = [-1.0 0.0 0.0;
                    0.0 0.0 -1.0;
                    0.0 -1.0 0.0]
        @test output ≈ expected
    end
    @testset "dskgtl/dskstl" begin
        SPICE_DSK_KEYXFR = 1
        @test dskgtl(SPICE_DSK_KEYXFR) ≈ 1.0e-10
        dskstl(SPICE_DSK_KEYXFR, 1.0e-8)
        @test dskgtl(SPICE_DSK_KEYXFR) ≈ 1.0e-8
        dskstl(SPICE_DSK_KEYXFR, 1.0e-10)
        @test dskgtl(SPICE_DSK_KEYXFR) ≈ 1.0e-10
    end
    @testset "dskobj/dsksrf" begin
        try
            bodyids = SpiceIntCell(100)
            dskobj!(bodyids, path(EXTRA, :phobos_dsk))
            @test 401 in bodyids
            srfids = SpiceIntCell(100)
            dsksrf!(srfids, path(EXTRA, :phobos_dsk), 401)
            @test 401 in srfids
        finally
            kclear()
        end
    end
    @testset "dskb02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            res = dskb02(handle, dladsc)
            nv, nump, nvxtot, vtxbds, voxsiz, voxori, vgrext, cgscal, vtxnpl, voxnpt, voxnpl = res
            @test nv == 422
            @test nump == 840
            @test nvxtot == 8232
            @test cgscal == 7
            @test vtxnpl == 0
            @test voxnpt == 2744
            @test voxnpl == 3257
            @test voxsiz ≈ 3.320691339664286
        finally
            kclear()
        end
    end
    @testset "dskd02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            values = dskd02(handle, dladsc, 19, 1, 3)
            expected = [5.12656957900699912362e-16,  -0.0, -8.37260000000000026432e+00]
            @test values ≈ expected
        finally
            kclear()
        end
    end
    @testset "dskgd" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            dskdsc = dskgd(handle, dladsc)
            @test dskdsc.surfce == 401
            @test dskdsc.center == 401
            @test dskdsc.dclass == 1
            @test dskdsc.dtype  == 2
            @test dskdsc.frmcde == 10021
            @test dskdsc.corsys == 1
            @test collect(dskdsc.corpar) ≈ zeros(10)
            @test dskdsc.co1min ≈ -3.141593 rtol=1e-6
            @test dskdsc.co1max ≈ 3.141593 rtol=1e-6
            @test dskdsc.co2min ≈ -1.570796 rtol=1e-6
            @test dskdsc.co2max ≈ 1.570796 rtol=1e-6
            @test dskdsc.co3min ≈ 8.181895873588292 rtol=1e-6
            @test dskdsc.co3max ≈ 13.89340000000111 rtol=1e-6
            @test dskdsc.start  ≈ -1577879958.816059 rtol=1e-6
            @test dskdsc.stop   ≈ 1577880066.183913 rtol=1e-6
        finally
            kclear()
        end
    end
    @testset "dski02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            plates = dski02(handle, dladsc, 2, 1, 3)
            @test length(plates) > 0
        finally
            kclear()
        end
    end
    @testset "dskn02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            normal = dskn02(handle, dladsc, 1)
            expected = [0.20813166897151150203,  0.07187012861854354118, -0.97545676120650637309]
            @test normal ≈ expected
        finally
            kclear()
        end
    end
    @testset "dskp02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            plates = dskp02(handle, dladsc, 2, 2)
            @test plates[1] == [1, 9, 2]
            @test plates[2] == [1, 2, 3]
        finally
            kclear()
        end
    end
    @testset "dskv02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            vrtces = dskv02(handle, dladsc, 2, 1)
            expected = [5.12656957900699912362e-16, -0.0, -8.37260000000000026432]
            @test vrtces[1] ≈ expected
        finally
            kclear()
        end
    end
    @testset "dskw02/dskrb2/dskmi2" begin
        try
            dskpath = tempname()
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            finscl = 5.0
            corscl = 4
            center = 401
            surfid = 1
            dclass = 2
            frame = "IAU_PHOBOS"
            first = -50 * jyear()
            last  =  50 * jyear()
            SPICE_DSK02_MAXVRT = 16000002 ÷ 128
            SPICE_DSK02_MAXPLT = 2 * (SPICE_DSK02_MAXVRT - 2)
            SPICE_DSK02_MAXVXP = SPICE_DSK02_MAXPLT ÷ 2
            SPICE_DSK02_MAXCEL = 60000000 ÷ 128
            SPICE_DSK02_MXNVLS = SPICE_DSK02_MAXCEL + (SPICE_DSK02_MAXVXP ÷ 2)
            SPICE_DSK02_MAXCGR = 100000 ÷ 128
            SPICE_DSK02_IXIFIX = SPICE_DSK02_MAXCGR + 7
            SPICE_DSK02_MAXNPV = 3 * (SPICE_DSK02_MAXPLT ÷ 2) + 1
            SPICE_DSK02_SPAISZ = (SPICE_DSK02_IXIFIX + SPICE_DSK02_MAXVXP + SPICE_DSK02_MXNVLS
                                  + SPICE_DSK02_MAXVRT + SPICE_DSK02_MAXNPV)
            worksz = SPICE_DSK02_MAXCEL
            voxpsz = SPICE_DSK02_MAXVXP
            voxlsz = SPICE_DSK02_MXNVLS
            spaisz = SPICE_DSK02_SPAISZ
            vrtces = dskv02(handle, dladsc, 2, 422)
            plates = dskp02(handle, dladsc, 2, 840)
            dskcls(handle)
            kclear()

            handle = dskopn(dskpath, "TESTdskw02.dsk/AA/29-SEP-2017", 0)
            spaixd, spaixi = dskmi2(vrtces, plates, finscl, corscl, worksz, voxpsz, voxlsz, false, spaisz)
            corsys = 1
            mncor1 = -π
            mxcor1 = π
            mncor2 = -π/2
            mxcor2 = π/2
            corpar = zeros(10)
            mncor3, mxcor3 = dskrb2(vrtces, plates, corsys, corpar)
            dskw02(handle, center, surfid, dclass, frame, corsys, corpar,
                   mncor1, mxcor1, mncor2, mxcor2, mncor3, mxcor3, first,
                   last, vrtces, plates, spaixd, spaixi)
            dskcls(handle, true)
        finally
            kclear()
        end
    end
    @testset "dskx02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            dskdsc = dskgd(handle, dladsc)
            r = 2.0 * dskdsc.co3max
            vertex = latrec(r, 0.0, 0.0)
            raydir = -vertex
            plid, xpt = dskx02(handle, dladsc, vertex, raydir)
            # TODO: The results of this function are inconsistent for different versions of SPICE
            @test_skip plid == 421
            @test xpt ≈ [12.36679999999999957083, 0.0, 0.0]
        finally
            kclear()
        end
    end
    @testset "dskxsi" begin
        try
            furnsh(path(EXTRA, :phobos_dsk))
            dsk1, filtyp, source, handle = kdata(1, "DSK")
            dladsc = dlabfs(handle)
            dskdsc = dskgd(handle, dladsc)
            target = bodc2n(dskdsc.center)
            fixref = frmnam(dskdsc.frmcde)
            r = 1.0e10
            vertex = latrec(r, 0.0, 0.0)
            raydir = -vertex
            srflst = [dskdsc.surfce]
            xpt, handle, dladsc2, dskdsc2, dc, ic  = dskxsi(false, target, srflst, 0.0,
                                                            fixref, vertex, raydir)
            # TODO: The results of this function are inconsistent for different versions of SPICE
            @test_skip ic[1] == 420
            @test dc[1] == 0.0
            @test xpt ≈ [12.36679999999999957083, 0.0, 0.0]
        finally
            kclear()
        end
    end
    @testset "dskxv" begin
        try
            furnsh(path(EXTRA, :phobos_dsk))
            dsk1, filtyp, source, handle = kdata(1, "DSK")
            dladsc = dlabfs(handle)
            dskdsc = dskgd(handle, dladsc)
            target = bodc2n(dskdsc.center)
            fixref = frmnam(dskdsc.frmcde)
            r = 1.0e10
            vertex = latrec(r, 0.0, 0.0)
            raydir = -vertex
            srflst = [dskdsc.surfce]
            xpt, foundarray = dskxv(false, target, srflst, 0.0, fixref, [vertex], [raydir])
            @test length(xpt) == 1
            @test length(foundarray) == 1
            @test foundarray[1]
            @test xpt[1] ≈ [12.36679999999999957083, 0.0, 0.0]
        finally
            kclear()
        end
    end
    @testset "dskz02" begin
        try
            handle = dasopr(path(EXTRA, :phobos_dsk))
            dladsc = dlabfs(handle)
            nv, nplates = dskz02(handle, dladsc)
            @test nv > 0
            @test nplates > 0
        finally
            kclear()
        end
    end
    @testset "dsphdr" begin
        output = dsphdr(-1.0, 0.0, 0.0)
        expected = [-1.0 0.0 0.0;
                    0.0 0.0 -1.0;
                    0.0 -1.0 0.0]
        @test output ≈ expected
    end
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
    @testset "ducrss" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            z_earth = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0]
            et = str2et("Jan 1, 2009")
            trans = sxform("IAU_EARTH", "J2000", et)
            z_j2000 = trans * z_earth
            state, ltime = spkezr("SUN", et, "J2000", "LT+S", "EARTH")
            z_new = ducrss(state, z_j2000)
            z_expected = [-0.9798625180326394, -0.1996715076226282, 0.0008572038510904833,
                          4.453114222872359e-08, -2.1853106962531453e-07, -3.6140021238340607e-11]
            @test z_new ≈ z_expected
        finally
            kclear()
        end
    end
    @testset "dvcrss" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            z_earth = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0]
            et = str2et("Jan 1, 2009")
            trans = sxform("IAU_EARTH", "J2000", et)
            z_j2000 = trans * z_earth
            state, ltime = spkezr("SUN", et, "J2000", "LT+S", "EARTH")
            z = dvcrss(state, z_j2000)
            expected = [-1.32672690582546606660e+08,  -2.70353812480484284461e+07,
                        1.16064793997540167766e+05,   5.12510726479525757782e+00,
                        -2.97732415336074147660e+01,  -4.10216496370272454969e-03]
            @test z ≈ expected
        finally
            kclear()
        end
    end
    @testset "dvdot" begin
        @test dvdot([1.0, 0.0, 1.0, 0.0, 1.0, 0.0], [0.0, 1.0, 0.0, 1.0, 0.0, 1.0]) == 3.0
    end
    @testset "dvhat" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et = str2et("Jan 1, 2009")
            state, ltime = spkezr("Sun", et, "J2000", "LT+S", "Earth")
            x_new = dvhat(state)
            expected = [0.1834466376334262, -0.9019196633282948, -0.39100927360200305,
                        2.0244976750658316e-07, 3.4660106111045445e-08, 1.5033141925267006e-08]
            @test expected ≈ x_new
        finally
            kclear()
        end
    end
    @testset "dvnorm" begin
        mag = [-4.0, 4, 12]
        x = [1.0, sqrt(2.0), sqrt(3.0)]
        s1 = [x .* 10.0^mag[1]; x]
        s2 = [x .* 10.0^mag[2]; -x]
        s3 = [zeros(3); x .* 10.0^mag[3]]
        @test dvnorm(s1) ≈ 2.4494897 rtol=1e-6
        @test dvnorm(s2) ≈ -2.4494897 rtol=1e-6
        @test dvnorm(s3) ≈ 0.0
    end
    @testset "dvpool" begin
        try
            pdpool("DTEST_VAL", [3.1415, 186.0, 282.397])
            @test expool("DTEST_VAL")
            dvpool("DTEST_VAL")
            @test !expool("DTEST_VAL")
        finally
            clpool()
            kclear()
        end
    end
    @testset "dvsep" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et = str2et("JAN 1 2009")
            state_e, eltime = spkezr("EARTH", et, "J2000", "NONE", "SUN")
            state_m, mltime = spkezr("MOON", et, "J2000", "NONE", "SUN")
            dsept = dvsep(state_e, state_m)
            @test dsept ≈ 3.8121194e-09 rtol=1e-6
        finally
            kclear()
        end
    end
end
