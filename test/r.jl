@testset "R" begin 
    let 
        act = rotate(π/4, 3)
        exp = [sqrt(2)/2.0 sqrt(2)/2.0 0.0;
              -sqrt(2)/2.0 sqrt(2)/2.0 0.0;
               0.0 0.0 1.0]
        @testset for i in eachindex(act, exp)
             @test act[i] ≈ exp[i]
        end
    end
    let 
        act1 = collect(recrad([1.0, 0.0, 0.0]))
        act2 = collect(recrad([0.0, 1.0, 0.0]))
        act3 = collect(recrad([0.0, 0.0, 1.0]))
        exp1=[1.0, 0.0, 0.0]
        @testset for i in eachindex(act1, exp1)
            @test act1[i] ≈ exp1[i]
        end
        exp2=[1.0, deg2rad(90), 0.0]
        @testset for i in eachindex(act2, exp2)
            @test act2[i] ≈ exp2[i]
        end
        exp3=[1.0, 0.0, deg2rad(90)]
        @testset for i in eachindex(act3, exp3)
            @test act3[i] ≈ exp3[i]
        end
    end

    kclear()
    furnsh(
        path(CORE, :lsk),
        path(CORE, :pck),
        path(CORE, :spk))
        radii = bodvrd("MARS", "RADII", 3)
        flat = (radii[1] - radii[3])/ radii[1]
        x = [0.0, -2620.678914818178, 2592.408908856967]
        lon, lat, alt = recpgr("mars", x, radii[1], flat)
        actual = [rad2deg(lon), rad2deg(lat), alt]
        expected = [90., 45, 300]
        @test actual ≈ expected
    kclear()  

    kclear()
    furnsh(
        path(CORE, :lsk),
        path(CORE, :pck),
        path(CORE, :spk))
        act1 = reclat([1.0, 0.0, 0.0])
        act2 = reclat([0.0, 1.0, 0.0])
        act3 = reclat([-1.0, 0.0, 0.0])
        @test [act1[1], act1[2], act1[3]] ≈ [1.0, 0.0, 0.0]
        @test [act2[1], act2[2], act2[3]] ≈ [1.0, deg2rad(90.0), 0.0]
        @test [act3[1], act3[2], act3[3]] ≈ [1.0, deg2rad(180.0), 0.0]
end
