@testset "L" begin
    let str="ABCDE"
        @test lastnb(str) == 5
        str="AN EXAMPLE"
        @test lastnb(str) == 10
        str="AN EXAMPLE        "
        @test lastnb(str) == 10
        str="        "
        @test lastnb(str) == 0
    end
    let exp1 = [1.0, 0.0, 0.0]
        exp2 = [1.0, deg2rad(90.0), 0.0]
        exp3 = [1.0, deg2rad(180.0), 0.0]
        act1=collect(latcyl(1.0, 0.0, 0.0))
        act2=collect(latcyl(1.0, deg2rad(90.0), 0.0))
        act3=collect(latcyl(1.0, deg2rad(180.0), 0.0))
        @testset for i in eachindex(act1, exp1)
            @test isapprox(act1[i],exp1[i],atol=1e-16)
        end
        @testset for i in eachindex(act2, exp2)
            @test isapprox(act2[i],exp2[i],atol=1e-16)
        end
        @testset for i in eachindex(act3, exp3)
            @test isapprox(act3[i],exp3[i],atol=1e-16)
        end
    end
    let exp1 = [1.0, 0.0, 0.0]
        exp2 = [0.0, 1.0, 0.0]
        exp3 = [-1.0, 0.0, 0.0]
        act1 = latrec(1.0, 0.0, 0.0)
        act2 = latrec(1.0, deg2rad(90.0), 0.0)
        act3 = latrec(1.0, deg2rad(180.0), 0.0)
        @testset for i in eachindex(act1, exp1)
            @test isapprox(act1[i],exp1[i],atol=1e-15)
        end
        @testset for i in eachindex(act2, exp2)
            @test isapprox(act2[i],exp2[i],atol=1e-15)
        end
        @testset for i in eachindex(act3, exp3)
            @test isapprox(act3[i],exp3[i],atol=1e-15)
        end
    end
    let exp1 = [1.0, deg2rad(90), 0.0]
        exp2 = [1.0, deg2rad(90), deg2rad(90)]
        exp3 = [1.0, deg2rad(90), deg2rad(180)]
        act1 = collect(latsph(1.0, 0.0, 0.0))
        act2 = collect(latsph(1.0, deg2rad(90), 0.0))
        act3 = collect(latsph(1.0, deg2rad(180), 0.0))
        @testset for i in eachindex(act1, exp1)
            @test isapprox(act1[i],exp1[i],atol=1e-15)
        end
        @testset for i in eachindex(act2, exp2)
            @test isapprox(act2[i],exp2[i],atol=1e-15)
        end
        @testset for i in eachindex(act3, exp3)
            @test isapprox(act3[i],exp3[i],atol=1e-15)
        end
    end

    kclear()
    furnsh(path(EXTRA, :phobos_dsk))
    let srfpts = latsrf("DSK/UNPRIORITIZED", "phobos", 0.0, "iau_phobos", [0.0 45.0; 60.0 45.0])
        radii = [recrad(pt)[1] for pt in srfpts]
        @test radii[1] > 9.77
        @test radii[2] > 9.51
        kclear()
    end

    @test SPICE._lcase("THIS IS AN EXAMPLE") == "this is an example"
    @test SPICE._lcase("1234") == "1234"

    kclear()
    let kerneltemp = tempfile()
        try
            ldpoolNames = ["DELTET/DELTA_T_A", "DELTET/K", "DELTET/EB", "DELTET/M", "DELTET/DELTA_AT"]
            ldpoolLens = [1, 1, 1, 2, 46]
            textbuf = ["DELTET/DELTA_T_A = 32.184",
            "DELTET/K         = 1.657D-3",
            "DELTET/EB        = 1.671D-2",
            "DELTET/M         = ( 6.239996 1.99096871D-7 )",
            "DELTET/DELTA_AT  = ( 10, @1972-JAN-1",
            "                     11, @1972-JUL-1",
            "                     12, @1973-JAN-1",
            "                     13, @1974-JAN-1",
            "                     14, @1975-JAN-1",
            "                     15, @1976-JAN-1",
            "                     16, @1977-JAN-1",
            "                     17, @1978-JAN-1",
            "                     18, @1979-JAN-1",
            "                     19, @1980-JAN-1",
            "                     20, @1981-JUL-1",
            "                     21, @1982-JUL-1",
            "                     22, @1983-JUL-1",
            "                     23, @1985-JUL-1",
            "                     24, @1988-JAN-1",
            "                     25, @1990-JAN-1",
            "                     26, @1991-JAN-1",
            "                     27, @1992-JUL-1",
            "                     28, @1993-JUL-1",
            "                     29, @1994-JUL-1",
            "                     30, @1996-JAN-1",
            "                     31, @1997-JUL-1",
            "                     32, @1999-JAN-1 )"]
            kernelFile = open(kerneltemp, "w")
            write(kernelFile, "\\begindata\n")
            for line in textbuf
                write(kernelFile, string(line, "\n"))
            end
            write(kernelFile, "\\begintext\n")
            close(kernelFile)
            ldpool(kerneltemp)
            for (var, expectLen) in zip(ldpoolNames, ldpoolLens)
                n, vartype = dtpool(var)
                @test expectLen == n
                @test vartype == :N
            end
        finally
            kclear()
            rm(kerneltemp, force=true)
        end
    
        kclear()
        rm(kerneltemp, force=true)        
        
    end

    p, dp = lgrind([-1.0, 0.0, 1.0, 3.0], [-2.0, -7.0, -8.0, 26.0], 2.0)
    @test p ≈ 1.0
    @test dp ≈ 16.0

    kclear()
    furnsh(
        path(CORE, :spk),
        path(CORE, :pck),
        path(CORE, :lsk),
        path(EXTRA, :mars_spk),
        path(EXTRA, :phobos_dsk))
    let et = str2et("1972 AUG 11 00:00:00")
        npts, points, epochs, tangts = limbpt("TANGENT/DSK/UNPRIORITIZED", "Phobos", et, "IAU_PHOBOS",
                                              "CN+S", "CENTER", "MARS", [0.0, 0.0, 1.0], 2*π/3.0,
                                              3, 1.0e-4, 1.0e-7, 10000)
        @test size(points)[2] == 3
    end
    kclear()

    kclear()
    let lmpoolNames = ["DELTET/DELTA_T_A", "DELTET/K", "DELTET/EB", "DELTET/M", "DELTET/DELTA_AT"]
        lmpoolLens = [1, 1, 1, 2, 46]
        textbuf = ["DELTET/DELTA_T_A = 32.184",
                    "DELTET/K         = 1.657D-3",
                    "DELTET/EB        = 1.671D-2",
                    "DELTET/M         = ( 6.239996 1.99096871D-7 )",
                    "DELTET/DELTA_AT  = ( 10, @1972-JAN-1",
                    "                     11, @1972-JUL-1",
                    "                     12, @1973-JAN-1",
                    "                     13, @1974-JAN-1",
                    "                     14, @1975-JAN-1",
                    "                     15, @1976-JAN-1",
                    "                     16, @1977-JAN-1",
                    "                     17, @1978-JAN-1",
                    "                     18, @1979-JAN-1",
                    "                     19, @1980-JAN-1",
                    "                     20, @1981-JUL-1",
                    "                     21, @1982-JUL-1",
                    "                     22, @1983-JUL-1",
                    "                     23, @1985-JUL-1",
                    "                     24, @1988-JAN-1",
                    "                     25, @1990-JAN-1",
                    "                     26, @1991-JAN-1",
                    "                     27, @1992-JUL-1",
                    "                     28, @1993-JUL-1",
                    "                     29, @1994-JUL-1",
                    "                     30, @1996-JAN-1",
                    "                     31, @1997-JUL-1",
                    "                     32, @1999-JAN-1 )"]
        lmpool(textbuf)
        for (var, expectLen) in zip(lmpoolNames, lmpoolLens)
            n, vartype = dtpool(var)
            expectLen == n
            vartype == :N
        end
    end
    kclear()

    let stringtest = "one two three four"
        exp = ["one", "two", "three", "four"]
        act = lparse(stringtest, " ", 25)
        @testset for i in eachindex(act, exp)
            @test act[i] == exp[i]
        end
    end

    let stringtest = "  A number of words   separated   by spaces   "
        exp = ["A", "number", "of", "words", "separated", "by", "spaces"]
        act = lparsm(stringtest, " ", 20, 23)
        @testset for i in eachindex(act, exp)
            @test act[i] == exp[i]
        end
        act = lparsm(stringtest, " ", length(stringtest)+10)
        @testset for i in eachindex(act, exp)
            @test act[i] == exp[i]
        end
    end

    # WIP
    let stringtest = "  A number of words   separated   by spaces.   "
        delims = " ,."
        act = lparss(stringtest, delims)
        exp = ["", "A", "by", "number", "of", "separated", "spaces", "words"]
        @testset for i in 1:length(exp)
            @test act[i] == exp[i]
        end
    end
    
    # WIP
    # kclear()
    # furnsh(path(CORE, :lsk))
    # let et = str2et("21 march 2005")
    #     lon = rad2deg(lspcn("EARTH", et, "NONE"))
    # end
    # kclear()
    # @test lon ≈ 0.48153755894179384

    let array = ["BOHR", "EINSTEIN", "FEYNMAN", "GALILEO", "NEWTON"]
        @test lstlec("NEWTON", array) == 5
        @test lstlec("EINSTEIN", array) == 2
        @test lstlec("GALILEO", array) == 4
        @test lstlec("Galileo", array) == 4
        @test lstlec("BETHE", array) == 0
    end

    let array = [-2.0, -2.0, 0.0, 1.0, 1.0, 11.0]
        @test lstled(-3.0, array) == 0
        @test lstled(-2.0, array) == 2
        @test lstled(0.0, array) == 3
        @test lstled(1.0, array) == 5
        @test lstled(11.1, array) == 6
    end

    # ERROR: doesnt pass its test
    # let array = [-2, -2, 0, 1, 1, 11]
    #     @test lstlei(-3, array) == 0
    #     @test lstlei(-2, array) == 2
    #     @test lstlei(0, array) == 3
    #     @test lstlei(1, array) == 5
    #     @test lstlei(12, array) == 6
    # end

    let array = ["BOHR", "EINSTEIN", "FEYNMAN", "GALILEO", "NEWTON"]
        @test lstltc("NEWTON", array) == 4
        @test lstltc("EINSTEIN", array) == 1
        @test lstltc("GALILEO", array) == 3
        @test lstltc("Galileo", array) == 4
        @test lstltc("BETHE", array) == 0
    end

    let array = [-2.0, -2.0, 0.0, 1.0, 1.0, 11.0]
        @test lstltd(-3.0, array) == 0
        @test lstltd(-2.0, array) == 0
        @test lstltd(0.0, array) == 2
        @test lstltd(1.0, array) == 3
        @test lstltd(11.1, array) == 6
    end

    # ERROR: doesnt pass its test
    # let array = [-2, -2, 0, 1, 1, 11]
    #     @test lstlti(-3, array) == 0
    #     @test lstlti(-2, array) == 0
    #     @test lstlti(0, array) == 2
    #     @test lstlti(1, array) == 3
    #     @test lstlti(12, array) == 6
    # end

    # kclear()
    # furnsh(path(CORE, :lsk))
    # let OBS = 399   
    #     TARGET = 5   
    #     TIME_STR = "July 4, 2004"    
    #     et = str2et(TIME_STR)   
    #     arrive, ltime_act = ltime(et, OBS, "->", TARGET) 
    #     arrive_utc = et2utc(arrive, "C", 3)
    #     @test ltime_act ≈ 2918.71705
    #     @test arrive_utc == "2004 JUL 04 00:48:38.717"
    #     receive, rtime_act = ltime(et, OBS, "<-", TARGET)
    #     receive_utc = et2utc(receive, "C", 3)
    #     @test rtime_act ≈ 2918.75247
    #     @test receive_utc == "2004 JUL 03 23:11:21.248"
    # end
    # kclear()

    
    @test lx4dec("1%2%3", 1) == (1, 1)
    @test lx4dec("1%2%3", 2) == (1, 0)
    @test lx4dec("1%2%3", 3) == (3, 1)

    @test lx4num("1%2%3", 1) == (1, 1)
    @test lx4num("1%2%3", 2) == (1, 0)
    @test lx4num("1%2%3", 3) == (3, 1)
    @test lx4num("1%2e1%3", 3) == (5, 3)

    @test lx4sgn("1%2%3", 1) == (1, 1)
    @test lx4sgn("1%2%3", 2) == (1, 0)
    @test lx4sgn("1%2%3", 3) == (3, 1)

    @test lx4uns("test 10 end", 5) == (4, 0)

    # This doesn't pass its tests
    @test lxqstr("The 'SPICE' system", "\'", 5) == (11, 7)
    @test lxqstr("The 'SPICE' system", "'", 5) == (11, 7)
    @test lxqstr("The 'SPICE' system", "'", 1) == (0, 0)
    @test lxqstr("The 'SPICE' system", "'", 5) == (4, 0)
    @test lxqstr("The '''SPICE'''' system", "'", 5) == (15, 11)
    @test lxqstr("The &&&SPICE system", "&", 5) == (6, 2)
    @test lxqstr("' '", "'", 1) == (3, 3)
    @test lxqstr("''", "'", 1) == (2, 2)
end
