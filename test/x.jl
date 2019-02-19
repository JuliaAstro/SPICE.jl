@testset "X" begin
    @testset "xf2eul" begin
        try
            furnsh(path(CORE, :pck))
            sx = sxform("J2000", "IAU_JUPITER", 0.0)
            eulang, unique = xf2eul(sx, 3, 1, 3)
            @test eulang ≈ [-3.10768, 0.44513, -1.83172, -0.0, 0.0, 0.0] rtol=1e-5
            @test_throws SpiceError xf2eul(sx, 4, 1, 4)
            @test_throws ArgumentError xf2eul(randn(3,3), 3, 1, 3)
        finally
            kclear()
        end
    end
    @testset "xf2rav" begin
        e1 = [1.0, 0.0, 0.0]
        rz1 = [0.0 1.0 0.0; -1.0 0.0 0.0; 0.0 0.0 1.0]
        xform = rav2xf(rz1, e1)
        rz2, e2 = xf2rav(xform)
        @test e1 ≈ e2
        @test rz1 ≈ rz2
        @test_throws ArgumentError xf2rav(randn(3, 3))
    end
    @testset "xfmsta" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("July 4, 2003 11:00 AM PST")
            state, lt = spkezr("Mars", et, "J2000", "LT+S", "Earth")
            expected_lt = 269.6898813661505
            expected_state = [7.38222353105354905128e+07,  -2.71279189984722770751e+07,
                              -1.87413063014898747206e+07,  -6.80851334001380692484e+00,
                              7.51399612408221173609e+00,   3.00129849265935222391e+00]
            @test lt ≈ expected_lt
            @test state ≈ expected_state
            state_lat = xfmsta(state, "rectangular", "latitudinal", " ")
            expected_lat_state = [8.08509924324866235256e+07,  -3.52158255331780634112e-01,
                                  -2.33928262716770696272e-01,  -9.43348972618204761886e+00,
                                   5.98157681117165682860e-08,   1.03575559016377728336e-08]
            @test state_lat ≈ expected_lat_state
            @test_throws ArgumentError xfmsta(state[1:5], "rectangular", "latitudinal", " ")
        finally
            kclear()
        end
    end
    @testset "xpose6" begin
        a = randn(6, 6)
        @test SPICE._xpose6(a) == transpose(a)
    end
    @testset "xposeg" begin
        a = randn(6, 6)
        @test SPICE._xposeg(a) == transpose(a)
    end
    @testset "xpose" begin
        a = randn(3, 3)
        @test SPICE._xpose(a) == transpose(a)
    end
    @testset "xposeg" begin
        a = randn(3, 3)
        @test SPICE._xposeg(a) == transpose(a)
        a = randn(3, 5)
        @test SPICE._xposeg(a) == transpose(a)
    end
end
