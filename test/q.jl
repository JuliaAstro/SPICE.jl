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
end
