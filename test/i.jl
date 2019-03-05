using LinearAlgebra: I, norm

@testset "I" begin
    @testset "ident" begin
        @test SPICE._ident() == Array{Float64}(I, 3, 3)
    end
    @testset "ilumin" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            et = str2et("2007 FEB 3 00:00:00.000")
            trgepc, obspos, trmpts = edterm("UMBRAL", "SUN", "MOON", et, "IAU_MOON", "LT+S", "EARTH", 3)
            expected_trgepc = 223732863.86351672
            expected_obspos = [394721.1024056578753516078,
                               27265.11780063395417528227,
                               -19069.08478859506431035697]
            expected_trmpts = [-1.53978381936825627463e+02,
                               -1.73056331949840728157e+03,
                               1.22893325627419600088e-01,
                               87.37506200891714058798,
                               864.40670594653545322217,
                               1504.56817899807947469526,
                               42.213243378688254,
                               868.21134651980412,
                               -1504.3223922609538]
            @test trgepc ≈ expected_trgepc
            @test obspos ≈ expected_obspos
            for i in eachindex(trmpts, expected_trmpts)
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
        finally
            kclear()
        end
    end
    @testset "illumf" begin
        try
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
            et = str2et("2013 FEB 25 11:50:00 UTC")
            camid = bodn2c("CASSINI_ISS_NAC")
            shape, obsref, bsight, bounds = getfov(camid, 4)
            # run sincpt on boresight vector
            spoint, etemit, srfvec = sincpt("ELLIPSOID", "ENCELADUS", et, "IAU_ENCELADUS", "CN+S",
                                            "CASSINI", obsref, bsight)
            trgepc2, srfvec2, phase, incid, emissn, visible, lit = illumf("ELLIPSOID", "ENCELADUS",
                                                                          "SUN", et, "IAU_ENCELADUS",
                                                                          "CN+S", "CASSINI", spoint)
            @test rad2deg(phase) ≈ 161.82854377660345
            @test rad2deg(incid) ≈ 134.92108561449996
            @test rad2deg(emissn) ≈ 63.23618556218115
            @test !lit # Incidence angle is greater than 90deg
            @test visible # Emission angle is less than 90deg
            @test_throws SpiceError illumf("ELLIPSOID", "norbert", "SUN", et, "IAU_ENCELADUS", "CN+S",
                                           "CASSINI", spoint)
            @test_throws ArgumentError illumf("ELLIPSOID", "ENCELADUS", "SUN", et, "IAU_ENCELADUS", "CN+S",
                                              "CASSINI", spoint[1:2])
        finally
            kclear()
        end
    end
    @testset "illumg" begin
        try
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
            et = str2et("2013 FEB 25 11:50:00 UTC")
            spoint, trgepc, srfvec = subpnt("NEAR POINT/ELLIPSOID", "ENCELADUS", et, "IAU_ENCELADUS",
                                            "CN+S", "EARTH")
            trgepc2, srfvec2, phase, incid, emissn = illumg("ELLIPSOID", "ENCELADUS", "SUN", et,
                                                            "IAU_ENCELADUS", "CASSINI", spoint, abcorr="CN+S")

            @test rad2deg(phase) ≈ 161.859925246638
            @test rad2deg(incid) ≈ 18.47670084384343
            @test rad2deg(emissn) ≈ 143.6546170649875
        finally
            kclear()
        end
    end
    @testset "inedpl" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            time = "Oct 31 2002, 12:55:00 PST"
            et = str2et(time)
            state, ltime = spkezr("EARTH", et, "J2000", "LT+S", "SUN")
            pos = state[1:3]
            radii = bodvrd("EARTH", "RADII", 3)
            pos = [pos[1] / radii[1]^2.0,
                   pos[2] / radii[2]^2.0,
                   pos[3] / radii[3]^2.0]
            plane = nvc2pl(pos, 1.0)
            term = inedpl(radii[1], radii[2], radii[3], plane)
            expected_center = [0.21512031, 0.15544527, 0.067391641]
            expected_smajor = [-3.73561164720596843836e+03, 5.16970328302375583007e+03,
                               1.35988201424391742850e-11]
            expected_sminor = [-1276.33357469839393161237, -922.27470443423590040766,
                               6159.97371233560443215538]
            @test center(term) ≈ expected_center atol=1e-6
            @test semi_major(term) ≈ expected_smajor
            @test semi_minor(term) ≈ expected_sminor
            @test norm(semi_major(term)) ≈ 6378.1365 rtol=1e-4
            @test norm(semi_minor(term)) ≈ 6358.0558 rtol=1e-4
            @test_throws SpiceError inedpl(-radii[1], radii[2], radii[3], plane)
        finally
            kclear()
        end
    end
    @testset "inelpl" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("SATURN", "RADII", 3)
            vertex = [100.0 * radii[1], 0.0, radii[1] * 100.0]
            limb = edlimb(radii..., vertex)
            normal = [0.0, 0.0, 1.0]
            point = [0.0, 0.0, 0.0]
            plane = nvp2pl(normal, point)
            nxpts, xpt1, xpt2 = inelpl(limb, plane)
            expected_xpt1 = [602.68000, 60264.9865, 0.0]
            expected_xpt2 = [602.68000, -60264.9865, 0.0]
            @test nxpts == 2.0
            @test expected_xpt1 ≈ xpt1
            @test expected_xpt2 ≈ xpt2
        finally
            kclear()
        end
    end
    @testset "inrypl" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("SATURN", "RADII", 3)
            vertex = [3.0 * radii[1], 0.0, radii[3] * 0.5]
            dire = [0.0, cos(deg2rad(30.0)), -1.0 * sin(deg2rad(30.0))]
            normal = [0.0, 0.0, 1.0]
            point = [0.0, 0.0, 0.0]
            plane = nvp2pl(normal, point)
            nxpts, xpt = inrypl(vertex, dire, plane)
            expected_xpt = [180804.0, 47080.6050513, 0.0]
            @test nxpts == 1
            @test xpt ≈ expected_xpt
        finally
            kclear()
        end
    end
    @testset "insrtc" begin
        cell = SpiceCharCell(10, 10)
        clist = ["aaa", "bbb", "ccc", "bbb"]
        for c in clist
            insrtc!(cell, c)
        end
        @test collect(cell) == ["aaa", "bbb", "ccc"]
    end
    @testset "insrtd" begin
        cell = SpiceDoubleCell(8)
        dlist = [0.5, 2.0, 30.0, 0.01, 30.0]
        for d in dlist
            insrtd!(cell, d)
        end
        @test collect(cell) == [0.01, 0.5, 2.0, 30.0]
    end
    @testset "insrti" begin
        cell = SpiceIntCell(8)
        ilist = [1, 2, 30, 1, 30]
        for i in ilist
            insrti!(cell, i)
        end
        @test collect(cell) == [1, 2, 30]
    end
    @testset "inter" begin
        i1 = SpiceIntCell(8)
        i2 = SpiceIntCell(8)
        insrti!(i1, 1)
        insrti!(i1, 2)
        insrti!(i2, 1)
        insrti!(i2, 3)
        out = inter(i1, i2)
        @test out == [1]

        d1 = SpiceDoubleCell(8)
        d2 = SpiceDoubleCell(8)
        insrtd!(d1, 1.0)
        insrtd!(d1, 2.0)
        insrtd!(d2, 1.0)
        insrtd!(d2, 3.0)
        out = inter(d1, d2)
        @test out == [1.0]

        c1 = SpiceCharCell(8, 8)
        c2 = SpiceCharCell(8, 8)
        insrtc!(c1, "1")
        insrtc!(c1, "2")
        insrtc!(c2, "1")
        insrtc!(c2, "3")
        out = inter(c1, c2)
        @test out == ["1"]
    end
	@testset "intmax" begin
		@test SPICE._intmax() == typemax(SPICE.SpiceInt)
	end
	@testset "intmin" begin
		@test SPICE._intmin() == typemin(SPICE.SpiceInt)
	end
    @testset "invert" begin
        m1 = [0.0 -1.0 0.0; 0.5 0.0 0.0; 0.0 0.0 1.0]
        expected = [0.0 2.0 0.0; -1.0 0.0 0.0; 0.0 0.0 1.0]
        mout = SPICE._invert(m1)
        @test expected ≈ mout
        @test inv(m1) ≈ mout
    end
    @testset "invort" begin
        m1 = eul2m(3, 2, 1, 3, 2, 1)
        @test inv(m1) ≈ SPICE._invort(m1)
    end
    @testset "isordv" begin
        @test isperm([1, 2]) == SPICE._isordv([1, 2])
        @test isperm([1, 2, 3]) == SPICE._isordv([1, 2, 3])
        @test isperm([1, 2, 3, 4]) == SPICE._isordv([1, 2, 3, 4])
        @test isperm([1, 1, 1]) == SPICE._isordv([1, 1, 1])
    end
    @testset "isrchc" begin
        array = ["1", "0", "4", "2"]
        @test SPICE._isrchc("4", array) == findfirst(array .== "4")
        @test SPICE._isrchc("2", array) == findfirst(array .== "2")
    end
    @testset "isrchd" begin
        array = [1.0, 0.0, 4.0, 2.0]
        @test SPICE._isrchd(4.0, array) == findfirst(array .== 4.0)
        @test SPICE._isrchd(2.0, array) == findfirst(array .== 2.0)
    end
    @testset "isrchi" begin
        array = [1, 0, 4, 2]
        @test SPICE._isrchi(4, array) == findfirst(array .== 4)
        @test SPICE._isrchi(2, array) == findfirst(array .== 2)
    end
    @testset "isrot" begin
        m = eul2m(3, 2, 1, 3, 2, 1)
        @test isrot(m, 0.0001, 0.0001)
        @test_throws ArgumentError isrot(m[1:2, 1:2], 0.0001, 0.0001)
        @test_throws SpiceError isrot(m, -0.0001, 0.0001)
    end
    @testset "iswhsp" begin
        @test isempty(strip("   ")) == SPICE._iswhsp("   ")
        @test isempty(strip("spice")) == SPICE._iswhsp("spice")
    end
end

