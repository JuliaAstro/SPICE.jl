@testset "F" begin
    @testset "fovray" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk),
                   path(CASSINI, :pck),
                   path(CASSINI, :sat_spk),
                   path(CASSINI, :tour_spk),
                   path(CASSINI, :fk),
                   path(CASSINI, :ck),
                   path(CASSINI, :sclk),
                   path(CASSINI, :ik))
            camid = bodn2c("CASSINI_ISS_NAC")
            shape, frame, bsight, bounds = getfov(camid, 4)
            et = str2et("2013 FEB 25 11:50:00 UTC")
            visible = fovray("CASSINI_ISS_NAC", [0.0, 0.0, 1.0], frame, "S", "CASSINI", et)
            @test visible
            @test_throws ArgumentError fovray("CASSINI_ISS_NAC", [0.0, 0.0], frame, "S", "CASSINI", et)
            @test_throws SpiceError fovray("norbert", [0.0, 0.0, 1.0], frame, "S", "CASSINI", et)
            @test_throws SpiceError fovray("CASSINI_ISS_NAC", [0.0, 0.0, 1.0], frame, "S", "norbert", et)
            @test_throws SpiceError fovray("CASSINI_ISS_NAC", [0.0, 0.0, 1.0], "norbert", "S", "CASSINI", et)
        finally
            kclear()
        end
    end
    @testset "fovtrg" begin
        try
            furnsh(path(CORE, :lsk),
                   path(CORE, :pck),
                   path(CORE, :spk),
                   path(CASSINI, :pck),
                   path(CASSINI, :sat_spk),
                   path(CASSINI, :tour_spk),
                   path(CASSINI, :fk),
                   path(CASSINI, :ck),
                   path(CASSINI, :sclk),
                   path(CASSINI, :ik))
            et = str2et("2013 FEB 25 11:50:00 UTC")
            visible = fovtrg("CASSINI_ISS_NAC", "Enceladus", "Ellipsoid",
                             "IAU_ENCELADUS", "LT+S", "CASSINI", et)
            @test visible
            @test_throws SpiceError fovtrg("norbert", "Enceladus", "Ellipsoid",
                             "IAU_ENCELADUS", "LT+S", "CASSINI", et)
        finally
            kclear()
        end
    end
    @testset "frame" begin
        vec = [23.0, -3.0, 18.0]
        x, y, z = frame(vec)
        expected_x = [0.78338311, -0.10218041, 0.61308243]
        expected_y = [0.61630826, 0.0000000, -0.78750500]
        expected_z = [0.080467580, 0.99476588, 0.062974628]
        @test expected_x ≈ x
        @test expected_y ≈ y
        @test expected_z ≈ z
    end
    @testset "frinfo" begin
        @test frinfo(13000) == (399, 2, 3000)
        @test frinfo(42) === nothing
    end
    @testset "frmnam" begin
        @test frmnam(13000) == "ITRF93"
        @test frmnam(13000) == "ITRF93"
        @test isempty(frmnam(42))
    end
    @testset "furnsh" begin
        try
            furnsh(path(CORE, :pck),path(CORE, :spk),path(CORE, :gm_pck),path(CORE, :lsk))
            @test ktotal("ALL") == 4
        finally
            kclear()
        end
    end
end
