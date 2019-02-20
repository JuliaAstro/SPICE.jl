import LinearAlgebra

@testset "U" begin
    @testset "ucase" begin
        @test SPICE._ucase("test") == uppercase("test")
    end
    @testset "ucrss" begin
        v1 = randn(3)
        v2 = randn(3)
        @test SPICE._ucrss(v1, v2) ≈ LinearAlgebra.normalize(LinearAlgebra.cross(v1, v2))
    end
    @testset "uddf" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk))
            et = str2et("JAN 1 2009")

            function udfunc(et_in)
                _, new_et = spkpos("MERCURY", et_in, "J2000", "LT+S", "MOON")
                new_et
            end

            deriv = uddf(udfunc, et, 1.0)
            @test deriv ≈ -0.000135670940 atol=1e-10
        finally
            kclear()
        end
    end
    @testset "union" begin
        # SPICEINT_CELL
        one = SpiceIntCell(8)
        two = SpiceIntCell(8)
        push!(one, 1, 2, 3)
        push!(two, 2, 3, 4)
        out = union(one, two)
        @test out == [1, 2, 3, 4]
        # SPICECHAR_CELL
        one = SpiceCharCell(8, 8)
        two = SpiceCharCell(8, 8)
        push!(one, "1", "2", "3")
        push!(two, "2", "3", "4")
        out = union(one, two)
        @test out == ["1", "2", "3", "4"]
        # SPICEDOUBLE_CELL
        one = SpiceDoubleCell(8)
        two = SpiceDoubleCell(8)
        push!(one, 1.0, 2.0, 3.0)
        push!(two, 2.0, 3.0, 4.0)
        out = union(one, two)
        @test out == [1.0, 2.0, 3.0, 4.0]
    end
    @testset "unitim" begin
        try
            furnsh(path(CORE, :lsk))
            et = str2et("Dec 19 2003")
            actual = unitim(et, :ET, :JED)
            expected = 2452992.5007428653
            @test actual ≈ expected
            @test_throws SpiceError unitim(et, :TEST, :JED)
            @test_throws SpiceError unitim(et, :ET, :TEST)
        finally
            kclear()
        end
    end
    @testset "unload" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :pck))
            @test ktotal(:ALL) == 2
            unload(path(CORE, :pck))
            @test ktotal(:ALL) == 1
        finally
            kclear()
        end
    end
    @testset "unorm" begin
        v1 = randn(3)
        @test all(SPICE._unorm(v1) .≈ (LinearAlgebra.normalize(v1),
                                       LinearAlgebra.norm(v1)))
        v1 = randn(8)
        @test all(SPICE._unormg(v1) .≈ (LinearAlgebra.normalize(v1),
                                        LinearAlgebra.norm(v1)))
    end
    @testset "utc2et" begin
        try
            furnsh(path(CORE, :lsk))
            utcstr = "December 1, 2004 15:04:11"
            output = utc2et(utcstr)
            @test output ≈ 155185515.1831043
            @test_throws SpiceError utc2et("")
            @test_throws SpiceError utc2et("1 1 1")
        finally
            kclear()
        end
    end
end
