@testset "Q" begin
    let expected = [0.607843137254902 0.27450980392156854 0.7450980392156862;
                0.6666666666666666 0.33333333333333326 -0.6666666666666666;
                -0.43137254901960775 0.9019607843137255 0.019607843137254832]
        actual = q2m(0.5, 0.4, 0.3, 0.1)
        @testset for i in eachindex(actual, expected)
            @test actual[i] ≈ expected[i]
        end
        q = [0.5, 0.4, 0.3, 0.1]
        actual = q2m(q)
        @testset for i in eachindex(actual, expected)
            @test actual[i] ≈ expected[i]
        end
        q = (0.5, 0.4, 0.3, 0.1)
        actual = q2m(q)
        @testset for i in eachindex(actual, expected)
            @test actual[i] ≈ expected[i]
        end
    end

    let angle = deg2rad.([-20.0, 50.0, -60.0])

        m = eul2m(angle[3], angle[2], angle[1], 3, 1, 3)
    
        # q = spice.m2q(m)
    
        # expav = [1.0, 2.0, 3.0]
    
        # qav = [0.0, 1.0, 2.0, 3.0]
    
        # dq = spice.qxq(q, qav)
    
        # dq = [-0.5 * x for x in dq]
    
        # av = spice.qdq2av(q, dq)
    
        # npt.assert_array_almost_equal(av, expav)
    end

end
