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
                _, new_et = spkpos("MERCURY", et_in, "J2000", "MOON", abcorr="LT+S")
                new_et
            end

            deriv = uddf(udfunc, et, 1.0)
            @test deriv ≈ -0.000135670940 atol=1e-10
        finally
            kclear()
        end
    end
end
