using LinearAlgebra: cross, norm, dot, normalize

@testset "V" begin
    @testset "Vector operations" begin
        v1 = randn(3)
        v2 = randn(3)
        @test SPICE._vadd(v1, v2) == v1 .+ v2
        @test SPICE._vaddg(v1, v2) == v1 .+ v2
        @test SPICE._vcrss(v1, v2) ≈ cross(v1, v2)
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
        @test SPICE._vlcom3(a, v1, b, v2, c, v3) ≈ a .* v1 .+ b .* v2 .+ c .* v3
        @test SPICE._vlcom(a, v1, b, v2) ≈ a .* v1 .+ b .* v2
        @test SPICE._vminus(v1) == -v1
        @test SPICE._vnorm(v1) ≈ norm(v1)
        @test SPICE._vpack(a, b, c) == [a, b, c]
        @test SPICE._vscl(a, v1) ≈ a .* v1
        @test SPICE._vsub(v1, v2) ≈ v1 .- v2
        A = randn(3, 3)
        @test SPICE._vtmv(v1, A, v2) ≈ v1' * A * v2
        x1, y1, z1 = SPICE._vupack(v1)
        x2, y2, z2 = v1
        @test x1 == x2
        @test y1 == y2
        @test z1 == z2
        @test SPICE._vzero([0.0, 0.0, 0.0]) == iszero([0.0, 0.0, 0.0])
    end
    @testset "Vector operations 2" begin
        v1 = randn(6)
        v2 = randn(6)
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
        @test SPICE._vlcomg(a, v1, b, v2) ≈ a .* v1 .+ b .* v2
        @test SPICE._vminug(v1) == -v1
        @test SPICE._vnormg(v1) ≈ norm(v1)
        @test SPICE._vsclg(a, v1) ≈ a .* v1
        @test SPICE._vsubg(v1, v2) ≈ v1 .- v2
        A = randn(6, 6)
        @test SPICE._vtmvg(v1, A, v2) ≈ v1' * A * v2
        @test SPICE._vzerog([0.0, 0.0, 0.0]) == iszero([0.0, 0.0, 0.0])
    end
    @testset "valid" begin
        c = SpiceIntCell(3)
        push!(c, 2, 1, 2)
        valid!(c)
        @test c[1:end] == [1, 2]
    end
    @testset "vperp" begin
        a = [6.0, 6.0, 6.0]
        b = [2.0, 0.0, 0.0]
        @test vperp(a, b) == [0.0, 6.0, 6.0]
    end
    @testset "vprjp" begin
        vec1 = [-5.0, 7.0, 2.2]
        norm = [0.0, 0.0, 1.0]
        orig = [0.0, 0.0, 0.0]
        plane = nvp2pl(norm, orig)
        proj = vprjp(vec1, plane)
        expected = [-5.0, 7.0, 0.0]
        @test proj ≈ expected
    end
    @testset "vprjpi" begin
        norm1 = [0.0, 0.0, 1.0]
        norm2 = [1.0, 0.0, 1.0]
        con1 = 1.2
        con2 = 0.65
        plane1 = nvc2pl(norm1, con1)
        plane2 = nvc2pl(norm2, con2)
        vec = [1.0, 1.0, 0.0]
        result = vprjpi(vec, plane1, plane2)
        expected = [1.0, 1.0, -0.35]
        @test result ≈ expected
    end
    @testset "vproj" begin
        v1 = [6.0, 6.0, 6.0]
        v2 = [2.0, 0.0, 0.0]
        expected = [6.0, 0.0, 0.0]
        vout = vproj(v1, v2)
        @test expected ≈ vout
    end
    @testset "vrel" begin
        vec1 = [12.3, -4.32, 76.0]
        vec2 = [23.0423, -11.99, -0.10]
        @test vrel(vec1, vec2) ≈ 1.0016370 rtol=1e-6
    end
    @testset "vrel" begin
        vec1 = [12.3, -4.32, 76.0, 1.87]
        vec2 = [23.0423, -11.99, -0.10, -99.1]
        @test vrelg(vec1, vec2) ≈ 1.2408623 rtol=1e-6
    end
    @testset "vrotv" begin
        v = [1.0, 2.0, 3.0]
        axis = [0.0, 0.0, 1.0]
        theta = π/2
        vout = vrotv(v, axis, theta)
        expected = [-2.0, 1.0, 3.0]
        @test vout ≈ expected rtol=1e-7
    end
    @testset "vsep" begin
        v1 = [1.0, 0.0, 0.0]
        v2 = [0.0, 1.0, 0.0]
        @test vsep(v1, v2) ≈ π/2
    end
    @testset "vsepg" begin
        v1 = [3.0, 0.0]
        v2 = [-5.0, 0.0]
        @test vsepg(v1, v2) ≈ π
    end
end
