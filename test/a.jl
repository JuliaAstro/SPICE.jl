@testset "A" begin
    @testset "axisar" begin
        axis = [0.0, 0.0, 1.0]
        output = axisar(axis, π/2)
        expected = [0.0 -1.0 0.0; 1.0 0.0 0.0; 0.0 0.0 1.0]
        @test output ≈ expected
        @test_throws ArgumentError axisar(axis[1:2], π/2)
    end
    @testset "azlcpo" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk),
                   path(EXTRA, :earth_topo_tf),
                   path(EXTRA, :earth_stn_spk),
                   path(EXTRA, :earth_high_per_pck)
            )
            et = str2et("2003 Oct 13 06:00:00 UTC")
            obspos = [-2353.621419700, -4641.341471700, 3677.052317800]
            azlsta, lt = azlcpo("ELLIPSOID", "VENUS", et, "CN+S", false, true, obspos, "EARTH", "ITRF93")
            expected = [2.45721479e8, 5.13974044, -8.54270565e-1, -4.68189831, 7.02070016e-5, -5.39579640e-5]
            @test all(azlsta ≈ expected)
        finally
            kclear()
        end
    end
    @testset "azlrec" begin
        exp01 = [0.0, 0.0, 0.0]
        exp02 = [1.0, 0.0, 0.0]
        exp03 = [-0.0, -1.0, 0.0]
        exp04 = [0.0, 0.0, -1.0]
        exp05 = [-1.0, 0.0, 0.0]
        exp06 = [0.0, 1.0, 0.0]
        exp07 = [0.0, 0.0, 1.0]
        exp08 = [1.0, -1.0, 0.0]
        exp09 = [1.0, 0.0, -1.0]
        exp10 = [-0.0, -1.0, -1.0]
        exp11 = [1.0, -1.0, -1.0]

        act01 = collect(azlrec(0.0, deg2rad(0.0), deg2rad(0.0), true, true))
        act02 = collect(azlrec(1.0, deg2rad(0.0), deg2rad(0.0), true, true))
        act03 = collect(azlrec(1.0, deg2rad(270.0), deg2rad(0.0), true, true))
        act04 = collect(azlrec(1.0, deg2rad(0.0), deg2rad(-90.0), true, true))
        act05 = collect(azlrec(1.0, deg2rad(180.0), deg2rad(0.0), true, true))
        act06 = collect(azlrec(1.0, deg2rad(90.0), deg2rad(0.0), true, true))
        act07 = collect(azlrec(1.0, deg2rad(0.0), deg2rad(90.0), true, true))
        act08 = collect(azlrec(sqrt(2.0), deg2rad(315.0), deg2rad(0.0), true, true))
        act09 = collect(azlrec(sqrt(2.0), deg2rad(0.0), deg2rad(-45.0), true, true))
        act10 = collect(azlrec(sqrt(2.0), deg2rad(270.0), deg2rad(-45.0), true, true))
        act11 = collect(azlrec(sqrt(3.0), deg2rad(315.0), deg2rad(-35.264389682754654), true, true))

        @testset for i in eachindex(act01, exp01)
            @test act01[i] ≈ exp01[i] atol=1e-16
        end
        @testset for i in eachindex(act02, exp02)
            @test act02[i] ≈ exp02[i] atol=1e-16
        end
        @testset for i in eachindex(act03, exp03)
            @test act03[i] ≈ exp03[i] atol=1e-15
        end
        @testset for i in eachindex(act04, exp04)
            @test act04[i] ≈ exp04[i] atol=1e-16
        end
        @testset for i in eachindex(act05, exp05)
            @test act05[i] ≈ exp05[i] atol=1e-15
        end
        @testset for i in eachindex(act06, exp06)
            @test act06[i] ≈ exp06[i] atol=1e-16
        end
        @testset for i in eachindex(act07, exp07)
            @test act07[i] ≈ exp07[i] atol=1e-16
        end
        @testset for i in eachindex(act08, exp08)
            @test act08[i] ≈ exp08[i] atol=1e-15
        end
        @testset for i in eachindex(act09, exp09)
            @test act09[i] ≈ exp09[i] atol=1e-15
        end
        @testset for i in eachindex(act10, exp10)
            @test act10[i] ≈ exp10[i] atol=1e-15
        end
        @testset for i in eachindex(act11, exp11)
            @test act11[i] ≈ exp11[i] atol=1e-15
        end
    end
end
