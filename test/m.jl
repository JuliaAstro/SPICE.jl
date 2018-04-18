@testset "M" begin 
    matrix = [1. 1. 1. 
                2. 3. 4.]
    vecgood = [1., 2., 3.]
    @test mxvg(matrix, vecgood) == [6.,20.]
end 