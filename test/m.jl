@testset "M" begin 
    let 
        matrix = [1. 1. 1. 
                2. 3. 4.]
        vecgood = [1., 2., 3.]
        @test mxvg(matrix, vecgood) == [6.,20.]
    end

    let 
        # r = spice.rotate(spice.halfpi(), 3)

        # q = spice.m2q(r)

        # expected = [np.sqrt(2) / 2.0, 0.0, 0.0, -np.sqrt(2) / 2.0]

        # np.testing.assert_array_almost_equal(expected, q, decimal = 6)
    end
end 