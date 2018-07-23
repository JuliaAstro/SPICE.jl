using LinearAlgebra: cross, norm, dot, normalize

@testset "V" begin
    let v1 = randn(3), v2 = randn(3)
        @test SPICE._vadd(v1, v2) == v1 .+ v2
        @test SPICE._vaddg(v1, v2) == v1 .+ v2
        @test SPICE._vcrss(v1, v2) == cross(v1, v2)
        @test SPICE._vdist(v1, v2) ≈ norm(v1 .- v2)
        @test SPICE._vdistg(v1, v2) ≈ norm(v1 .- v2)
        @test SPICE._vdot(v1, v2) ≈ dot(v1, v2)
        @test SPICE._vdotg(v1, v2) ≈ dot(v1, v2)
        w1 = fill(0.0, 3)
        SPICE._vequ(v1, w1)
        w2 = fill(0.0, 3)
        w2 .= v2
        @test w1 == v1
        @test w2 == v2
        @test SPICE._vhat(v1) ≈ normalize(v1)
        v3 = randn(3)
        a, b, c = randn(3)
        @test SPICE._vlcom3(a, v1, b, v2, c, v3) == a .* v1 .+ b .* v2 .+ c .* v3
        @test SPICE._vlcom(a, v1, b, v2) == a .* v1 .+ b .* v2
        @test SPICE._vminus(v1) == -v1
        @test SPICE._vnorm(v1) ≈ norm(v1)
        @test SPICE._vpack(a, b, c) == [a, b, c]
    end
    let v1 = randn(6), v2 = randn(6)
        @test SPICE._vdistg(v1, v2) ≈ norm(v1 .- v2)
        @test SPICE._vdotg(v1, v2) ≈ dot(v1, v2)
        w1 = fill(0.0, 6)
        SPICE._vequg(v1, w1)
        w2 = fill(0.0, 6)
        w2 .= v2
        @test w1 == v1
        @test w2 == v2
        @test SPICE._vhatg(v1) ≈ normalize(v1)
        a, b = randn(2)
        @test SPICE._vlcomg(a, v1, b, v2) == a .* v1 .+ b .* v2
        @test SPICE._vminug(v1) == -v1
        @test SPICE._vnormg(v1) ≈ norm(v1)
    end
    let c = SpiceIntCell(3)
        push!(c, 2, 1, 2)
        valid!(c)
        @test c[1:end] == [1, 2]
    end
    let a = [6.0, 6.0, 6.0], b = [2.0, 0.0, 0.0]
        @test vperp(a, b) == [0.0, 6.0, 6.0]
    end
    let
        vec1 = [-5.0, 7.0, 2.2]
        norm = [0.0, 0.0, 1.0]
        orig = [0.0, 0.0, 0.0]
        plane = nvp2pl(norm, orig)
        proj = vprjp(vec1, plane)
        expected = [-5.0, 7.0, 0.0]
        @test proj ≈ expected
    end
end
