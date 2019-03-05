@testset "Q" begin
    @testset "q2m" begin
        exp = [0.607843137254902 0.27450980392156854 0.7450980392156862;
               0.6666666666666666 0.33333333333333326 -0.6666666666666666;
               -0.43137254901960775 0.9019607843137255 0.019607843137254832]
        q = [0.5, 0.4, 0.3, 0.1]
        act = q2m(q)
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
    end
    @testset "qdq2av" begin
        angle = deg2rad.([-20.0, 50.0, -60.0])
        m = eul2m(angle[3], angle[2], angle[1], 3, 1, 3)
        q = m2q(m)
        exp = [1.0, 2.0, 3.0]
        qav = [0.0, 1.0, 2.0, 3.0]
        dq = -0.5 * qxq(q, qav)
        act = qdq2av(q, dq)
        @testset for i in eachindex(act, exp)
            @test act[i] ≈ exp[i]
        end
    end
    @testset "qxq" begin
        q_id = [1.0, 0.0, 0.0, 0.0]
        nq_id = [-1.0, 0.0, 0.0, 0.0]
        q_i = [0.0, 1.0, 0.0, 0.0]
        q_j = [0.0, 0.0, 1.0, 0.0]
        q_k = [0.0, 0.0, 0.0, 1.0]
        q_ij = qxq(q_i, q_j)
        @testset for i in eachindex(q_ij, q_k)
            @test q_ij[i] ≈ q_k[i]
        end
        q_jk = qxq(q_j, q_k)
        @testset for i in eachindex(q_jk, q_i)
            @test q_jk[i] ≈ q_i[i]
        end
        q_ki = qxq(q_k, q_i)
        @testset for i in eachindex(q_ki, q_j)
            @test q_ki[i] ≈ q_j[i]
        end
        q_ii = qxq(q_i, q_i)
        @testset for i in eachindex(q_ii, nq_id)
            @test q_ii[i] ≈ nq_id[i]
        end
        q_jj = qxq(q_j, q_j)
        @testset for i in eachindex(q_jj, nq_id)
            @test q_jj[i] ≈ nq_id[i]
        end
        q_kk = qxq(q_k, q_k)
        @testset for i in eachindex(q_kk, nq_id)
            @test q_kk[i] ≈ nq_id[i]
        end
        q_idi = qxq(q_id, q_i)
        @testset for i in eachindex(q_idi, q_i)
            @test q_idi[i] ≈ q_i[i]
        end
        q_iid = qxq(q_i, q_id)
        @testset for i in eachindex(q_iid, q_i)
            @test q_iid[i] ≈ q_i[i]
        end
    end
end
