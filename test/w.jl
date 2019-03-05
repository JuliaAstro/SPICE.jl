@testset "W" begin
    @testset "wncard/wninsd" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 3
    end
    @testset "wncomd" begin
        window1 = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        for d in darray
            wninsd!(window1, d...)
        end
        @test wncard(window1) == 3
        window2 = wncomd(window1, 2.0, 20.0)
        @test wncard(window2) == 2
        @test wnfetd(window2, 1) == (3.0, 7.0)
        @test wnfetd(window2, 2) == (11.0, 20.0)
    end
    @testset "wncond!" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 3
        window = wncond!(window, 2.0, 1.0)
        @test wncard(window) == 2
        @test wnfetd(window, 1) == (9.0, 10.0)
        @test wnfetd(window, 2) == (25.0, 26.0)
    end
    @testset "wndifd" begin
        window1 = SpiceDoubleCell(8)
        window2 = SpiceDoubleCell(8)
        darray1 = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        darray2 = [[2.0, 6.0], [8.0, 10.0], [16.0, 18.0]]
        for d in darray1
            wninsd!(window1, d...)
        end
        @test wncard(window1) == 3
        for d in darray2
            wninsd!(window2, d...)
        end
        @test wncard(window2) == 3
        window3 = wndifd(window1, window2)
        @test wncard(window3) == 4
        @test wnfetd(window3, 1) == (1.0, 2.0)
        @test wnfetd(window3, 2) == (7.0, 8.0)
        @test wnfetd(window3, 3) == (10.0, 11.0)
        @test wnfetd(window3, 4) == (23.0, 27.0)
    end
    @testset "wnelmd" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 3
        array = [0.0, 1.0, 9.0, 13.0, 29.0]
        expected = [false, true, true, false, false]
        @test wnelmd.(Ref(window), array) == expected
    end
    @testset "wnexpd" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0], [29.0, 29.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 4
        wnexpd!(window, 2.0, 1.0)
        @test wncard(window) == 3
        @test wnfetd(window, 1) == (-1.0, 4.0)
        @test wnfetd(window, 2) == (5.0, 12.0)
        @test wnfetd(window, 3) == (21.0, 30.0)
    end
    @testset "wnextd" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0], [29.0, 29.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 4
        wnextd!(window, :L)
        @test wncard(window) == 4
        @test wnfetd(window, 1) == (1.0, 1.0)
        @test wnfetd(window, 2) == (7.0, 7.0)
        @test wnfetd(window, 3) == (23.0, 23.0)
        @test wnfetd(window, 4) == (29.0, 29.0)
        @test_throws SpiceError wnextd!(window, :test)
    end
    @testset "wnfild" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0], [29.0, 29.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 4
        wnfild!(window, 3.0)
        @test wncard(window) == 3
        @test wnfetd(window, 1) == (1.0, 3.0)
        @test wnfetd(window, 2) == (7.0, 11.0)
        @test wnfetd(window, 3) == (23.0, 29.0)
    end
    @testset "wnfltd" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0], [29.0, 29.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 4
        wnfltd!(window, 3.0)
        @test wncard(window) == 2
        @test wnfetd(window, 1) == (7.0, 11.0)
        @test wnfetd(window, 2) == (23.0, 27.0)
    end
    @testset "wnincd" begin
        window = SpiceDoubleCell(8)
        darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        for d in darray
            wninsd!(window, d...)
        end
        @test wncard(window) == 3
        array = [
            [1.0, 3.0],
            [9.0, 10.0],
            [0.0, 2.0],
            [13.0, 15.0],
            [29.0, 30.0],
        ]
        expected = [true, true, false, false, false]
        @testset for i in eachindex(array, expected)
            @test wnincd(window, array[i]...) == expected[i]
        end
    end
    @testset "wnintd" begin
        window1 = SpiceDoubleCell(8)
        window2 = SpiceDoubleCell(8)
        darray1 = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        darray2 = [[2.0, 6.0], [8.0, 10.0], [16.0, 18.0]]
        for d in darray1
            wninsd!(window1, d...)
        end
        @test wncard(window1) == 3
        for d in darray2
            wninsd!(window2, d...)
        end
        @test wncard(window2) == 3
        window3 = wnintd(window1, window2)
        @test wncard(window3) == 2
        @test wnfetd(window3, 1) == (2.0, 3.0)
        @test wnfetd(window3, 2) == (8.0, 10.0)
    end
    @testset "wnreld" begin
        window1 = SpiceDoubleCell(8)
        window2 = SpiceDoubleCell(8)
        darray1 = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        darray2 = [[1.0, 2.0], [9.0, 9.0], [24.0, 27.0]]
        for d in darray1
            wninsd!(window1, d...)
        end
        @test wncard(window1) == 3
        for d in darray2
            wninsd!(window2, d...)
        end
        @test wncard(window2) == 3
        ops = [:(==), :!=, :<=, :<, :>=, :>]
        expected = [false, true, false, false, true, true]
        for i in eachindex(ops, expected)
            @test wnreld(window1, ops[i], window2) == expected[i]
        end
        @test !(window1 == window2)
        @test window1 != window2
        @test !(window1 <= window2)
        @test !(window1 ⊆ window2)
        @test !(window1 < window2)
        @test !(window1 ⊊ window2)
        @test window1 >= window2
        @test window1 ⊇ window2
        @test window1 > window2
        @test window1 ⊋ window2
    end
    @testset "wnsumd" begin
        window = SpiceDoubleCell(12)
        darray = [
            [1.0, 3.0],
            [7.0, 11.0],
            [18.0, 18.0],
            [23.0, 27.0],
            [30.0, 69.0],
            [72.0, 80.0],
        ]
        for d in darray
            wninsd!(window, d...)
        end
        meas, avg, stddev, shortest, longest = wnsumd(window)
        @test meas == 57.0
        @test avg == 9.5
        @test stddev ≈ 13.413302
        @test shortest == 5
        @test longest == 9
    end
    @testset "wnunid" begin
        window1 = SpiceDoubleCell(8)
        window2 = SpiceDoubleCell(8)
        darray1 = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
        darray2 = [[2.0, 6.0], [8.0, 10.0], [16.0, 18.0]]
        for d in darray1
            wninsd!(window1, d...)
        end
        @test wncard(window1) == 3
        for d in darray2
            wninsd!(window2, d...)
        end
        @test wncard(window2) == 3
        window3 = wnunid(window1, window2)
        @test wncard(window3) == 4
        @test wnfetd(window3, 1) == (1.0, 6.0)
        @test wnfetd(window3, 2) == (7.0, 11.0)
        @test wnfetd(window3, 3) == (16.0, 18.0)
        @test wnfetd(window3, 4) == (23.0, 27.0)
    end
    @testset "wnvald" begin
        window = SpiceDoubleCell(30)
        darray = [[0.0, 0.0], [10.0, 12.0], [2.0, 7.0],
                [13.0, 15.0], [1.0, 5.0], [23.0, 29.0],
                [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]]
        for d in darray
            wninsd!(window, d...)
        end
        result = wnvald!(window)
        @test wncard(result) == 5
        @test wnfetd(result, 1) == (0.0, 0.0)
        @test wnfetd(result, 2) == (1.0, 7.0)
        @test wnfetd(result, 3) == (10.0, 12.0)
        @test wnfetd(result, 4) == (13.0, 15.0)
        @test wnfetd(result, 5) == (23.0, 29.0)
    end
end
