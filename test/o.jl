@testset "O" begin
    @testset "occult" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk),
                   path(EXTRA, :earth_stn_spk),
                   path(EXTRA, :earth_high_per_pck),
                   path(EXTRA, :earth_topo_tf))
            # start test
            # Mercury transited the Sun w.r.t. Earth-based observer ca. 2006-11-08 for about 5h
            # cf. https://science.nasa.gov/science-news/science-at-nasa/2006/20oct_transitofmercury
            # Mercury was occulted by the sun about six months later
            et_sun_transited_by_mercury = str2et("2006-11-08T22:00")
            occult_code_one = occult("MERCURY", "POINT", "", "SUN", "ELLIPSOID", "IAU_SUN", "CN",
                                     "DSS-13", et_sun_transited_by_mercury)
            # Mercury is in front of the Sun as seen by observer (DSS-13)
            @test occult_code_one == 2    # SPICE_OCCULT_ANNLR2
            et_sun_mercury_both_visible = str2et("2006-11-09T02:00")
            occult_code_two = occult("MERCURY", "POINT", "", "SUN", "ELLIPSOID", "IAU_SUN", "CN",
                                     "DSS-13", et_sun_mercury_both_visible)
            # Both Mercury and the Sun are visible to observer (DSS-13)
            @test occult_code_two == 0    # SPICE_OCCULT_NOOCC
            et_sun_totally_occulted_mercury = str2et("2007-05-03T05:00")
            occult_code_three = occult("MERCURY", "POINT", "", "SUN", "ELLIPSOID", "IAU_SUN", "CN",
                                       "DSS-13", et_sun_totally_occulted_mercury)
            # The Sun is in front of Mercury as seen by observer (DSS-13)
            @test occult_code_three == -3 # SPICE_OCCULT_TOTAL1
            @test_throws SpiceError occult("", "POINT", "", "SUN", "ELLIPSOID", "IAU_SUN", "CN",
                                           "DSS-13", et_sun_totally_occulted_mercury)
        finally
            kclear()
        end
    end
    @testset "ordc" begin
        set = SpiceCharCell(10, 10)
        inputs = ["8", "1", "2", "9", "7", "4", "10"]
        expected = [6, 1, 3, 7, 5, 4, 2]
        for c in inputs
            insrtc!(set, c)
        end
        for (i, e) in zip(inputs, expected)
            @test e == ordc(set, i)
        end
        @test ordc(set, "42") === nothing
    end
    @testset "ordd" begin
        set = SpiceDoubleCell(7)
        inputs = [8.0, 1.0, 2.0, 9.0, 7.0, 4.0, 10.0]
        expected = [5, 1, 2, 6, 4, 3, 7]
        for d in inputs
            insrtd!(set, d)
        end
        for (i, e) in zip(inputs, expected)
            @test e == ordd(set, i)
        end
        @test ordd(set, 42.0) === nothing
    end
    @testset "ordi" begin
        set = SpiceIntCell(7)
        inputs = [8, 1, 2, 9, 7, 4, 10]
        expected = [5, 1, 2, 6, 4, 3, 7]
        for i in inputs
            insrti!(set, i)
        end
        for (i, e) in zip(inputs, expected)
            @test e == ordi(set, i)
        end
        @test ordi(set, 42) === nothing
    end
    @testset "orderc" begin
        inarray = ["a", "abc", "ab"]
        @test sortperm(inarray) == SPICE._orderc(inarray)
    end
    @testset "orderd" begin
        inarray = [0.0, 2.0, 1.0]
        @test sortperm(inarray) == SPICE._orderd(inarray)
    end
    @testset "orderi" begin
        inarray = [0, 2, 1]
        @test sortperm(inarray) == SPICE._orderi(inarray)
    end
    @testset "oscltx" begin
        try
            furnsh(path(CORE, :lsk), path(CORE, :spk), path(CORE, :gm_pck))
            et = str2et("Dec 25, 2007")
            state, ltime = spkezr("Moon", et, "J2000", "LT+S", "EARTH")
            mu_earth = bodvrd("EARTH", "GM", 1)
            ele = oscelt(state, et, mu_earth[1])
            elex = oscltx(state, et, mu_earth[1])
            exp_true_anomaly = 0.6426866586971616
            exp_semi_major = elex[1] / (1 - elex[2])
            exp_period = 2π * sqrt(exp_semi_major^3 / mu_earth[1])
            @test elex[1] ≈ ele[1]
            @test elex[2] ≈ ele[2]
            @test elex[3] ≈ ele[3]
            @test elex[4] ≈ ele[4]
            @test elex[5] ≈ ele[5]
            @test elex[6] ≈ ele[6]
            @test elex[7] ≈ ele[7]
            @test elex[8] ≈ ele[8]
            @test elex[9] ≈ exp_true_anomaly
            @test elex[10] ≈ exp_semi_major
            @test elex[11] ≈ exp_period
        finally
            kclear()
        end
    end
end
