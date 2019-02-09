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
#= @testset "removc" begin =#
#=     cell = cell_char(10, 10) =#
#=     items = ["one", "two", "three", "four"] =#
#=     for i in items: =#
#=         insrtc(i, cell) =#
#=     removeItems = ["three", "four"] =#
#=     for r in removeItems: =#
#=         removc(r, cell) =#
#=     expected = ["one", "two"] =#
#=     assert expected == [x for x in cell] =#
#=  =#
#=  =#
#= @testset "removd" begin =#
#=     cell = cell_double(10) =#
#=     items = [0.0, 1.0, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0, 21.0] =#
#=     for i in items: =#
#=         insrtd(i, cell) =#
#=     removeItems = [0.0, 2.0, 4.0, 6.0, 8.0, 12.0] =#
#=     for r in removeItems: =#
#=         removd(r, cell) =#
#=     expected = [1.0, 3.0, 5.0, 13.0, 21.0] =#
#=     for x, y in zip(cell, expected): =#
#=         assert x == y =#
#=  =#
#=  =#
#= @testset "removi" begin =#
#=     cell = cell_int(10) =#
#=     items = [0, 1, 1, 2, 3, 5, 8, 13, 21] =#
#=     for i in items: =#
#=         insrti(i, cell) =#
#=     removeItems = [0, 2, 4, 6, 8, 12] =#
#=     for r in removeItems: =#
#=         removi(r, cell) =#
#=     expected = [1, 3, 5, 13, 21] =#
#=     for x, y in zip(cell, expected): =#
#=         assert x == y =#
#=  =#
#=  =#
#= @testset "reordc" begin =#
#=     array = ["one", "three", "two", "zero"] =#
#=     iorder = [3, 0, 2, 1] =#
#=     outarray = reordc(iorder, 4, 5, array) =#
#=     # reordc appears to be broken... =#
#=     with pytest.raises(AssertionError): =#
#=         assert outarray == ["zero", "one", "two", "three"] =#
#=  =#
#= @testset "reordd" begin =#
#=     array = [1.0, 3.0, 2.0] =#
#=     iorder = [0, 2, 1] =#
#=     outarray = reordd(iorder, 3, array) =#
#=     npt.assert_array_almost_equal(outarray, [1.0, 2.0, 3.0]) =#
#=  =#
#=  =#
#= @testset "reordi" begin =#
#=     array = [1, 3, 2] =#
#=     iorder = [0, 2, 1] =#
#=     outarray = reordi(iorder, 3, array) =#
#=     npt.assert_array_almost_equal(outarray, [1, 2, 3]) =#
#=  =#
#=  =#
#= @testset "reordl" begin =#
#=     array = [True, True, False] =#
#=     iorder = [0, 2, 1] =#
#=     outarray = reordl(iorder, 3, array) =#
#=     npt.assert_array_almost_equal(outarray, [True, False, True]) =#
#=  =#
#=  =#
#= @testset "repmc" begin =#
#=     stringtestone = "The truth is #" =#
#=     outstringone = repmc(stringtestone, "#", "SPICE") =#
#=     assert outstringone == "The truth is SPICE" =#
#=  =#
#=  =#
#= @testset "repmct" begin =#
#=     stringtestone = "The value is #" =#
#=     outstringone = repmct(stringtestone, '#', 5, 'U') =#
#=     outstringtwo = repmct(stringtestone, '#', 5, 'l') =#
#=     assert outstringone == "The value is FIVE" =#
#=     assert outstringtwo == "The value is five" =#
#=  =#
#=  =#
#= @testset "repmd" begin =#
#=     stringtestone = "The value is #" =#
#=     outstringone = repmd(stringtestone, '#', 5.0e11, 1) =#
#=     assert outstringone == "The value is 5.E+11" =#
#=  =#
#=  =#
#= @testset "repmf" begin =#
#=     stringtestone = "The value is #" =#
#=     outstringone = repmf(stringtestone, '#', 5.0e3, 5, 'f') =#
#=     outstringtwo = repmf(stringtestone, '#', -5.2e-9, 3, 'e') =#
#=     assert outstringone == "The value is 5000.0" =#
#=     assert outstringtwo == "The value is -5.20E-09" =#
#=  =#
#=  =#
#= @testset "repmi" begin =#
#=     stringtest = "The value is <opcode>" =#
#=     outstring = repmi(stringtest, "<opcode>", 5) =#
#=     assert outstring == "The value is 5" =#
#=  =#
#=  =#
#= @testset "repmot" begin =#
#=     stringtestone = "The value is #" =#
#=     outstringone = repmot(stringtestone, '#', 5, 'U') =#
#=     outstringtwo = repmot(stringtestone, '#', 5, 'l') =#
#=     assert outstringone == "The value is FIFTH" =#
#=     assert outstringtwo == "The value is fifth" =#
#=  =#
#=  =#
#= @testset "reset" begin =#
#=     reset() =#
#=     assert not failed() =#
#=  =#
#=  =#
#= @testset "return_c" begin =#
#=     reset() =#
#=     assert not return_c() =#
#=     reset() =#
#=  =#
#=  =#
    @testset "rotate" begin
        act = rotate(π / 4, 3)
        exp = [sqrt(2) / 2.0 sqrt(2) / 2.0 0.0;
              -sqrt(2) / 2.0 sqrt(2) / 2.0 0.0;
               0.0 0.0 1.0]
        @testset for i in eachindex(act, exp)
             @test act[i] ≈ exp[i]
        end
    end
#= @testset "rotmat" begin =#
#=     ident = ident() =#
#=     expectedR = [[0.0, 0.0, -1.0], =#
#=                  [0.0, 1.0, 0.0], =#
#=                  [1.0, 0.0, 0.0]] =#
#=     rOut = rotmat(ident, halfpi(), 2) =#
#=     npt.assert_array_almost_equal(rOut, expectedR) =#
#=  =#
#=  =#
#= @testset "rotvec" begin =#
#=     vin = [sqrt(2), 0.0, 0.0] =#
#=     angle = pi() / 4 =#
#=     iaxis = 3 =#
#=     vExpected = [1.0, -1.0, 0.0] =#
#=     vout = rotvec(vin, angle, iaxis) =#
#=     npt.assert_array_almost_equal(vout, vExpected) =#
#=  =#
#=  =#
#= @testset "rpd" begin =#
#=     assert rpd() == arccos(-1.0) / 180.0 =#
#=  =#
#=  =#
#= @testset "rquad" begin =#
#=     # solve x^2 + 2x + 3 = 0 =#
#=     root1, root2 = rquad(1.0, 2.0, 3.0) =#
#=     expectedRootOne = [-1.0, sqrt(2.0)] =#
#=     expectedRootTwo = [-1.0, -sqrt(2.0)] =#
#=     npt.assert_array_almost_equal(root1, expectedRootOne) =#
#= npt.assert_array_almost_equal(root2, expectedRootTwo) =#
end
