@testset "T" begin 
    furnsh(path(CORE, :lsk))
    @test tyear() == 3.15569259747e7
    @test timout(0.0, "MON DD,YYYY  HR:MN:SC.#### (TDB) ::TDB") == "JAN 01,2000  12:00:00.0000 (TDB)"
    @test_throws SpiceError timout(0.0, "")
    unload(path(CORE, :lsk))

    furnsh(path(CORE, :pck))
    @test round.(tisbod("J2000", 399, 0.0) .* 1000000) ./ 1000000 ==  [  0.176174  -0.984359  -0.0  0.0        0.0        0.0
      0.984359   0.176174   0.0  0.0        0.0        0.0
      0.0        0.0        1.0  0.0        0.0        0.0
      7.2e-5     1.3e-5    -0.0  0.176174  -0.984359  -0.0
      -1.3e-5     7.2e-5    -0.0  0.984359   0.176174   0.0
      0.0       -0.0        0.0  0.0        0.0        1.0] 
    @test_throws SpiceError tisbod("J2000", 3, 0.0)
    unload(path(CORE, :pck))
end 