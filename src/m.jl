export
    m2eul,
    matchi,
    matchw,
    maxd,
    maxi,
    mequ,
    mequg,
    mind,
    mini,
    mtxm,
    mtxmg,
    mtxv,
    mtxvg,
    mxm,
    mxmg,
    mxmt,
    mxmtg,
    mxv,
    mxvg,
    m2q

"""
    m2eul(r, axis3, axis2, axis1)

Factor a rotation matrix as a product of three rotations about specified coordinate axes.

### Arguments ###

- `r`: A rotation matrix to be factored
- `axis3`: Number of the third rotation axis
- `axis2`: Number of the second rotation axis
- `axis1`: Number of the first rotation axis

### Output ###

A tuple consisting of the third, second, and first Euler angles in radians.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/m2eul_c.html)
"""
function m2eul(r, axis3, axis2, axis1)
    @checkdims 3 3 r
    angle3 = Ref{SpiceDouble}()
    angle2 = Ref{SpiceDouble}()
    angle1 = Ref{SpiceDouble}()
    ccall((:m2eul_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
           permutedims(r), axis3, axis2, axis1, angle3, angle2, angle1)
    handleerror()
    angle3[], angle2[], angle1[]
end

"""
    matchi(string, templ, wstr, wchar)

Determine whether a string is matched by a template containing wild cards.
The pattern comparison is case-insensitive.

### Arguments ###

- `string`: String to be tested
- `templ`: Template (with wild cards) to test against string
- `wstr`: Wild string token
- `wchr`: Wild character token

### Output ###

Returns `true` if the string matches.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/matchi_c.html)
"""
function matchi(string, templ, wstr, wchar)
    res = Bool(ccall((:matchi_c, libcspice), SpiceBoolean, (Cstring, Cstring, SpiceChar, SpiceChar),
          string, templ, first(wstr), first(wchar)))
    handleerror()
    res
end

"""
    matchw(string, templ, wstr, wchar)

Determine whether a string is matched by a template containing wild cards.

### Arguments ###

- `string`: String to be tested
- `templ`: Template (with wild cards) to test against string
- `wstr`: Wild string token
- `wchr`: Wild character token

### Output ###

Returns `true` if the string matches.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/matchw_c.html)
"""
function matchw(string, templ, wstr, wchar)
    res = Bool(ccall((:matchw_c, libcspice), SpiceBoolean, (Cstring, Cstring, SpiceChar, SpiceChar),
          string, templ, first(wstr), first(wchar)))
    handleerror()
    res
end

function _maxd(args...)
    n = length(args)
    @eval ccall((:maxd_c, libcspice), SpiceDouble, (SpiceInt, SpiceDouble...), $n, $(args...))
end

"""
    maxd(args...)

!!! warning "Deprecated"
    Use `max(args...)` instead.
"""
maxd

@deprecate maxd max

function _maxi(args...)
    n = length(args)
    @eval ccall((:maxi_c, libcspice), SpiceInt, (SpiceInt, SpiceInt...), $n, $(args...))
end

"""
    maxi(args...)

!!! warning "Deprecated"
    Use `max(args...)` instead.
"""
maxi

@deprecate maxi max

function _mequ(a, b)
    ccall((:mequ_c, libcspice), Cvoid, (Ref{SpiceDouble}, Ref{SpiceDouble}), a, b)
end

"""
    mequ(m1, mout)

!!! warning "Deprecated"
    Use `mout .= m1` instead.
"""
mequ

@deprecate mequ(m1, mout) mout .= m1

function _mequg(a, b)
    m, n = size(a)
    ccall((:mequg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, SpiceInt, Ref{SpiceDouble}), a, m, n, b)
end

"""
    mequg(m1, mout)

!!! warning "Deprecated"
    Use `mout .= m1` instead.
"""
mequg

@deprecate mequg(m1, mout) mout .= m1

function _mind(args...)
    n = length(args)
    @eval ccall((:mind_c, libcspice), SpiceDouble, (SpiceInt, SpiceDouble...), $n, $(args...))
end

"""
    mind(args...)

!!! warning "Deprecated"
    Use `min(args...)` instead.
"""
mind

@deprecate mind min

function _mini(args...)
    n = length(args)
    @eval ccall((:mini_c, libcspice), SpiceInt, (SpiceInt, SpiceInt...), $n, $(args...))
end

"""
    mini(args...)

!!! warning "Deprecated"
    Use `min(args...)` instead.
"""
mini

@deprecate mini min

function _mtxm(m1, m2)
    mout = Array{SpiceDouble}(undef, 3, 3)
    ccall((:mtxm_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          permutedims(m1), permutedims(m2), mout)
    permutedims(mout)
end

"""
    mtxm(m1, m2)

!!! warning "Deprecated"
    Use `m1' * m2` instead.
"""
mtxm

@deprecate mtxm(m1, m2) m1' * m2

function _mtxmg(m1, m2)
    l1, n = size(m1)
    l2, k = size(m2)
    @assert l1 == l2
    mout = Array{SpiceDouble}(undef, k, n)
    ccall((:mtxmg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          permutedims(m1), permutedims(m2), n, l1, k, mout)
    permutedims(mout)
end

"""
    mtxmg(m1, m2)

!!! warning "Deprecated"
    Use `m1' * m2` instead.
"""
mtxmg

@deprecate mtxmg(m1, m2) m1' * m2

function _mtxv(m1, v2)
    vout = Array{Float64}(undef, 3)
    ccall((:mtxv_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          permutedims(m1), v2, vout)
    handleerror()
    vout
end

"""
    mtxv(m1,v2)

!!! warning "Deprecated"
    Use `m1' * v2` instead.
"""
mtxv

@deprecate mtxv(m1, v2) m1' * v2

function _mtxvg(m1, v2)
    lm1, lm2 = size(m1)
    lv = length(v2)
    @assert lm1 == lv
    vout = Array{Float64}(undef, lm2)
    ccall((:mtxvg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          permutedims(m1), v2, lm2, lm1, vout)
    handleerror()
    vout
end

"""
    mtxvg(m1,v2)

!!! warning "Deprecated"
    Use `m1' * v2` instead.
"""
mtxvg

@deprecate mtxvg(m1, v2) m1' * v2

function _mxm(m1, m2)
    mout = Array{SpiceDouble}(undef, 3, 3)
    ccall((:mxm_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          permutedims(m1), permutedims(m2), mout)
    permutedims(mout)
end

"""
    mxm(m1, m2)

!!! warning "Deprecated"
    Use `m1 * m2` instead.
"""
mxm

@deprecate mxm(m1, m2) m1 * m2

function _mxmg(m1, m2)
    n, l1 = size(m1)
    l2, k = size(m2)
    @assert l1 == l2
    mout = Array{SpiceDouble}(undef, k, n)
    ccall((:mxmg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          permutedims(m1), permutedims(m2), n, l1, k, mout)
    permutedims(mout)
end

"""
    mxmg(m1, m2)

!!! warning "Deprecated"
    Use `m1 * m2` instead.
"""
mxmg

@deprecate mxmg(m1, m2) m1 * m2

function _mxmt(m1, m2)
    mout = Array{SpiceDouble}(undef, 3, 3)
    ccall((:mxmt_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          permutedims(m1), permutedims(m2), mout)
    permutedims(mout)
end

"""
    mxmt(m1, m2)

!!! warning "Deprecated"
    Use `m1 * m2'` instead.
"""
mxmt

@deprecate mxmt(m1, m2) m1 * m2'

function _mxmtg(m1, m2)
    n, l1 = size(m1)
    k, l2 = size(m2)
    @assert l1 == l2
    mout = Array{SpiceDouble}(undef, k, n)
    ccall((:mxmtg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          permutedims(m1), permutedims(m2), n, l1, k, mout)
    permutedims(mout)
end

"""
    mxmtg(m1, m2)

!!! warning "Deprecated"
    Use `m1 * m2'` instead.
"""
mxmtg

@deprecate mxmtg(m1, m2) m1 * m2'

function _mxv(m1, v2)
    vout = Array{Float64}(undef, 3)
    ccall((:mxv_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          permutedims(m1), v2, vout)
    handleerror()
    vout
end

"""
    mxv(m1,v2)

!!! warning "Deprecated"
    Use `m1 * v2` instead.
"""
mxv

@deprecate mxv(m1, v2) m1 * v2

function _mxvg(m1, v2)
    lm1, lm2 = size(m1)
    lv = length(v2)
    @assert lm2 == lv
    vout = Array{Float64}(undef, lm1)
    ccall((:mxvg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          permutedims(m1), v2, lm1, lm2, vout)
    handleerror()
    vout
end

"""
    mxvg(m1,v2)

!!! warning "Deprecated"
    Use `m1 * v2` instead.
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
    @checkdims 3 3 r
    q = Array{SpiceDouble}(undef, 4)
    ccall((:m2q_c, libcspice), Cvoid, (Ref{Float64}, Ref{Float64}), permutedims(r), q)
    handleerror()
    q
end

