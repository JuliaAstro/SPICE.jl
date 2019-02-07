@testset "E" begin
    @testset "et2utc" begin
        try
            furnsh(path(CORE, :lsk))
            let et = -527644192.5403653
                output = et2utc(et, :J, 6)
                @test output == "JD 2445438.006415"
            end
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

    @testset "edterm" begin
        try
            furnsh(
                path(CORE, :lsk),
                path(CORE, :pck),
                path(CORE, :spk),
            )
            et = str2et("2007 FEB 3 00:00:00.000")
            # umbral
            trgepc, obspos, trmpts = edterm("UMBRAL", "SUN", "MOON", et, "IAU_MOON", "EARTH", 3, abcorr="LT+S")
            expected_trgepc = 223732863.86351674795
            expected_obspos = [394721.1024056578753516078, 27265.11780063395417528227, -19069.08478859506431035697]

            expected_trmpts0 = [
                -1.53978381936825627463e+02,
                -1.73056331949840728157e+03,
                1.22893325627419600088e-01,
            ]
            expected_trmpts1 = [
                87.37506200891714058798,
                864.40670594653545322217,
                1504.56817899807947469526,
            ]
            expected_trmpts2 = [
                42.21324376177891224415,
                868.21134635239388899208,
                -1504.3223923468244720425,
            ]
            expected_trmpts = [
                -1.53978381936825627463e+02,
                -1.73056331949840728157e+03,
                1.22893325627419600088e-01,
                87.37506200891714058798,
                864.40670594653545322217,
                1504.56817899807947469526,
                42.21324376177891224415,
                868.21134635239388899208,
                -1504.3223923468244720425,
            ]
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
            #penumbral
            trgepc, obspos, trmpts = edterm("PENUMBRAL", "SUN", "MOON", et, "IAU_MOON", "EARTH", 3, abcorr="LT+S")
            expected_trmpts = [
                1.54019056755619715204e+02,
                1.73055969989532059117e+03,
                -1.23508409498995316844e-01,
                -87.33436047798454637814,
                -864.41003834758112134296,
                -1504.56862757530461749411,
                -42.17254722919552278881,
                -868.21467833235510624945,
                1504.32161075630597224517,
            ]
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
end
