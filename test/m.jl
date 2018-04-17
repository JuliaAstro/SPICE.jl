#= mxvg is Severely Broken, test below does not work and dont know why!
 Perform the following calculation: 1*1 + 2*2 + 1*3, 3*1 + 1*2 + 4*3
@testset "M" begin 
    matrix = [1. 1. 1. 
                2. 3. 4.]
    vecgood = [1., 2., 3.]
    @test mxvg(matrix, vecgood) == [6.,20.]
end 
=#