@testset "K" begin
    @testset "ktotal" begin
        try
            furnsh(path(CORE, :pck))
            @test  ktotal("ALL") == 1
        finally
            kclear()
        end
        @test ktotal("ALL") == 0
    end
    @testset "kdata" begin
        try
            furnsh(path(CORE, :pck))
            file, ftype, source, handle = kdata(1, "ALL")
            @test ftype == "TEXT"
        finally
            kclear()
        end
        @test kdata(1, "ALL") === nothing
    end
    @testset "kinfo" begin
        try
            furnsh(path(CORE, :pck))
            filetype, source, handle = kinfo(path(CORE, :pck))
            @test filetype == "TEXT"
        finally
            kclear()
        end
    end
    @testset "kplfrm" begin
        kclear()
        try
            furnsh(path(CASSINI, :fk))
            cell = kplfrm(-1)
            @test length(cell) == 57
        finally
            kclear()
        end
    end
    @testset "kxtrct" begin
        terms = ["FROM", "TO", "BEGINNING", "ENDING"]
        str = "FROM 1 October 1984 12:00:00 TO 1 January 1987"

        exp_string = " TO 1 January 1987"
        exp_substr = "1 October 1984 12:00:00"
        act_string, act_substr = kxtrct("FROM", terms, str)
        @test act_string == exp_string
        @test act_substr == exp_substr

        exp_string = "FROM 1 October 1984 12:00:00"
        exp_substr = "1 January 1987"
        act_string, act_substr = kxtrct("TO", terms, str)
        @test act_string == exp_string
        @test act_substr == exp_substr

        terms = ["ADDRESS:", "PHONE:", "NAME:"]
        str = "ADDRESS: 4800 OAK GROVE DRIVE PHONE: 354-4321"

        exp_string = " PHONE: 354-4321"
        exp_substr = "4800 OAK GROVE DRIVE"
        act_string, act_substr = kxtrct("ADDRESS:", terms, str)
        @test act_string == exp_string
        @test act_substr == exp_substr

        exp_string = "ADDRESS: 4800 OAK GROVE DRIVE"
        exp_substr = "354-4321"
        act_string, act_substr = kxtrct("PHONE:", terms, str)
        @test act_string == exp_string
        @test act_substr == exp_substr

        @test kxtrct("NAME:", terms, str) === nothing
    end
end
