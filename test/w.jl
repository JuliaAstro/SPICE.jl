@testset "W" begin
    @testset "wncard, wninsd" begin
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


# def test_wnfltd():
#     window = spice.stypes.SPICEDOUBLE_CELL(8)
#     darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0], [29.0, 29.0]]
#     for d in darray:
#         spice.wninsd(d[0], d[1], window)
#     assert spice.wncard(window) == 4
#     window = spice.wnfltd(3.0, window)
#     assert spice.wncard(window) == 2
#     assert spice.wnfetd(window, 0) == (7.0, 11.0)
#     assert spice.wnfetd(window, 1) == (23.0, 27.0)


# def test_wnincd():
#     window = spice.stypes.SPICEDOUBLE_CELL(8)
#     darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
#     for d in darray:
#         spice.wninsd(d[0], d[1], window)
#     assert spice.wncard(window) == 3
#     array = [[1.0, 3.0], [9.0, 10.0], [0.0, 2.0], [13.0, 15.0], [29.0, 30.0]]
#     expected = [True, True, False, False, False]
#     for a, exp in zip(array, expected):
#         assert spice.wnincd(a[0], a[1], window) == exp


# def test_wninsd():
#     window = spice.stypes.SPICEDOUBLE_CELL(8)
#     darray = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
#     for d in darray:
#         spice.wninsd(d[0], d[1], window)
#     assert spice.wncard(window) == 3
#     assert [x for x in window] == [1.0, 3.0, 7.0, 11.0, 23.0, 27.0]


# def test_wnintd():
#     window1 = spice.stypes.SPICEDOUBLE_CELL(8)
#     window2 = spice.stypes.SPICEDOUBLE_CELL(8)
#     darray1 = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
#     darray2 = [[2.0, 6.0], [8.0, 10.0], [16.0, 18.0]]
#     for d in darray1:
#         spice.wninsd(d[0], d[1], window1)
#     assert spice.wncard(window1) == 3
#     for d in darray2:
#         spice.wninsd(d[0], d[1], window2)
#     assert spice.wncard(window2) == 3
#     window3 = spice.wnintd(window1, window2)
#     assert spice.wncard(window3) == 2
#     assert spice.wnfetd(window3, 0) == (2.0, 3.0)
#     assert spice.wnfetd(window3, 1) == (8.0, 10.0)


# def test_wnreld():
#     window1 = spice.stypes.SPICEDOUBLE_CELL(8)
#     window2 = spice.stypes.SPICEDOUBLE_CELL(8)
#     darray1 = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
#     darray2 = [[1.0, 2.0], [9.0, 9.0], [24.0, 27.0]]
#     for d in darray1:
#         spice.wninsd(d[0], d[1], window1)
#     assert spice.wncard(window1) == 3
#     for d in darray2:
#         spice.wninsd(d[0], d[1], window2)
#     assert spice.wncard(window2) == 3
#     ops = ['=', '<>', '<=', '<', '>=', '>']
#     expected = [False, True, False, False, True, True]
#     for op, exp in zip(ops, expected):
#         assert spice.wnreld(window1, op, window2) == exp


# def test_wnsumd():
#     window = spice.stypes.SPICEDOUBLE_CELL(12)
#     darray = [[1.0, 3.0], [7.0, 11.0], [18.0, 18.0], [23.0, 27.0], [30.0, 69.0], [72.0, 80.0]]
#     for d in darray:
#         spice.wninsd(d[0], d[1], window)
#     meas, avg, stddev, shortest, longest = spice.wnsumd(window)
#     assert meas == 57.0
#     assert avg == 9.5
#     assert np.around(stddev, decimals=6) == 13.413302
#     assert shortest == 4
#     assert longest == 8


# def test_wnunid():
#     window1 = spice.stypes.SPICEDOUBLE_CELL(8)
#     window2 = spice.stypes.SPICEDOUBLE_CELL(8)
#     darray1 = [[1.0, 3.0], [7.0, 11.0], [23.0, 27.0]]
#     darray2 = [[2.0, 6.0], [8.0, 10.0], [16.0, 18.0]]
#     for d in darray1:
#         spice.wninsd(d[0], d[1], window1)
#     assert spice.wncard(window1) == 3
#     for d in darray2:
#         spice.wninsd(d[0], d[1], window2)
#     assert spice.wncard(window2) == 3
#     window3 = spice.wnunid(window1, window2)
#     assert spice.wncard(window3) == 4
#     assert spice.wnfetd(window3, 0) == (1.0, 6.0)
#     assert spice.wnfetd(window3, 1) == (7.0, 11.0)
#     assert spice.wnfetd(window3, 2) == (16.0, 18.0)
#     assert spice.wnfetd(window3, 3) == (23.0, 27.0)


# def test_wnvald():
#     window = spice.stypes.SPICEDOUBLE_CELL(30)
#     array = [[0.0, 0.0], [10.0, 12.0], [2.0, 7.0],
#              [13.0, 15.0], [1.0, 5.0], [23.0, 29.0],
#              [0.0, 0.0], [0.0, 0.0], [0.0, 0.0], [0.0, 0.0]]
#     for a in array:
#         spice.wninsd(a[0], a[1], window)
#     result = spice.wnvald(30, 20, window)
#     assert spice.wncard(result) == 5
#     assert spice.wnfetd(result, 0) == (0.0, 0.0)
#     assert spice.wnfetd(result, 1) == (1.0, 7.0)
#     assert spice.wnfetd(result, 2) == (10.0, 12.0)
#     assert spice.wnfetd(result, 3) == (13.0, 15.0)
# assert spice.wnfetd(result, 4) == (23.0, 29.0)
end