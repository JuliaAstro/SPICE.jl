export mxvg

function mxvg(m1, v2)
    lm1, lm2 = size(m1)
    lv = length(v2)
    if lm2 != lv
        error("Dimension mismatch.")
    end
    vout = Array{Float64}(undef, lm1)
    ccall((:mxvg_c, libcspice), Cvoid, (Ptr{Float64}, Ptr{Float64}, Cint, Cint, Ptr{Float64}),
          permutedims(m1), v2, lm1, lm2, vout)
    handleerror()
    return vout
end
