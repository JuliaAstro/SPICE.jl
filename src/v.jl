using LinearAlgebra

export vadd,
    vaddg,
    valid!,
    vcrss,
    vdist,
    vdistg,
    vdot,
    vdotg,
    vequ,
    vequg,
    vhat,
    vhatg,
    vlcom3,
    vlcom,
    vlcomg,
    vminug,
    vminus,
    vnorm,
    vnormg,
    vpack,
    vperp,
    vprjp

function _vadd(v1, v2)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vadd_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          v1, v2, vout)
    vout
end

"""
    vadd(v1, v2)

**Deprecated:** Use `v1 .+ v2` instead.
"""
vadd

@deprecate vadd(v1, v2) v1 .+ v2

function _vaddg(v1, v2)
    ndim = length(v1)
    vout = Array{SpiceDouble}(undef, ndim)
    ccall((:vaddg_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, SpiceInt, Ptr{SpiceDouble}),
          v1, v2, ndim, vout)
    vout
end

"""
    vaddg(v1, v2)

**Deprecated:** Use `v1 .+ v2` instead.
"""
vaddg

@deprecate vaddg(v1, v2) v1 .+ v2

"""
    valid!(set::SpiceCell{T}) where T

Create a valid SPICE set from a SPICE Cell of any data type.

### Arguments ###

- `set`: Set to be validated

### Output ###

Returns the validated set with ordered elements and duplicates removed.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/valid_c.html)
"""
function valid!(set::SpiceCell{T}) where T
    ccall((:valid_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{Cell{T}}),
          set.cell.size, set.cell.card, set.cell)
    handleerror()
    set
end

function _vcrss(v1, v2)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vcrss_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}), v1, v2, vout)
    vout
end

"""
    vcrss(v1, v2)

**Deprecated:** Use `LinearAlgebra.cross(v1, v2)` instead.
"""
vcrss

@deprecate vcrss(v1, v2) LinearAlgebra.cross(v1, v2)

function _vdist(v1, v2)
    ccall((:vdist_c, libcspice), SpiceDouble,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}), v1, v2)
end

"""
    vdist(v1, v2)

**Deprecated:** Use `LinearAlgebra.norm(v1 .- v2)` instead.
"""
vdist

@deprecate vdist(v1, v2) LinearAlgebra.norm(v1 .- v2)

function _vdistg(v1, v2)
    ndim = length(v1)
    ccall((:vdistg_c, libcspice), SpiceDouble,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, SpiceInt), v1, v2, ndim)
end

"""
    vdistg(v1, v2)

**Deprecated:** Use `LinearAlgebra.norm(v1 .- v2)` instead.
"""
vdistg

@deprecate vdistg(v1, v2) LinearAlgebra.norm(v1 .- v2)

function _vdot(v1, v2)
    ccall((:vdot_c, libcspice), SpiceDouble,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}), v1, v2)
end

"""
    vdot(v1, v2)

**Deprecated:** Use `LinearAlgebra.dot(v1, v2)` instead.
"""
vdot

@deprecate vdot(v1, v2) LinearAlgebra.dot(v1, v2)

function _vdotg(v1, v2)
    ndim = length(v1)
    ccall((:vdotg_c, libcspice), SpiceDouble,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, SpiceInt), v1, v2, ndim)
end

"""
    vdotg(v1, v2)

**Deprecated:** Use `LinearAlgebra.dot(v1, v2)` instead.
"""
vdotg

@deprecate vdotg(v1, v2) LinearAlgebra.dot(v1, v2)

function _vequ(v1, v2)
    ccall((:vequ_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}), v1, v2)
end

"""
    vequ(v1, v2)

**Deprecated:** Use `v1 .= v2` instead.
"""
vequ

@deprecate vequ(v1, v2) v1 .= v2

function _vequg(v1, v2)
    ndim = length(v1)
    ccall((:vequg_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceInt, Ptr{SpiceDouble}), v1, ndim, v2)
end

"""
    vequg(v1, v2)

**Deprecated:** Use `v1 .= v2` instead.
"""
vequg

@deprecate vequg(v1, v2) v1 .= v2

function _vhat(v1)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vhat_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}), v1, vout)
    vout
end

"""
    vhat(v1)

**Deprecated:** Use `LinearAlgebra.normalize(v1)` instead.
"""
vhat

@deprecate vhat(v1) LinearAlgebra.normalize(v1)

function _vhatg(v1)
    ndim = length(v1)
    vout = Array{SpiceDouble}(undef, ndim)
    ccall((:vhatg_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceInt, Ptr{SpiceDouble}), v1, ndim, vout)
    vout
end

"""
    vhatg(v1)

**Deprecated:** Use `LinearAlgebra.normalize(v1)` instead.
"""
vhatg

@deprecate vhatg(v1) LinearAlgebra.normalize(v1)

function _vlcom3(a, v1, b, v2, c, v3)
    sum = Array{SpiceDouble}(undef, 3)
    ccall((:vlcom3_c, libcspice), Cvoid,
          (SpiceDouble, Ptr{SpiceDouble}, SpiceDouble, Ptr{SpiceDouble},
           SpiceDouble, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          a, v1, b, v2, c, v3, sum)
    sum
end

"""
    vlcom3(a, v1, b, v2, c, v3)

**Deprecated:** Use `a .* v1 .+ b .* v2 .+ c .* v3` instead.
"""
vlcom3

@deprecate vlcom3(a, v1, b, v2, c, v3) a .* v1 .+ b .* v2 .+ c .* v3

function _vlcom(a, v1, b, v2)
    sum = Array{SpiceDouble}(undef, 3)
    ccall((:vlcom_c, libcspice), Cvoid,
          (SpiceDouble, Ptr{SpiceDouble}, SpiceDouble, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          a, v1, b, v2, sum)
    sum
end

"""
    vlcom(a, v1, b, v2)

**Deprecated:** Use `a .* v1 .+ b .* v2` instead.
"""
vlcom

@deprecate vlcom(a, v1, b, v2) a .* v1 .+ b .* v2

function _vlcomg(a, v1, b, v2)
    n = length(v1)
    sum = Array{SpiceDouble}(undef, n)
    ccall((:vlcomg_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble, Ptr{SpiceDouble}, SpiceDouble, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          n, a, v1, b, v2, sum)
    sum
end

"""
    vlcomg(a, v1, b, v2)

**Deprecated:** Use `a .* v1 .+ b .* v2` instead.
"""
vlcomg

@deprecate vlcomg(a, v1, b, v2) a .* v1 .+ b .* v2

function _vminug(vin)
    n = length(vin)
    vout = Array{SpiceDouble}(undef, n)
    ccall((:vminug_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceInt, Ptr{SpiceDouble}),
          vin, n, vout)
    vout
end

"""
    vminug(vin)

**Deprecated:** Use `-vin` instead.
"""
vminug

@deprecate vminug(vin) -vin

function _vminus(vin)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vminus_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}), vin, vout)
    vout
end

"""
    vminus(vin)

**Deprecated:** Use `-vin` instead.
"""
vminus

@deprecate vminus(vin) -vin

function _vnorm(v1)
    ccall((:vnorm_c, libcspice), SpiceDouble, (Ptr{SpiceDouble},), v1)
end

"""
    vnorm(v1)

**Deprecated:** Use `LinearAlgebra.norm(v1)` instead.
"""
vnorm

@deprecate vnorm(v1) LinearAlgebra.norm(v1)

function _vnormg(v1)
    ndim = length(v1)
    ccall((:vnormg_c, libcspice), SpiceDouble,
          (Ptr{SpiceDouble}, SpiceInt), v1, ndim)
end

"""
    vnormg(v1, v2)

**Deprecated:** Use `LinearAlgebra.norm(v1)` instead.
"""
vnormg

@deprecate vnormg(v1) LinearAlgebra.norm(v1)

function _vpack(x, y, z)
    v = Array{SpiceDouble}(undef, 3)
    ccall((:vpack_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ptr{SpiceDouble}),
          x, y, z, v)
    v
end

"""
    vpack(x, y, z)

**Deprecated:** Use `[x, y, z]` instead.
"""
vpack

@deprecate vpack(x, y, z) [x, y, z]

"""
    vperp(a, b)

Find the component of a vector that is perpendicular to a second vector.

### Arguments ###

- `a`: The vector whose orthogonal component is sought
- `b`: The vector used as the orthogonal reference

### Output ###

Returns the component `a` orthogonal to `b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vperp_c.html)
"""
function vperp(a, b)
    p = Array{SpiceDouble}(undef, 3)
    ccall((:vperp_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          a, b, p)
    p
end

"""
    vprjp(vin, plane)

Project a vector onto a specified plane, orthogonally.

### Arguments ###

- `vin`: 
- `plane`: 

### Output ###

Returns the vector resulting from the projection.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vprjp_c.html)
"""
function vprjp(vin, plane)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vprjp_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ref{Plane}, Ptr{SpiceDouble}),
          vin, plane, vout)
    handleerror()
    vout
end

