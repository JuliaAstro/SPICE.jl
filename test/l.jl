@testset "L" begin
    let str="ABCDE"
        @test lastnb(str) == 4
        str="AN EXAMPLE"
        @test lastnb(str) == 9
        str="AN EXAMPLE        "
        @test lastnb(str) == 9
        str="        "
        @test lastnb(str) == -1
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

    # TODO: code doesnt work, can't pass the test, needs to be modified
    # kclear()
    # furnsh(path(EXTRA, :phobos_dsk))
    # let srfpts = latsrf("DSK/UNPRIORITIZED", "phobos", 0.0, "iau_phobos", [0.0 45.0; 60.0 45.0])  
    #     radius1 = collect(recrad(srfpts[:,1]))[1]
    #     radius2 = collect(recrad(srfpts[:,2]))[1]
    #     @test radius1 > 9.77  
    #     @test radius2 > 9.51 
    #     kclear()
    # end
end
