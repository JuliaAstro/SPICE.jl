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

    # WIP
    kclear()
    let kernel = tempfile()
        try ldpoolNames = ["DELTET/DELTA_T_A", "DELTET/K", "DELTET/EB", "DELTET/M", "DELTET/DELTA_AT"]
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
            kernelFile = open(kernel, 'w') 
            kernelFile.write('\\begindata\n')
            for line in textbuf:
                kernelFile.write(line + "\n")
            end
            kernelFile.write("\\begintext\n")
            kernelFile.close()
            ldpool(kernel)
            for (var, expectLen) in zip(ldpoolNames, ldpoolLens):
                n, vartype = dtpool(var)
                @test expectLen == n
                @test vartype == 'N'
            end
        finally 
            kclear()
            rm(kernel, force=true)
        end
    end

    p, dp = lgrind([-1.0, 0.0, 1.0, 3.0], [-2.0, -7.0, -8.0, 26.0], 2.0)
    @test p ≈ 1.0
    @test dp ≈ 16.0

    kclear()
    furnsh(path(CORE, :spk),path(EXTRA, :mars_spk),path(CORE, :pck),path(CORE, :lsk),path(EXTRA, :phobos_dsk))
    let et = str2et("1972 AUG 11 00:00:00")
        npts, points, epochs, tangts = limbpt("TANGENT/DSK/UNPRIORITIZED", "Phobos", et, "IAU_PHOBOS",
                                              "CN+S", "CENTER", "MARS", [0.0, 0.0, 1.0], 2*π/3.0,
                                              3, 1.0e-4, 1.0e-7, 10000)
        @test size(points)[2] == 3
    end
    kclear()
end
