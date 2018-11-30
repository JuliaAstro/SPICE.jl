export 
    mxvg,
    m2q

function _mxvg(m1, v2)
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

"""
    mxvg(m1,v2)

**Deprecated:** Use `m1 * v2` instead.
"""
mxvg

@deprecate mxvg(m1, v2) m1 * v2

"""
    m2q(r)

Find a unit quaternion corresponding to a specified rotation matrix.

### Arguments ###

- `r`: A rotation matrix

### Output ###

A unit quaternion representing `r'

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/m2q_c.html)
"""
function m2q(r)
    q = Array{SpiceDouble}(undef, 4)
    ccall((:m2q_c, libcspice), Cvoid, (Ptr{Float64}, Ptr{Float64}), permutedims(r), q)
    handleerror()
    q
end

