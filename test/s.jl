using LinearAlgebra: I, norm

@testset "S" begin
    @testset "scard" begin
        cell = SpiceDoubleCell(10)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        @test card(cell) == 0
        for w in darray
            wninsd!(cell, w...)
        end
        @test card(cell) == 6
        scard!(cell, 0)
        @test card(cell) == 0
    end
    @test spd() == 86400.0
    furnsh(path(CORE, :spk))
    @test sxform("J2000", "J2000", 0.0) ≈ Matrix{Float64}(I, 6, 6)
    @test_throws SpiceError sxform("J2000", "Norbert", 0.0)
    @test spkezr("EARTH", 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkezr(399, 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkezr("EARTH", 0.0, "J2000", 399) == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkezr(399, 0.0, "J2000", 399) == ([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 0.0)
    @test spkpos("EARTH", 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0], 0.0)
    @test spkpos(399, 0.0, "J2000", "EARTH") == ([0.0, 0.0, 0.0], 0.0)
    @test spkpos("EARTH", 0.0, "J2000", 399) == ([0.0, 0.0, 0.0], 0.0)
    @test spkpos(399, 0.0, "J2000", 399) == ([0.0, 0.0, 0.0], 0.0)
    kclear()


    @testset "subslr" begin
        try
            furnsh(
                path(CORE, :lsk),
                path(CORE, :pck),
                path(CORE, :spk),
            )
            et = str2et("2008 aug 11 00:00:00")
            re, _, rp = bodvrd("MARS", "RADII", 3)
            f = (re - rp) / re
            methods = ["INTERCEPT/ELLIPSOID", "NEAR POINT/ELLIPSOID"]
            expecteds = [
                [
                    0.0,
                    175.8106755102322,
                    23.668550281477703,
                    -175.81067551023222,
                    23.420819936106213,
                    175.810721536362,
                    23.42082337182491,
                    -175.810721536362,
                    23.42081994605096,
                ],
                [
                    0.0,
                    175.8106754100492,
                    23.420823361866685,
                    -175.81067551023222,
                    23.175085577910583,
                    175.81072152220804,
                    23.420823371828,
                    -175.81072152220804,
                    23.420819946054046,
                ]
            ]
            for (expected, method) in zip(expecteds, methods)
                spoint, trgepc, srfvec = subslr(method, "Mars", et, "IAU_MARS", "Earth", abcorr="LT+S")
                spglon, spglat, spgalt = recpgr("mars", spoint, re, f)

                @test spgalt ≈ expected[1]
                @test rad2deg(spglon) ≈ expected[2]
                @test rad2deg(spglat) ≈ expected[3]
                spcrad, spclon, spclat = reclat(spoint)
                @test rad2deg(spclon) ≈ expected[4]
                @test rad2deg(spclat) ≈ expected[5]
                sunpos, sunlt = spkpos("sun", trgepc, "iau_mars", "mars", abcorr="LT+S")
                supgln, supglt, supgal = recpgr("mars", sunpos, re, f)
                @test rad2deg(supgln) ≈ expected[6]
                @test rad2deg(supglt) ≈ expected[7]
                supcrd, supcln, supclt = reclat(sunpos)
                @test rad2deg(supcln) ≈ expected[8]
                @test rad2deg(supclt) ≈ expected[9]
            end
        finally
            kclear()
        end
    end

    @testset "subpnt" begin
        try
            furnsh(
                path(CORE, :lsk),
                path(CORE, :pck),
                path(CORE, :spk),
            )
            et = str2et("2008 aug 11 00:00:00")
            re, _, rp = bodvrd("MARS", "RADII", 3)
            f = (re - rp) / re
            methods = ["Intercept:  ellipsoid", "Near point: ellipsoid"]
            expecteds = [
                [
                    349199089.604657, 
                    349199089.64135259, 
                    0.0, 
                    199.30230503198658, 
                    199.30230503198658,
                    26.262401237213588, 
                    25.99493675077423, 
                    160.69769496801342, 
                    160.69769496801342,
                    25.994934171245205, 
                    25.994934171245202,
                ],
                [
                    349199089.6046486, 
                    349199089.60464859, 
                    0.0, 
                    199.30230503240247, 
                    199.30230503240247,
                    25.99493675092049, 
                    25.99493675092049, 
                    160.69769496759753, 
                    160.69769496759753,
                    25.729407227461937, 
                    25.994934171391463,
                ]
            ]
            for (expected, method) in zip(expecteds, methods)
                spoint, trgepc, srfvec = subpnt(method, "Mars", et, "IAU_MARS", "earth", abcorr="LT+S")
                odist = norm(srfvec)
                @test odist ≈ expected[2]
                spglon, spglat, spgalt = recpgr("mars", spoint, re, f)
                @test spgalt ≈ expected[3]
                @test rad2deg(spglon) ≈ expected[4]
                @test rad2deg(spglat) ≈ expected[6]
                spcrad, spclon, spclat = reclat(spoint)
                @test rad2deg(spclon) ≈ expected[8]
                @test rad2deg(spclat) ≈ expected[10]
                obspos = spoint - srfvec
                opglon, opglat, opgalt = recpgr("mars", obspos, re, f)
                @test opgalt ≈ expected[1]
                @test rad2deg(opglon) ≈ expected[5]
                @test rad2deg(opglat) ≈ expected[7]
                opcrad, opclon, opclat = reclat(obspos)
                @test rad2deg(opclon) ≈ expected[9]
                @test rad2deg(opclat) ≈ expected[11]
            end
        finally
            kclear()
        end
    end

end

