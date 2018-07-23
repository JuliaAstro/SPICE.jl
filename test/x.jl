@testset "X" begin
    let
        furnsh(path(CORE, :pck))
        sx = sxform("J2000", "IAU_JUPITER", 0.0)
        eulang, unique = xf2eul(sx, 3, 1, 3)
        @test eulang ≈ [-3.10768, 0.44513, -1.83172, -0.0, 0.0, 0.0] rtol=1e-5
        @test_throws SpiceException xf2eul(sx, 4, 1, 4)
        unload(path(CORE, :pck))
    end
    let
        e1 = [1.0, 0.0, 0.0]
        rz1 = [0.0 1.0 0.0; -1.0 0.0 0.0; 0.0 0.0 1.0]
        xform = rav2xf(rz1, e1)
        rz2, e2 = xf2rav(xform)
        @test e1 ≈ e2
        @test rz1 ≈ rz2
    end
    let
        furnsh(path(CORE, :lsk), path(CORE, :spk))
        et = str2et("July 4, 2003 11:00 AM PST")
        state, lt = spkezr("Mars", et, "J2000", "Earth", abcorr="LT+S")
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
        kclear()
    end
    let a = randn(6, 6)
        @test SPICE._xpose6(a) == transpose(a)
        @test SPICE._xposeg(a) == transpose(a)
    end
    let a = randn(3, 3)
        @test SPICE._xpose(a) == transpose(a)
        @test SPICE._xposeg(a) == transpose(a)
    end
    let a = randn(3, 5)
        @test SPICE._xposeg(a) == transpose(a)
    end
end
