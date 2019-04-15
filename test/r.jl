using LinearAlgebra: I

@testset "R" begin
    @testset "radrec" begin
        @test [1.0, 0.0, 0.0] ≈ radrec(1.0, 0.0, 0.0)
        @test [0.0, 1.0, 0.0] ≈ radrec(1.0, π/2, 0.0)
        @test [0.0, 0.0, 1.0] ≈ radrec(1.0, 0.0, π/2)
    end
    @testset "rav2xf" begin
        e = [1.0, 0.0, 0.0]
        rz = [0.0 1.0 0.0; -1.0 0.0 0.0; 0.0 0.0 1.0]
        exp = [0.0  1.0  0.0  0.0  0.0  0.0;
               -1.0  0.0  0.0  0.0  0.0  0.0;
               0.0  0.0  1.0  0.0  0.0  0.0;
               0.0  0.0  1.0  0.0  1.0  0.0;
               0.0  0.0  0.0 -1.0  0.0  0.0;
               0.0 -1.0  0.0  0.0  0.0  1.0]
        act = rav2xf(rz, e)
        @testset for i in eachindex(exp, act)
            @test exp[i] ≈ act[i]
        end
    end
    @testset "raxisa" begin
        axis = [1.0, 2.0, 3.0]
        angle = 0.2π
        rotate_matrix = axisar(axis, angle)
        axout, angout = raxisa(rotate_matrix)
        expected_angout = [0.26726124, 0.53452248, 0.80178373]
        @test angout ≈ 0.62831853
        @test axout ≈ expected_angout
        @test_throws SpiceError raxisa(randn(3, 3))
        @test_throws ArgumentError raxisa(randn(2, 2))
    end
    @testset "reccyl" begin
        expected1 = (0.0, 0.0, 0.0)
        expected2 = (1.0, π/2, 0.0)
        expected3 = (1.0, 3/2 * π, 0.0)
        @test all(reccyl([0.0, 0.0, 0.0]) .≈ expected1)
        @test all(reccyl([0.0, 1.0, 0.0]) .≈ expected2)
        @test all(reccyl([0.0, -1.0, 0.0]) .≈ expected3)
        @test_throws ArgumentError reccyl([0.0, -1.0])
    end
    @testset "recgeo" begin
        try
            furnsh(path(CORE, :pck))
            radii = bodvrd("EARTH", "RADII", 3)
            flat = (radii[1] - radii[3]) / radii[1]
            x = [-2541.748162, 4780.333036, 3360.428190]
            lon, lat, alt = recgeo(x, radii[1], flat)
            actual = [rad2deg(lon), rad2deg(lat), alt]
            expected = [118.0, 32.0, 0.001915518]
            @testset for i in eachindex(actual, expected)
                @test actual[i] ≈ expected[i] rtol=1e-4
            end
            @test_throws ArgumentError recgeo(x[1:2], radii[1], flat)
            @test_throws SpiceError recgeo(x, -radii[1], flat)
            @test_throws SpiceError recgeo(x, radii[1], 1.0)
        finally
            kclear()
        end
    end
    @testset "reclat" begin
        act1 = reclat([1.0, 0.0, 0.0])
        act2 = reclat([0.0, 1.0, 0.0])
        act3 = reclat((-1.0, 0.0, 0.0))
        @test [act1[1], act1[2], act1[3]] ≈ [1.0, 0.0, 0.0]
        @test [act2[1], act2[2], act2[3]] ≈ [1.0, deg2rad(90.0), 0.0]
        @test [act3[1], act3[2], act3[3]] ≈ [1.0, deg2rad(180.0), 0.0]
        @test_throws ArgumentError reclat([1.0, 2.0])
    end
    @testset "recpgr" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck), path(CORE, :spk))
            radii = bodvrd("MARS", "RADII", 3)
            flat = (radii[1] - radii[3]) / radii[1]
            x = [0.0, -2620.678914818178, 2592.408908856967]
            lon, lat, alt = recpgr("MARS", x, radii[1], flat)
            actual = [rad2deg(lon), rad2deg(lat), alt]
            expected = [90., 45, 300]
            @test actual ≈ expected
            @test_throws ArgumentError recpgr("MARS", x[1:2], radii[1], flat)
            @test_throws SpiceError recpgr("MARS", x, -radii[1], flat)
            @test_throws SpiceError recpgr("MARS", x, radii[1], 1.0)
        finally
            kclear()
        end
    end
    @testset "recrad" begin
        act1 = collect(recrad([1.0, 0.0, 0.0]))
        act2 = collect(recrad([0.0, 1.0, 0.0]))
        act3 = collect(recrad([0.0, 0.0, 1.0]))
        exp1 = [1.0, 0.0, 0.0]
        @testset for i in eachindex(act1, exp1)
            @test act1[i] ≈ exp1[i]
        end
        exp2 = [1.0, deg2rad(90), 0.0]
        @testset for i in eachindex(act2, exp2)
            @test act2[i] ≈ exp2[i]
        end
        exp3 = [1.0, 0.0, deg2rad(90)]
        @testset for i in eachindex(act3, exp3)
            @test act3[i] ≈ exp3[i]
        end
    end
    @testset "recsph" begin
        v1 = [-1.0, 0.0, 0.0]
        @test all(recsph(v1) .≈ (1.0, π/2, π))
    end
    @testset "removc" begin
        cell = SpiceCharCell(10, 10)
        items = ["one", "two", "three", "four"]
        for i in items
            insrtc!(cell, i)
        end
        remove_items = ["three", "four"]
        for r in remove_items
            removc!(cell, r)
        end
        expected = ["one", "two"]
        @test cell == expected
    end
    @testset "removd" begin
        cell = SpiceDoubleCell(10)
        items = [0.0, 1.0, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0, 21.0]
        for i in items
            insrtd!(cell, i)
        end
        remove_items = [0.0, 2.0, 4.0, 6.0, 8.0, 12.0]
        for r in remove_items
            removd!(cell, r)
        end
        expected = [1.0, 3.0, 5.0, 13.0, 21.0]
        @testset for i in eachindex(cell, expected)
            @test cell[i] == expected[i]
        end
    end
    @testset "removi" begin
        cell = SpiceIntCell(10)
        items = [0, 1, 1, 2, 3, 5, 8, 13, 21]
        for i in items
            insrti!(cell, i)
        end
        remove_items = [0, 2, 4, 6, 8, 12]
        for r in remove_items
            removi!(cell, r)
        end
        expected = [1, 3, 5, 13, 21]
        @testset for i in eachindex(cell, expected)
            @test cell[i] == expected[i]
        end
    end
    @testset "reordc" begin
        array = ["one", "three", "two", "zero"]
        iorder = [4, 1, 3, 2]
        outarray = SPICE._reordc(iorder, copy(array))
        @test_skip outarray == array[iorder]
    end
    @testset "reordd" begin
        array = [1.0, 3.0, 2.0]
        iorder = [1, 3, 2]
        outarray = SPICE._reordd(iorder, copy(array))
        @test outarray == array[iorder]
    end
    @testset "reordi" begin
        array = [1, 3, 2]
        iorder = [1, 3, 2]
        outarray = SPICE._reordi(iorder, copy(array))
        @test outarray == array[iorder]
    end
    @testset "reordl" begin
        array = [true, true, false]
        iorder = [1, 3, 2]
        outarray = SPICE._reordl(iorder, copy(array))
        @test outarray == array[iorder]
    end
    @testset "repmc" begin
        stringtestone = "The truth is #"
        outstringone = SPICE._repmc(stringtestone, "#", "SPICE")
        @test replace(stringtestone, "#" => "SPICE") == outstringone
    end
    @testset "rotate" begin
        act = rotate(π / 4, 3)
        exp = [sqrt(2) / 2.0 sqrt(2) / 2.0 0.0;
              -sqrt(2) / 2.0 sqrt(2) / 2.0 0.0;
               0.0 0.0 1.0]
        @testset for i in eachindex(act, exp)
             @test act[i] ≈ exp[i]
        end
    end
    @testset "rotmat" begin
        ident = Array{Float64}(I, 3, 3)
        expected_r = [0.0 0.0 -1.0;
                      0.0 1.0 0.0;
                      1.0 0.0 0.0]
        r_out = rotmat(ident, π/2, 2)
        @test r_out ≈ expected_r
        @test_throws ArgumentError rotmat(ident[1:2, 1:2], 0.0, 3)
    end
    @testset "rotvec" begin
        vin = [sqrt(2), 0.0, 0.0]
        angle = π / 4
        iaxis = 3
        v_expected = [1.0, -1.0, 0.0]
        vout = rotvec(vin, angle, iaxis)
        @test vout ≈ v_expected
        @test_throws ArgumentError rotvec(vin[1:2], angle, iaxis)
    end
    @testset "rpd" begin
        @test deg2rad(1.0) == SPICE._rpd()
    end
    @testset "rquad" begin
        # solve x^2 + 2x + 3 = 0
        root1, root2 = rquad(1.0, 2.0, 3.0)
        expected_root1 = [-1.0, sqrt(2.0)]
        expected_root2 = [-1.0, -sqrt(2.0)]
        @test root1 == expected_root1
        @test root2 == expected_root2
        # This test prints a funny CSPICE error message
        # @test_throws SpiceError rquad(0.0, 0.0, 3.0)
    end
end
