@testset "M" begin 
    let 
        matrix = [1. 1. 1. 
                2. 3. 4.]
        vecgood = [1., 2., 3.]
        @test SPICE._mxvg(matrix, vecgood) == [6.,20.]
    end
    let 
        r = rotate(π/2, 3)
        act = m2q(r)
        exp = [sqrt(2)/2.0, 0.0, 0.0, -sqrt(2)/2.0]
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
    end
end 