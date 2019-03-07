using LinearAlgebra: I, ⋅

@testset "P" begin
    @testset "pckopn/pckw02/pckcls" begin
        try
            pck = tempname()
            handle = pckopn(pck, "Test PCK file", 5000)
            pckw02(handle, 301, "j2000", 0.0, 1.0, "segid", 1.0, [[1.0, 2.0, 3.0]], 0.0)
            pckcls(handle)
        finally
            kclear()
        end
    end
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
    @testset "phaseq" begin
        relate = ["=", "<", ">", "LOCMIN", "ABSMIN", "LOCMAX", "ABSMAX"]
        expected = Dict(
            "="=> [
                0.575988450,
                0.575988450,
                0.575988450,
                0.575988450,
                0.575988450,
                0.575988450,
                0.575988450,
                0.575988450,
                0.575988450,
                0.575988450,
            ],
            "<"=> [0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.468279091],
            ">"=> [0.940714974, 0.575988450, 0.575988450, 0.575988450, 0.575988450, 0.575988450],
            "LOCMIN"=> [0.086121423, 0.086121423, 0.079899769, 0.079899769],
            "ABSMIN"=> [0.079899769, 0.079899769],
            "LOCMAX"=> [3.055062862, 3.055062862, 3.074603891, 3.074603891],
            "ABSMAX"=> [3.074603891, 3.074603891],
        )
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et0 = str2et("2006 DEC 01")
            et1 = str2et("2007 JAN 31")
            cnfine = SpiceDoubleCell(2)
            wninsd!(cnfine, et0, et1)
            result = SpiceDoubleCell(10000)
            for relation in relate
                result = gfpa("Moon", "Sun", "LT+S", "Earth", relation, 0.57598845, 0.0, spd(), 5000, cnfine)
                count = wncard(result)
                @test count > 0
                if count > 0
                    results = Float64[]
                    for i in 1:count
                        start, stop = wnfetd(result, i)
                        start_phase = phaseq(start, "moon", "sun", "earth", "lt+s")
                        stop_phase = phaseq(stop, "moon", "sun", "earth", "lt+s")
                        push!(results, start_phase)
                        push!(results, stop_phase)
                    end
                    exp = expected[relation]
                    @testset for i in eachindex(results, exp)
                        @test round(results[i], digits=9) ≈ exp[i] atol=1e-6
                    end
                end
            end
            start, stop = wnfetd(result, 1)
            @test_throws SpiceError phaseq(start, "moon", "moon", "moon", "lt+s")
        finally
            kclear()
        end
    end
    @testset "pi" begin
        @test SPICE._pi() ≈ π
    end
    @testset "pjelpl" begin
        cent = [1.0, 1.0, 1.0]
        vec1 = [2.0, 0.0, 0.0]
        vec2 = [0.0, 1.0, 1.0]
        normal = [0.0, 0.0, 1.0]
        plane = nvc2pl(normal, 0.0)
        elin = cgv2el(cent, vec1, vec2)
        ellipse = pjelpl(elin, plane)
        expected_smajor = [2.0, 0.0, 0.0]
        expected_sminor = [0.0, 1.0, 0.0]
        expected_center = [1.0, 1.0, 0.0]
        @test expected_center ≈ center(ellipse)
        @test expected_smajor ≈ semi_major(ellipse)
        @test expected_sminor ≈ semi_minor(ellipse)
    end
    @testset "pl2nvc" begin
        normal = [-1.0, 5.0, -3.5]
        point = [9.0, -0.65, -12.0]
        plane = nvp2pl(normal, point)
        normal, constant = pl2nvc(plane)
        expected_normal = [-0.16169042, 0.80845208, -0.56591646]
        @test constant ≈ 4.8102899
        @test expected_normal ≈ normal
    end
    @testset "pl2nvp" begin
        plane_norm = [2.44, -5.0 / 3.0, 11.0 / 9.0]
        con = 3.141592654
        plane = nvc2pl(plane_norm, con)
        norm_vec, point = pl2nvp(plane)
        expected_point = [0.74966576, -0.51206678, 0.37551564]
        @test expected_point ≈ point
    end
    @testset "pl2psv" begin
        normal = [-1.0, 5.0, -3.5]
        point = [9.0, -0.65, -12.0]
        plane = nvp2pl(normal, point)
        point, span1, span2 = pl2psv(plane)
        @test point ⋅ span1 ≈ 0 atol=sqrt(eps())
        @test point ⋅ span2 ≈ 0 atol=sqrt(eps())
        @test span1 ⋅ span2 ≈ 0 atol=sqrt(eps())
    end
    @testset "pltar" begin
        vrtces = [[0.0, 0.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
        plates = [[1, 4, 3], [1, 2, 4], [1, 3, 2], [2, 3, 4]]
        @test pltar(vrtces, plates) ≈ 2.3660254037844
    end
    @testset "pltexp" begin
        iverts = [[sqrt(3.0) / 2.0, -0.5, 7.0], [0.0, 1.0, 7.0], [-sqrt(3.0) / 2.0, -0.5, 7.0]]
        overts = pltexp(iverts, 1.0)
        expected = [[1.732050807569, -1.0, 7.0], [0.0, 2.0, 7.0], [-1.732050807569, -1.0, 7.0]]
        @test all(expected ≈ overts)
    end
    @testset "pltnp" begin
        point = [2.0, 2.0, 2.0]
        v1 = [1.0, 0.0, 0.0]
        v2 = [0.0, 1.0, 0.0]
        v3 = [0.0, 0.0, 1.0]
        near, distance = pltnp(point, v1, v2, v3)
        @test [1.0/3.0, 1.0/3.0, 1.0/3.0] ≈ near
        @test round(distance, digits=7) ≈ 2.8867513
        @test_throws ArgumentError pltnp(point[1:2], v1, v2, v3)
        @test_throws ArgumentError pltnp(point, v1[1:2], v2, v3)
        @test_throws ArgumentError pltnp(point, v1, v2[1:2], v3)
        @test_throws ArgumentError pltnp(point, v1, v2, v3[1:2])
    end
    @testset "pltnrm" begin
        v1 = [sqrt(3.0) / 2.0, -0.5, 0.0]
        v2 = [0.0, 1.0, 0.0]
        v3 = [-sqrt(3.0) / 2.0, -0.5, 0.0]
        @test [0.0, 0.0, 2.59807621135] ≈ pltnrm(v1, v2, v3)
        @test_throws ArgumentError pltnrm(v1[1:2], v2, v3)
        @test_throws ArgumentError pltnrm(v1, v2[1:2], v3)
        @test_throws ArgumentError pltnrm(v1, v2, v3[1:2])
    end
    @testset "pltvol" begin
        vrtces = [[0.0, 0.0, 0.0], [1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
        plates = [[1, 4, 3], [1, 2, 4], [1, 3, 2], [2, 3, 4]]
        @test pltvol(vrtces, plates) ≈ 1.0 / 6.0
        vrtces1 = [[0.0, 0.0], [1.0, 0.0], [0.0, 1.0], [0.0, 0.0]]
        plates1 = [[1, 4], [1, 2], [1, 3], [2, 3]]
        @test_throws ArgumentError pltvol(vrtces1, plates)
        @test_throws ArgumentError pltvol(vrtces, plates1)
    end
    @testset "polyds" begin
        result = polyds([1.0, 3.0, 0.5, 1.0, 0.5, -1.0, 1.0], 3, 1)
        @test result ≈ [6.0, 10.0, 23.0, 78.0]
    end
    @testset "pos" begin
        string = "AN ANT AND AN ELEPHANT        "
        @test SPICE._pos(string, "AN", 1) == 1
        @test SPICE._pos(string, "AN", 3) == 4
        @test SPICE._pos(string, "AN", 6) == 8
        @test SPICE._pos(string, "AN", 10) == 12
        @test SPICE._pos(string, "AN", 14) == 20
        @test SPICE._pos(string, "AN", 22) == -1
        @test SPICE._pos(string, "AN", -6) == 1
        @test SPICE._pos(string, "AN", -1) == 1
        @test SPICE._pos(string, "AN", 31) == -1
        @test SPICE._pos(string, "AN", 44) == -1
        @test SPICE._pos(string, " AN", 1) == 3
        @test SPICE._pos(string, " AN ", 1) == 11
        @test SPICE._pos(string, " AN  ", 1) == -1

        @test first(findnext("AN", string, 1)) == SPICE._pos(string, "AN", 1)
        @test first(findnext("AN", string, 3)) == SPICE._pos(string, "AN", 3)
        @test first(findnext("AN", string, 6)) == SPICE._pos(string, "AN", 6)
        @test first(findnext("AN", string, 10)) == SPICE._pos(string, "AN", 10)
        @test first(findnext(" AN", string, 1)) == SPICE._pos(string, " AN", 1)
        @test first(findnext(" AN ", string, 1)) == SPICE._pos(string, " AN ", 1)
    end
    @testset "posr" begin
        string = "AN ANT AND AN ELEPHANT        "
        @test SPICE._posr(string, "AN", 30) == 20
        @test SPICE._posr(string, "AN", 19) == 12
        @test SPICE._posr(string, "AN", 11) == 8
        @test SPICE._posr(string, "AN", 7) == 4
        @test SPICE._posr(string, "AN", 3) == 1
        @test SPICE._posr(string, "AN", -6) == -1
        @test SPICE._posr(string, "AN", -1) == -1
        @test SPICE._posr(string, "AN", 31) == 20
        @test SPICE._posr(string, "AN", 44) == 20
        @test SPICE._posr(string, " AN", 30) == 11
        @test SPICE._posr(string, " AN ", 30) == 11
        @test SPICE._posr(string, " AN ", 10) == -1
        @test SPICE._posr(string, " AN  ", 30) == -1

        @test first(findprev("AN", string, 30)) == SPICE._posr(string, "AN", 30)
        @test first(findprev("AN", string, 19)) == SPICE._posr(string, "AN", 19)
        @test first(findprev("AN", string, 11)) == SPICE._posr(string, "AN", 11)
        @test first(findprev("AN", string, 7)) == SPICE._posr(string, "AN", 7)
        @test first(findprev("AN", string, 3)) == SPICE._posr(string, "AN", 3)
        @test first(findprev("AN", string, 31)) == SPICE._posr(string, "AN", 31)
        @test first(findprev("AN", string, 44)) == SPICE._posr(string, "AN", 44)
        @test first(findprev(" AN", string, 30)) == SPICE._posr(string, " AN", 30)
        @test first(findprev(" AN ", string, 30)) == SPICE._posr(string, " AN ", 30)
    end
    @testset "prop2b" begin
        mu = 398600.45
        r = 1.0e8
        speed = sqrt(mu / r)
        t = π * (r / speed)
        pvinit = [0.0, r / sqrt(2.0), r / sqrt(2.0), 0.0, -speed / sqrt(2.0), speed / sqrt(2.0)]
        state = prop2b(mu, pvinit, t)
        @test state ≈ -1.0 * pvinit
        @test_throws SpiceError prop2b(-mu, pvinit, t)
        @test_throws SpiceError prop2b(mu, [pvinit[1:3]; zeros(3)], t)
        @test_throws SpiceError prop2b(mu, [zeros(3); pvinit[4:6]], t)
        @test_throws SpiceError prop2b(mu, [pvinit[4:6] .* 1e3; pvinit[4:6]], t)
    end
    @testset "prsdp" begin
        # What an awful idea!
        @test SPICE._prsdp("-1. 000") == -1.0

        @test parse(Float64, "-1.0") == SPICE._prsdp("-1.0")
    end
    @testset "prsint" begin
        # This is an abomination!
        @test SPICE._prsint("PI") == 3

        @test parse(Int, "-1") == SPICE._prsdp("-1")
    end
    @testset "psv2pl" begin
        try
            epoch = "Jan 1 2005"
            frame = "ECLIPJ2000"
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et(epoch)
            state, ltime = spkezr("EARTH", et, frame, "NONE", "SOLAR SYSTEM BARYCENTER")
            es_plane = psv2pl(state[1:3], state[1:3], state[4:6])
            es_norm, es_const = pl2nvc(es_plane)
            mstate, mltime = spkezr("MOON", et, frame, "NONE", "EARTH BARYCENTER")
            em_plane = psv2pl(mstate[1:3], mstate[1:3], mstate[4:6])
            em_norm, em_const = pl2nvc(em_plane)
            @test rad2deg(vsep(es_norm, em_norm)) ≈ 5.0424941
            @test_throws SpiceError psv2pl(mstate[1:3], mstate[1:3], mstate[1:3])
            @test_throws ArgumentError psv2pl(mstate[1:2], mstate[1:3], mstate[4:6])
            @test_throws ArgumentError psv2pl(mstate[1:3], mstate[1:2], mstate[4:6])
            @test_throws ArgumentError psv2pl(mstate[1:3], mstate[1:3], mstate[4:5])
        finally
            kclear()
        end
    end
    @testset "pxform" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            lon = deg2rad(118.25)
            lat = deg2rad(34.05)
            alt = 0.0
            utc = "January 1, 2005"
            et = str2et(utc)
            abc = bodvrd("EARTH", "RADII", 3)
            equatr = abc[1]
            polar = abc[3]
            f = (equatr - polar) / equatr
            epos = georec(lon, lat, alt, equatr, f)
            rotate = pxform("IAU_EARTH", "J2000", et)
            jstate = rotate' * epos
            expected = [5042.1309421, 1603.52962986, 3549.82398086]
            rot_exp = [-0.18437048 -0.98285670 0.00048614;
                       0.98285681 -0.18437050 -2.71973868E-07;
                       8.98973426E-05 0.00047776 0.99999988]
            @testset for i = eachindex(rotate, rot_exp)
                @test rotate[i] ≈ rot_exp[i] atol=1e-6
            end
            @testset for i = eachindex(jstate, expected)
                @test jstate[i] ≈ expected[i]
            end
            @test pxform("J2000", "J2000", 0.) ≈ Array{Float64}(I, 3, 3)
            @test_throws SpiceError pxform("Norbert", "J2000", 0.0)
        finally
            kclear()
        end
    end
    @testset "pxfrm2" begin
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

            # start of test
            etrec = str2et("2013 FEB 25 11:50:00 UTC")
            camid = bodn2c("CASSINI_ISS_NAC")
            shape, obsref, bsight, bounds = getfov(camid, 4)
            # run sincpt on boresight vector
            spoint, etemit, srfvec = sincpt("ELLIPSOID", "ENCELADUS",
                                            etrec, "IAU_ENCELADUS", "CN+S", "CASSINI", obsref, bsight)
            rotate = pxfrm2(obsref, "IAU_ENCELADUS", etrec, etemit)
            # get radii
            radii = bodvrd("ENCELADUS", "RADII", 3)
            # find position of center with respect to MGS
            pcassmr = spoint .- srfvec
            # rotate into IAU_ENCELADUS
            bndvec = rotate * (0.9999 .* bsight .+ 0.0001 .* bounds[2])
            # get surface point
            spoint = surfpt(pcassmr, bndvec, radii[1], radii[2], radii[3])
            @test spoint !== nothing
            if spoint !== nothing
                radius, lon, lat = reclat(spoint)
                lon = rad2deg(lon)
                lat = rad2deg(lat)
                @test radius ≈ 250.14507342586242
                @test lon ≈ 125.42089677611104
                @test lat ≈ -6.3718522103931585
            end
        finally
            kclear()
        end
    end
end
