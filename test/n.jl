@testset "N" begin
    @testset "namfrm" begin
        @test namfrm("J2000") == 1
        @test_throws SpiceError namfrm("")
    end
    @testset "ncpos" begin
        string = "BOB, JOHN, TED, AND MARTIN    "
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @test ncpos(string, chars, 1) == 4
        @test ncpos(string, chars, 5) == 5
        @test ncpos(string, chars, 6) == 10
        @test ncpos(string, chars, 11) == 11
        @test ncpos(string, chars, 12) == 15
        @test ncpos(string, chars, 16) == 16
        @test ncpos(string, chars, 17) == 20
        @test ncpos(string, chars, 21) == 27
        @test ncpos(string, chars, 28) == 28
        @test ncpos(string, chars, 29) == 29
        @test ncpos(string, chars, 30) == 30
        @test ncpos(string, chars, -11) == 4
        @test ncpos(string, chars, 0) == 4
        @test ncpos(string, chars, 31) == 0
        @test ncpos(string, chars, 123) == 0
    end
    @testset "ncposr" begin
        string = "BOB, JOHN, TED, AND MARTIN...."
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @test ncposr(string, chars, 30) == 30
        @test ncposr(string, chars, 29) == 29
        @test ncposr(string, chars, 28) == 28
        @test ncposr(string, chars, 27) == 27
        @test ncposr(string, chars, 26) == 20
        @test ncposr(string, chars, 19) == 16
        @test ncposr(string, chars, 15) == 15
        @test ncposr(string, chars, 14) == 11
        @test ncposr(string, chars, 10) == 10
        @test ncposr(string, chars, 9) == 5
        @test ncposr(string, chars, 4) == 4
        @test ncposr(string, chars, 3) == 0
        @test ncposr(string, chars, 0) == 0
        @test ncposr(string, chars, -4) == 0
        @test ncposr(string, chars, 31) == 30
        @test ncposr(string, chars, 123) == 30
    end
    @testset "nearpt" begin
        a, b, c = 1.0, 2.0, 3.0
        point = [3.5, 0.0, 0.0]
        pnear, alt = nearpt(point, a, b, c)
        expected_pnear = [1.0, 0.0, 0.0]
        expected_alt = 2.5
        @test alt ≈ expected_alt
        @test pnear ≈ expected_pnear
        @test_throws SpiceError nearpt(point, -1.0, b, c)
        @test_throws ArgumentError nearpt([1.0, 2.0], a, b, c)
    end
    @testset "npedln" begin
        linept = [1.0e6, 2.0e6, 3.0e6]
        a, b, c = 7.0e5, 7.0e5, 6.0e5
        linedr = [-4.472091234e-1, -8.944182469e-1, -4.472091234e-3]
        pnear, dist = npedln(a, b, c, linept, linedr)
        expected_pnear = [-1633.3111, -3266.6222, 599991.83]
        expected_dist = 2389967.9
        @test dist ≈ expected_dist
        @test pnear ≈ expected_pnear
        @test_throws SpiceError npedln(-1.0, b, c, linept, linedr)
        @test_throws ArgumentError npedln(a, b, c, linept, linedr[1:2])
        @test_throws ArgumentError npedln(a, b, c, linept[1:2], linedr)
    end
    @testset "npelpt" begin
        center = [1.0, 2.0, 3.0]
        smajor = [3.0, 0.0, 0.0]
        sminor = [0.0, 2.0, 0.0]
        point = [-4.0, 2.0, 1.0]
        expected_pnear = [-2.0, 2.0, 3.0]
        expected_dist = 2.8284271
        ellipse = cgv2el(center, smajor, sminor)
        pnear, dist = npelpt(point, ellipse)
        @test dist ≈ expected_dist
        @test pnear ≈ expected_pnear
        @test_throws ArgumentError npelpt(point[1:2], ellipse)
    end
    @testset "nplnpt" begin
        linept = [1.0, 2.0, 3.0]
        linedr = [0.0, 1.0, 1.0]
        point = [-6.0, 9.0, 10.0]
        pnear, dist = nplnpt(linept, linedr, point)
        expected_pnear = [1.0, 9.0, 10.0]
        expected_dist = 7.0
        @test dist ≈ expected_dist
        @test pnear ≈ expected_pnear
        @test_throws SpiceError nplnpt(linept, zeros(3), point)
        @test_throws ArgumentError nplnpt(linept[1:2], linedr, point)
        @test_throws ArgumentError nplnpt(linept, linedr[1:2], point)
        @test_throws ArgumentError nplnpt(linept, linedr, point[1:2])
    end
    @testset "nvc2pl" begin
        normal = [1.0, 1.0, 1.0]
        constant = 23.0
        expected_constant = 13.279056
        expected_normal = [0.57735027, 0.57735027, 0.57735027]
        plane = nvc2pl(normal, constant)
        @test collect(plane.normal) ≈ expected_normal
        @test plane.constant ≈ expected_constant
        @test_throws ArgumentError nvc2pl(normal[1:2], constant)
        @test_throws SpiceError nvc2pl(zeros(3), constant)
    end
    @testset "nvp2pl" begin
        normal = [1.0, 1.0, 1.0]
        point = [1.0, 4.0, 9.0]
        expected_constant = 8.0829038
        expected_normal = [0.57735027, 0.57735027, 0.57735027]
        plane = nvp2pl(normal, point)
        @test collect(plane.normal) ≈ expected_normal
        @test plane.constant ≈ expected_constant
        @test_throws ArgumentError nvp2pl(normal[1:2], point)
        @test_throws ArgumentError nvp2pl(normal, point[1:2])
        @test_throws SpiceError nvp2pl(zeros(3), point)
    end
end