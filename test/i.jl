@testset "I" begin 
    @testset "ilumin" begin
        try
            furnsh(
                path(CORE, :lsk),
                path(CORE, :pck),
                path(CORE, :spk),
            )
            et = str2et("2007 FEB 3 00:00:00.000")
            trgepc, obspos, trmpts = edterm("UMBRAL", "SUN", "MOON", et, "IAU_MOON", "EARTH", 3, abcorr="LT+S")
            expected_trgepc = 223732863.86351672
            expected_obspos = [
                                394721.1024056578753516078, 
                                27265.11780063395417528227,
                                -19069.08478859506431035697,
            ]
            expected_trmpts = [
                                -1.53978381936825627463e+02,
                                -1.73056331949840728157e+03,
                                1.22893325627419600088e-01,
                                87.37506200891714058798,
                                864.40670594653545322217,
                                1504.56817899807947469526,
                                42.213243378688254,
                                868.21134651980412,
                                -1504.3223922609538,
            ]
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

    @testset "illumg" begin
        try
            furnsh(
                path(CORE, :lsk),
                path(CORE, :pck),
                path(CORE, :spk),
                path(CASSINI, :pck),
                path(CASSINI, :sat_spk),
                path(CASSINI, :tour_spk),
                path(CASSINI, :fk),
                path(CASSINI, :ck),
                path(CASSINI, :sclk),
                path(CASSINI, :ik)
            )
            et = str2et("2013 FEB 25 11:50:00 UTC")
            spoint, trgepc, srfvec = subpnt("Near Point/Ellipsoid", "Enceladus", et, "IAU_ENCELADUS", "Earth", abcorr="CN+S")
            trgepc2, srfvec2, phase, incid, emissn = illumg("Ellipsoid", "Enceladus", "Sun", et, "IAU_ENCELADUS", "CASSINI", spoint, abcorr="CN+S")
            
            @test rad2deg(phase) ≈ 161.859925246638
            @test rad2deg(incid) ≈ 18.47670084384343
            @test rad2deg(emissn) ≈ 143.6546170649875
        finally
            kclear()
        end
    end
end

