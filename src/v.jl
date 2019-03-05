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
    vprjp,
    vprjpi,
    vproj,
    vrel,
    vrelg,
    vrotv,
    vscl,
    vsclg,
    vsep,
    vsepg,
    vsub,
    vsubg,
    vtmv,
    vtmvg,
    vupack

function _vadd(v1, v2)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vadd_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v1, v2, vout)
    vout
end

"""
    vadd(v1, v2)

!!! warning "Deprecated"
    Use `v1 .+ v2` instead.
"""
vadd

@deprecate vadd(v1, v2) v1 .+ v2

function _vaddg(v1, v2)
    ndim = length(v1)
    vout = Array{SpiceDouble}(undef, ndim)
    ccall((:vaddg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}),
          v1, v2, ndim, vout)
    vout
end

"""
    vaddg(v1, v2)

!!! warning "Deprecated"
    Use `v1 .+ v2` instead.
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
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}), v1, v2, vout)
    vout
end

"""
    vcrss(v1, v2)

!!! warning "Deprecated"
    Use `LinearAlgebra.cross(v1, v2)` instead.
"""
vcrss

@deprecate vcrss(v1, v2) LinearAlgebra.cross(v1, v2)

function _vdist(v1, v2)
    ccall((:vdist_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}), v1, v2)
end

"""
    vdist(v1, v2)

!!! warning "Deprecated"
    Use `LinearAlgebra.norm(v1 .- v2)` instead.
"""
vdist

@deprecate vdist(v1, v2) LinearAlgebra.norm(v1 .- v2)

function _vdistg(v1, v2)
    ndim = length(v1)
    ccall((:vdistg_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt), v1, v2, ndim)
end

"""
    vdistg(v1, v2)

!!! warning "Deprecated"
    Use `LinearAlgebra.norm(v1 .- v2)` instead.
"""
vdistg

@deprecate vdistg(v1, v2) LinearAlgebra.norm(v1 .- v2)

function _vdot(v1, v2)
    ccall((:vdot_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}), v1, v2)
end

"""
    vdot(v1, v2)

!!! warning "Deprecated"
    Use `LinearAlgebra.dot(v1, v2)` instead.
"""
vdot

@deprecate vdot(v1, v2) LinearAlgebra.dot(v1, v2)

function _vdotg(v1, v2)
    ndim = length(v1)
    ccall((:vdotg_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt), v1, v2, ndim)
end

"""
    vdotg(v1, v2)

!!! warning "Deprecated"
    Use `LinearAlgebra.dot(v1, v2)` instead.
"""
vdotg

@deprecate vdotg(v1, v2) LinearAlgebra.dot(v1, v2)

function _vequ(v1, v2)
    ccall((:vequ_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}), v1, v2)
end

"""
    vequ(v1, v2)

!!! warning "Deprecated"
    Use `v1 .= v2` instead.
"""
vequ

@deprecate vequ(v1, v2) v1 .= v2

function _vequg(v1, v2)
    ndim = length(v1)
    ccall((:vequg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}), v1, ndim, v2)
end

"""
    vequg(v1, v2)

!!! warning "Deprecated"
    Use `v1 .= v2` instead.
"""
vequg

@deprecate vequg(v1, v2) v1 .= v2

function _vhat(v1)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vhat_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}), v1, vout)
    vout
end

"""
    vhat(v1)

!!! warning "Deprecated"
    Use `LinearAlgebra.normalize(v1)` instead.
"""
vhat

@deprecate vhat(v1) LinearAlgebra.normalize(v1)

function _vhatg(v1)
    ndim = length(v1)
    vout = Array{SpiceDouble}(undef, ndim)
    ccall((:vhatg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}), v1, ndim, vout)
    vout
end

"""
    vhatg(v1)

!!! warning "Deprecated"
    Use `LinearAlgebra.normalize(v1)` instead.
"""
vhatg

@deprecate vhatg(v1) LinearAlgebra.normalize(v1)

function _vlcom3(a, v1, b, v2, c, v3)
    sum = Array{SpiceDouble}(undef, 3)
    ccall((:vlcom3_c, libcspice), Cvoid,
          (SpiceDouble, Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble},
           SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}),
          a, v1, b, v2, c, v3, sum)
    sum
end

"""
    vlcom3(a, v1, b, v2, c, v3)

!!! warning "Deprecated"
    Use `a .* v1 .+ b .* v2 .+ c .* v3` instead.
"""
vlcom3

@deprecate vlcom3(a, v1, b, v2, c, v3) a .* v1 .+ b .* v2 .+ c .* v3

function _vlcom(a, v1, b, v2)
    sum = Array{SpiceDouble}(undef, 3)
    ccall((:vlcom_c, libcspice), Cvoid,
          (SpiceDouble, Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}),
          a, v1, b, v2, sum)
    sum
end

"""
    vlcom(a, v1, b, v2)

!!! warning "Deprecated"
    Use `a .* v1 .+ b .* v2` instead.
"""
vlcom

@deprecate vlcom(a, v1, b, v2) a .* v1 .+ b .* v2

function _vlcomg(a, v1, b, v2)
    n = length(v1)
    sum = Array{SpiceDouble}(undef, n)
    ccall((:vlcomg_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble, Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}),
          n, a, v1, b, v2, sum)
    sum
end

"""
    vlcomg(a, v1, b, v2)

!!! warning "Deprecated"
    Use `a .* v1 .+ b .* v2` instead.
"""
vlcomg

@deprecate vlcomg(a, v1, b, v2) a .* v1 .+ b .* v2

function _vminug(vin)
    n = length(vin)
    vout = Array{SpiceDouble}(undef, n)
    ccall((:vminug_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}),
          vin, n, vout)
    vout
end

"""
    vminug(vin)

!!! warning "Deprecated"
    Use `-vin` instead.
"""
vminug

@deprecate vminug(vin) -vin

function _vminus(vin)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vminus_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}), vin, vout)
    vout
end

"""
    vminus(vin)

!!! warning "Deprecated"
    Use `-vin` instead.
"""
vminus

@deprecate vminus(vin) -vin

function _vnorm(v1)
    ccall((:vnorm_c, libcspice), SpiceDouble, (Ref{SpiceDouble},), v1)
end

"""
    vnorm(v1)

!!! warning "Deprecated"
    Use `LinearAlgebra.norm(v1)` instead.
"""
vnorm

@deprecate vnorm(v1) LinearAlgebra.norm(v1)

function _vnormg(v1)
    ndim = length(v1)
    ccall((:vnormg_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, SpiceInt), v1, ndim)
end

"""
    vnormg(v1, v2)

!!! warning "Deprecated"
    Use `LinearAlgebra.norm(v1)` instead.
"""
vnormg

@deprecate vnormg(v1) LinearAlgebra.norm(v1)

function _vpack(x, y, z)
    v = Array{SpiceDouble}(undef, 3)
    ccall((:vpack_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          x, y, z, v)
    v
end

"""
    vpack(x, y, z)

!!! warning "Deprecated"
    Use `[x, y, z]` instead.
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
    @checkdims 3 a b
    p = Array{SpiceDouble}(undef, 3)
    ccall((:vperp_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          a, b, p)
    p
end

"""
    vprjp(vin, plane)

Project a vector onto a specified plane, orthogonally.

### Arguments ###

- `vin`: Vector to be projected
- `plane`: Plane onto which vin is projected

### Output ###

Returns the vector resulting from the projection.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vprjp_c.html)
"""
function vprjp(vin, plane)
    @checkdims 3 vin
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vprjp_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{Plane}, Ref{SpiceDouble}),
          vin, plane, vout)
    handleerror()
    vout
end

"""
    vprjpi(vin, projpl, invpl)

Find the vector in a specified plane that maps to a specified vector in another plane
under orthogonal projection.

### Arguments ###

- `vin`: The projected vector
- `projpl`: Plane containing `vin`
- `invpl`: Plane containing inverse image of `vin`

### Output ###

Returns the inverse projection of `vin` or `nothing` if `vin` could not be calculated.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vprjpi_c.html)
"""
function vprjpi(vin, projpl, invpl)
    @checkdims 3 vin
    vout = Array{SpiceDouble}(undef, 3)
    found = Ref{SpiceBoolean}()
    ccall((:vprjpi_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{Plane}, Ref{Plane}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          vin, projpl, invpl, vout, found)
    handleerror()
    Bool(found[]) ? vout : nothing
end

"""
    vproj(a, b)

Finds the projection of one vector onto another vector. All vectors are 3-dimensional.

### Arguments ###

- `a`: The vector to be projected
- `b`: The vector onto which `a` is to be projected

### Output ###

Returns the projection of `a` onto `b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vproj_c.html)
"""
function vproj(a, b)
    @checkdims 3 a b
    p = Array{SpiceDouble}(undef, 3)
    ccall((:vproj_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}), a, b, p)
    p
end

"""
    vrel(v1, v2)

Return the relative difference between two 3-dimensional vectors.

### Arguments ###

- `v1`, `v2`: Two three-dimensional input vectors

### Output ###

Returns the relative differences between `v1` and `v2`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vrel_c.html)
"""
function vrel(v1, v2)
    @checkdims 3 v1 v2
    ccall((:vrel_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}), v1, v2)
end

"""
    vrelg(v1, v2)

Return the relative difference between two vectors.

### Arguments ###

- `v1`, `v2`: Input vectors

### Output ###

Returns the relative differences between `v1` and `v2`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vrelg_c.html)
"""
function vrelg(v1, v2)
    ndim = length(v1)
    @checkdims ndim v2
    ccall((:vrelg_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt), v1, v2, ndim)
end

"""
    vrotv(v, axis, theta)

Rotate a vector about a specified axis vector by a specified angle and return
the rotated vector.

### Arguments ###

- `v`: Vector to be rotated
- `axis`: Axis of the rotation
- `theta`: Angle of rotation (radians)

### Output ###

Result of rotating `v` about `axis` by `theta`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vrotv_c.html)
"""
function vrotv(v, axis, theta)
    @checkdims 3 v
    r = Array{SpiceDouble}(undef, 3)
    ccall((:vrotv_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}),
          v, axis, theta, r)
    r
end

function _vscl(s, v1)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vscl_c, libcspice), Cvoid,
          (SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}), s, v1, vout)
    vout
end

"""
    vscl(s, v1)

!!! warning "Deprecated"
    Use `s .* v1` instead.
"""
vscl

@deprecate vscl(s, v1) s .* v1

function _vsclg(s, v1)
    ndim = length(v1)
    vout = Array{SpiceDouble}(undef, ndim)
    ccall((:vsclg_c, libcspice), Cvoid,
          (SpiceDouble, Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}),
          s, v1, ndim, vout)
    vout
end

"""
    vsclg(s, v1)

!!! warning "Deprecated"
    Use `s .* v1` instead.
"""
vsclg

@deprecate vsclg(s, v1) s .* v1

"""
    vsep(v1, v2)

Return the sepative difference between two 3-dimensional vectors.

### Arguments ###

- `v1`, `v2`: Two three-dimensional input vectors

### Output ###

Returns the angle between `v1` and `v2` in radians.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vsep_c.html)
"""
function vsep(v1, v2)
    @checkdims 3 v1 v2
    ccall((:vsep_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}), v1, v2)
end

"""
    vsepg(v1, v2)

Return the sepative difference between two vectors.

### Arguments ###

- `v1`, `v2`: Input vectors

### Output ###

Returns the angle between `v1` and `v2` in radians.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/vsepg_c.html)
"""
function vsepg(v1, v2)
    ndim = length(v1)
    @checkdims ndim v2
    ccall((:vsepg_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt), v1, v2, ndim)
end

function _vsub(v1, v2)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:vsub_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v1, v2, vout)
    vout
end

"""
    vsub(v1, v2)

!!! warning "Deprecated"
    Use `v1 .- v2` instead.
"""
vsub

@deprecate vsub(v1, v2) v1 .- v2

function _vsubg(v1, v2)
    ndim = length(v1)
    vout = Array{SpiceDouble}(undef, ndim)
    ccall((:vsubg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}),
          v1, v2, ndim, vout)
    vout
end

"""
    vsubg(v1, v2)

!!! warning "Deprecated"
    Use `v1 .- v2` instead.
"""
vsubg

@deprecate vsubg(v1, v2) v1 .- v2

function _vtmv(v1, matrix, v2)
    ccall((:vtmv_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v1, permutedims(matrix), v2)
end

"""
    vtmv(v1, matrix, v2)

!!! warning "Deprecated"
    Use `v1' * matrix * v2` instead.
"""
vtmv

@deprecate vtmv(v1, matrix, v2) v1' * matrix * v2

function _vtmvg(v1, matrix, v2)
    m, n = size(matrix)
    ccall((:vtmvg_c, libcspice), SpiceDouble,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, SpiceInt),
          v1, permutedims(matrix), v2, n, m)
end

"""
    vtmvg(v1, matrix, v2)

!!! warning "Deprecated"
    Use `v1' * matrix * v2` instead.
"""
vtmvg

@deprecate vtmvg(v1, matrix, v2) v1' * matrix * v2

function _vupack(v)
    x = Ref{SpiceDouble}()
    y = Ref{SpiceDouble}()
    z = Ref{SpiceDouble}()
    ccall((:vupack_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v, x, y, z)
    x[], y[], z[]
end

"""
    vupack(v)

!!! warning "Deprecated"
    Use `x, y, z = v` instead.
"""
vupack

@deprecate vupack(v) (x, y, z) = v

function _vzero(v1)
    Bool(ccall((:vzero_c, libcspice), SpiceBoolean, (Ref{SpiceDouble},), v1))
end

"""
    vzero(v1)

!!! warning "Deprecated"
    Use `iszero(v1)` instead.
"""
vzero

@deprecate vzero(v1) iszero(v1)

function _vzerog(v1)
    ndim = length(v1)
    Bool(ccall((:vzerog_c, libcspice), SpiceBoolean,
               (Ref{SpiceDouble}, SpiceInt), v1, ndim))
end

"""
    vzerog(v1, v2)

!!! warning "Deprecated"
    Use `iszero(v1)` instead.
"""
vzerog

@deprecate vzerog(v1) iszero(v1)

