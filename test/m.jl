@testset "M" begin
    @testset "m2eul" begin
        ticam = [0.49127379678135830 0.50872620321864170 0.70699908539882417;
                 -0.50872620321864193 -0.49127379678135802 0.70699908539882428;
                 0.70699908539882406 -0.70699908539882439 0.01745240643728360]
        kappa, ang2, ang1 = m2eul(ticam, 3, 1, 3)
        alpha = ang1 + 1.5 * π
        delta = π/2 - ang2
        expected = [315.000000, 1.000000, 45.000000]
        actual = rad2deg.([alpha, delta, kappa])
        @testset for i in eachindex(actual, expected)
            @test actual[i] ≈ expected[i]
        end
        @test_throws ArgumentError m2eul(randn(3,4), 1, 2, 3)
        @test_throws SpiceError m2eul(randn(3,3), 1, 1, 1)
    end
    @testset "matchi" begin
        string = "  ABCDEFGHIJKLMNOPQRSTUVWXYZ  "
        wstr = "*"
        wchr = "%"
        @test matchi(string, "*A*", wstr, wchr)
        @test !matchi(string, "A%D*", wstr, wchr)
        @test matchi(string, "A%C*", wstr, wchr)
        @test !matchi(string, "%A*", wstr, wchr)
        @test matchi(string, "%%CD*Z", wstr, wchr)
        @test !matchi(string, "%%CD", wstr, wchr)
        @test matchi(string, "A*MN*Y*Z", wstr, wchr)
        @test !matchi(string, "A*MN*Y*%Z", wstr, wchr)
        @test matchi(string, "*BCD*Z*", wstr, wchr)
        @test !matchi(string, "*bdc*z*", wstr, wchr)
        @test matchi(string, " *bcD*Z*", wstr, wchr)
        @test_throws SpiceError matchi("", "", wstr, wchr)
    end
    @testset "matchw" begin
        string = "  ABCDEFGHIJKLMNOPQRSTUVWXYZ  "
        wstr = '*'
        wchr = '%'
        @test matchw(string, "*A*", wstr, wchr)
        @test !matchw(string, "A%D*", wstr, wchr)
        @test matchw(string, "A%C*", wstr, wchr)
        @test !matchw(string, "%A*", wstr, wchr)
        @test matchw(string, "%%CD*Z", wstr, wchr)
        @test !matchw(string, "%%CD", wstr, wchr)
        @test matchw(string, "A*MN*Y*Z", wstr, wchr)
        @test !matchw(string, "A*MN*Y*%Z", wstr, wchr)
        @test matchw(string, "*BCD*Z*", wstr, wchr)
        @test !matchw(string, "*bdc*z*", wstr, wchr)
        @test matchw(string, " *BCD*Z*", wstr, wchr)
        @test_throws SpiceError matchw("", "", wstr, wchr)
    end
    @testset "maxd" begin
        values = [4.0, 3.0, 5.0]
        @test SPICE._maxd(values...) == max(values...)
    end
    @testset "maxi" begin
        values = [4, 3, 5]
        @test SPICE._maxi(values...) == max(values...)
    end
    @testset "mequ" begin
        a1 = randn(3, 3)
        a2 = copy(a1)
        b1 = randn(3, 3)
        b2 = copy(b1)
        SPICE._mequ(a1, b1)
        b2 .= a2
        @test b1 == b2
    end
    @testset "mequg" begin
        a1 = randn(12, 15)
        a2 = copy(a1)
        b1 = randn(12, 15)
        b2 = copy(b1)
        SPICE._mequg(a1, b1)
        b2 .= a2
        @test b1 == b2
    end
    @testset "mind" begin
        values = [4.0, 3.0, 5.0]
        @test SPICE._mind(values...) == min(values...)
    end
    @testset "mini" begin
        values = [4, 3, 5]
        @test SPICE._mini(values...) == min(values...)
    end
    @testset "mtxm" begin
        a = randn(3, 3)
        b = randn(3, 3)
        @test SPICE._mtxm(a, b) ≈ a' * b
    end
    @testset "mtxmg" begin
        a = randn(2, 4)
        b = randn(2, 3)
        @test SPICE._mtxmg(a, b) ≈ a' * b
    end
    @testset "mtxv" begin
        a = randn(3, 3)
        v = randn(3)
        @test SPICE._mtxv(a, v) ≈ a' * v
    end
    @testset "mtxvg" begin
        a = randn(3, 2)
        v = randn(3)
        @test SPICE._mtxvg(a, v) ≈ a' * v
    end
    @testset "mxm" begin
        a = randn(3, 3)
        b = randn(3, 3)
        @test SPICE._mxm(a, b) ≈ a * b
    end
    @testset "mxmg" begin
        a = randn(4, 2)
        b = randn(2, 3)
        @test SPICE._mxmg(a, b) ≈ a * b
    end
    @testset "mxmt" begin
        a = randn(3, 3)
        b = randn(3, 3)
        @test SPICE._mxmt(a, b) ≈ a * b'
    end
    @testset "mxmtg" begin
        a = randn(4, 2)
        b = randn(3, 2)
        @test SPICE._mxmtg(a, b) ≈ a * b'
    end
    @testset "mxv" begin
        a = randn(3, 3)
        v = randn(3)
        @test SPICE._mxv(a, v) ≈ a * v
    end
    @testset "mxvg" begin
        a = randn(2, 3)
        v = randn(3)
        @test SPICE._mxvg(a, v) ≈ a * v
    end
    @testset "m2q" begin
        r = rotate(π/2, 3)
        act = m2q(r)
        exp = [sqrt(2)/2.0, 0.0, 0.0, -sqrt(2)/2.0]
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
        @test_throws ArgumentError m2q(randn(3,4))
        @test_throws SpiceError m2q(fill(1.0, 3, 3))
    end
end
