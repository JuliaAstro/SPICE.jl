@testset "H" begin
    @testset "hx2dp" begin
        @test hx2dp("2A^3") == 672.0
        @test_throws SpiceError hx2dp("2A^3000")
        @test_throws SpiceError hx2dp("-2A^3000")
        @test_throws SpiceError hx2dp("foo")
    end
    @testset "hrmint" begin
        xvals = [-1.0, 0.0, 3.0, 5.0]
        yvals = [6.0, 3.0, 5.0, 0.0, 2210.0, 5115.0, 78180.0, 109395.0]
        answer, deriv = hrmint(xvals, yvals, 2)
        @test answer ≈ 141.0
        @test deriv  ≈ 456.0
        @test_throws ArgumentError hrmint(xvals, yvals[1:4], 2)
        @test_throws SpiceError hrmint([0.0, 0.0], yvals[1:4], 2)
    end
    @testset "halfpi" begin
        @test SPICE._halfpi() ≈ π/2
    end
end
