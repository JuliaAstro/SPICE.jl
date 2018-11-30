@testset "E" begin
    let 
        act = eul2m(3, 2, 1, 3, 2, 1)
        @test size(act) == (3, 3)
        exp = [0.411982245665683 -0.6812427202564033 0.6051272472413688;
               0.05872664492762098 -0.642872836134547 -0.7637183366502791;
               0.9092974268256817 0.35017548837401463  -0.2248450953661529]
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
    end

    kclear()
    furnsh(path(CORE, :lsk))
    let et = -527644192.5403653
        output = et2utc(et, :J, 6)
        @test output == "JD 2445438.006415"
    end
    kclear()
end
