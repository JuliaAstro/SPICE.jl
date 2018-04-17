export mxvg

function mxvg(m1, v2)
    lm1, lm2 = size(m1)
    lv = length(v2)
    if lm2 != lv
        error("Dimension mismatch.")
    end
    vout = Array{Float64}(lm1)
    ccall((:mxvg_c, libcspice), Void, (Ptr{Float64}, Ptr{Float64}, Cint, Cint, Ptr{Float64}), m1, v2, lm1, lm2, vout)
    handleerror()
    return vout
end