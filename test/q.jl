@testset "Q" begin
    let exp = [0.607843137254902 0.27450980392156854 0.7450980392156862;
                0.6666666666666666 0.33333333333333326 -0.6666666666666666;
                -0.43137254901960775 0.9019607843137255 0.019607843137254832]
        act = q2m(0.5, 0.4, 0.3, 0.1)
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
        q = [0.5, 0.4, 0.3, 0.1]
        act = q2m(q)
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
        q = (0.5, 0.4, 0.3, 0.1)
        act = q2m(q)
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
    end

    let angle = deg2rad.([-20.0, 50.0, -60.0])

        m = eul2m(angle[3], angle[2], angle[1], 3, 1, 3)
    
        q = m2q(m)
    
        exp = [1.0, 2.0, 3.0]
    
        qav = [0.0, 1.0, 2.0, 3.0]
    
        dq = -0.5*qxq(q, qav)
    
        act = qdq2av(q, dq)
    
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
    end

    let qID = [1.0, 0.0, 0.0, 0.0]

        nqID = [-1.0, 0.0, 0.0, 0.0]
    
        qI = [0.0, 1.0, 0.0, 0.0]
    
        qJ = [0.0, 0.0, 1.0, 0.0]
    
        qK = [0.0, 0.0, 0.0, 1.0]

        qIJ=qxq(qI, qJ)
        @testset for i in eachindex(qIJ, qK)
            @test qIJ[i] ≈ qK[i]
        end

        qJK=qxq(qJ, qK)
        @testset for i in eachindex(qJK, qI)
            @test qJK[i] ≈ qI[i]
        end

        qKI=qxq(qK, qI)
        @testset for i in eachindex(qKI, qJ)
            @test qKI[i] ≈ qJ[i]
        end

        qII=qxq(qI, qI)
        @testset for i in eachindex(qII, nqID)
            @test qII[i] ≈ nqID[i]
        end

        qJJ=qxq(qJ, qJ)
        @testset for i in eachindex(qJJ, nqID)
            @test qJJ[i] ≈ nqID[i]
        end

        qKK=qxq(qK, qK)
        @testset for i in eachindex(qKK, nqID)
            @test qKK[i] ≈ nqID[i]
        end

        qIDI=qxq(qID, qI)
        @testset for i in eachindex(qIDI, qI)
            @test qIDI[i] ≈ qI[i]
        end

        qIID=qxq(qI, qID)
        @testset for i in eachindex(qIID, qI)
            @test qIID[i] ≈ qI[i]
        end
        
    end

end
