import LinearAlgebra

@testset "T" begin
    @testset "termpt" begin
        try
            furnsh(path(CORE, :spk),
                   path(CORE, :pck),
                   path(CORE, :lsk),
                   path(EXTRA, :mars_spk),
                   path(EXTRA, :phobos_dsk))
            et = str2et("1972 AUG 11 00:00:00")
            points, epochs, tangts = termpt("UMBRAL/TANGENT/DSK/UNPRIORITIZED", "SUN",
                                            "PHOBOS", et, "IAU_PHOBOS", "CN+S", "CENTER",
                                            "MARS", [0.0, 0.0, 1.0], 2/3 * π, 3, 1.0e-4,
                                            1.0e-7, 10000)
            @test length(points) == 3
        finally
            kclear()
        end
    end
    @testset "timdef" begin
        try
            furnsh(path(CORE, :lsk))
            # Calendar - default is Gregorian
            value = timdef(:GET, :CALENDAR)
            @test value in ("GREGORIAN", "JULIAN", "MIXED")
            # System - ensure it changes the str2et results
            @test timdef(:GET, :SYSTEM) == "UTC"
            # Approximately 64.184
            et = str2et("2000-01-01T12:00:00")
            # Change to TDB system
            @test timdef(:SET, :SYSTEM, "TDB") == "TDB"
            @test str2et("2000-01-01T12:00:00") == 0.0
            # Change back to UTC system
            @test timdef(:SET, :SYSTEM, "UTC") == "UTC"
            @test str2et("2000-01-01T12:00:00") == et

            # This should throw according to the docs but doesn't
            # @test_throws SpiceError timdef(:TEST, :SYSTEM)

            @test_throws SpiceError timdef(:GET, :TEST)
        finally
            kclear()
        end
    end
    @testset "timout" begin
        try
            furnsh(path(CORE, :lsk))
            sample = "Thu Oct 1 11:11:11 PDT 1111"
            pic = tpictr(sample)
            et = 188745364.0
            out = timout(et, pic)
            @test out == "Sat Dec 24 18:14:59 PDT 2005"
            @test_throws SpiceError timout(et, "")
        finally
            kclear()
        end
    end
    @testset "tipbod" begin
        ref = [0.70041408 0.70486133 -0.11220794;
            -0.70859907 0.70555446 0.00895915;
            0.08548377 0.07323533 0.99364436]
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck))
            et = str2et("Jan 1 2005")
            tipm = tipbod("J2000", 699, et)
            @testset for i in eachindex(ref, tipm)
                @test tipm[i] ≈ ref[i] atol=1e-8
            end
        finally
            kclear()
        end
    end
    @testset "tisbod" begin
        ref = [
            0.70041408 0.70486133 -0.11220794 0.00000000E+00 0.00000000E+00 0.00000000E+00;
            -0.70859907 0.70555446 0.00895915 0.00000000E+00 0.00000000E+00 0.00000000E+00;
            0.08548377 0.07323533 0.99364436 0.00000000E+00 0.00000000E+00 0.00000000E+00;
            -0.00011606 0.00011556 1.46737366E-06 0.70041408 0.70486133 -0.11220794;
            -0.00011472 -0.00011545 1.83779762E-05 -0.70859907 0.70555446 0.00895915;
            3.12746980E-14 -2.71850372E-15 -2.49021541E-15 0.08548377 0.07323533 0.99364436;
        ]
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck))
            et = str2et("Jan 1 2005")
            tsipm = tisbod("J2000", 699, et)
            @testset for i in eachindex(ref, tsipm)
                @test tsipm[i] ≈ ref[i] atol=1e-8
            end
        finally
            kclear()
        end
    end
    @testset "tkvrsn" begin
        @test tkvrsn() == "CSPICE_N0066"
    end
    @testset "tparse" begin
        actual1 = tparse("1996-12-18T12:28:28")
        @test actual1 == -95815892.0
        actual2 = tparse("1 DEC 1997 12:28:29.192")
        @test actual2 == -65748690.808
        actual3 = tparse("1997-162::12:18:28.827")
        @test actual3 == -80696491.173
        @test_throws SpiceError tparse("test")
    end
    @testset "tpictr" begin
        test_string = "10:23 P.M. PDT January 3, 1993"
        pictur = tpictr(test_string)
        @test pictur == "AP:MN AMPM PDT Month DD, YYYY ::UTC-7"
        @test_throws SpiceError tpictr("test")
    end
    @testset "trace" begin
        a = randn(3, 3)
        @test SPICE._trace(a) ≈ LinearAlgebra.tr(a)
    end
    @testset "tsetyr" begin
        # Expand 2-digit year to full year, typically 4-digit
        tmp_getyr4 = (iy2) -> parse(Int,
            split(etcal(tparse("3/3/$(lpad(iy2, 2, string(0)))")))[1])
        # Find current lower bound on the 100 year interval of expansion,
        # so it can be restored on exit
        tsetyr_lowerbound = tmp_getyr4(0)
        for iy2_test in 0:99
            tmp_lowerbound =  tmp_getyr4(iy2_test)
            if tmp_lowerbound < tsetyr_lowerbound
                tsetyr_lowerbound = tmp_lowerbound
                break
            end
        end
        # Run first case with a year not ending in 00
        tsetyr_y2 = tsetyr_lowerbound % 100
        tsetyr_y4 = tsetyr_lowerbound + 200 + ((tsetyr_y2 == 0) && 50 || 0)
        tsetyr(tsetyr_y4)
        @test tmp_getyr4(tsetyr_y4 % 100) == tsetyr_y4
        @test tmp_getyr4((tsetyr_y4-1) % 100) == (tsetyr_y4+99)
        # Run second case with a year ending in 00
        tsetyr_y4 -= (tsetyr_y4 % 100)
        tsetyr(tsetyr_y4)
        @test tmp_getyr4(tsetyr_y4 % 100) == tsetyr_y4
        @test tmp_getyr4((tsetyr_y4-1) % 100) == (tsetyr_y4+99)
        # Cleanup:  reset lowerbound to what it was when this routine started
        tsetyr_y4 = tsetyr_lowerbound
        tsetyr(tsetyr_y4)
        @test tmp_getyr4(tsetyr_y4 % 100) == tsetyr_y4
        @test tmp_getyr4((tsetyr_y4-1) % 100) == (tsetyr_y4+99)
    end
    @testset "twopi" begin
        @test SPICE._twopi() ≈ 2π
    end
    @testset "twovec" begin
        axdef = [1.0, 0.0, 0.0]
        plndef = [0.0, -1.0, 0.0]
        expected = [1.0 0.0 0.0; 0.0 -1.0 0.0; 0.0 0.0 -1.0]
        @test twovec(axdef, 1, plndef, 2) ≈ expected
        @test_throws ArgumentError twovec(axdef[1:2], 1, plndef, 2)
        @test_throws ArgumentError twovec(axdef, 1, plndef[1:2], 2)
        @test_throws SpiceError twovec(axdef, 1, plndef, 1)
        @test_throws SpiceError twovec(axdef, 1, plndef, 4)
        @test_throws SpiceError twovec(axdef, 1, axdef, 2)
    end
    @testset "tyear" begin
        @test tyear() == 3.15569259747e7
    end
end
