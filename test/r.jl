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

    
end 