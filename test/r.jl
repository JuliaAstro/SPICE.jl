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
end
