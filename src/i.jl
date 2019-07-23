export
    ident,
    illum,
    illum_pl02,
    illum_plid_pl02,
    illumf,
    illumg,
    ilumin,
    inedpl,
    inelpl,
    inrypl,
    insrtc!,
    insrtc,
    insrtd!,
    insrtd,
    insrti!,
    insrti,
    inter,
    intmax,
    intmin,
    invert,
    invort,
    isordv,
    isrchc,
    isrchd,
    isrchi,
    isrot,
    iswhsp

function _ident()
    matrix = Array{SpiceDouble}(undef, 3, 3)
    ccall((:ident_c, libcspice), Cvoid, (Ref{SpiceDouble},), matrix)
    matrix
end

@deprecate ident() Array{Float64}(LinearAlgebra.I, 3, 3)

"""
    illumf(method, target, ilusrc, et, fixref, abcorr, obsrvr, spoint)

Compute the illumination angles - phase, incidence, and emission - at a specified point on a
target body. Return logical flags indicating whether the surface point is visible from the
observer's position and whether the surface point is illuminated.

The target body's surface is represented using topographic data provided by DSK files, or by a
reference ellipsoid.

The illumination source is a specified ephemeris object.

### Arguments ###

- `method`: Computation method
- `target`: Name of target body
- `ilusrc`: Name of illumination source
- `et`: Epoch in TDB seconds past J2000 TDB
- `fixref`: Body-fixed, body-centered target body frame
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of observing body
- `spoint`: Body-fixed coordinates of a target surface point

### Output ###

- `trgepc`: Target surface point epoch
- `srfvec`: Vector from observer to target surface point
- `phase`: Phase angle at the surface point
- `incdnc`: Source incidence angle at the surface point
- `emissn`: Emission angle at the surface point
- `visibl`: Visibility flag (`true` if visible)
- `lit`: Illumination flag (`true` if illuminated)

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/illumf_c.html)
"""
function illumf(method, target, ilusrc, et, fixref, abcorr, obsrvr, spoint)
    @checkdims 3 spoint
    trgepc = Ref{SpiceDouble}()
    srfvec = Array{SpiceDouble}(undef, 3)
    phase = Ref{SpiceDouble}()
    incdnc = Ref{SpiceDouble}()
    emissn = Ref{SpiceDouble}()
    visibl = Ref{SpiceBoolean}()
    lit = Ref{SpiceBoolean}()
    ccall((:illumf_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceBoolean}, Ref{SpiceBoolean}),
          method, target, ilusrc, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec, phase, incdnc,
          emissn, visibl, lit)
    handleerror()
    trgepc[], srfvec, phase[], incdnc[], emissn[], Bool(visibl[]), Bool(lit[])
end

"""
    illumg(method, target, ilusrc, et, fixref, obsrvr, spoint, abcorr)

Find the illumination angles (phase, incidence, and emission) at a specified surface point of a
target body.

The surface of the target body may be represented by a triaxial ellipsoid or by topographic data
provided by DSK files.

The illumination source is a specified ephemeris object.

### Arguments ###

- `method`: Computation method.
- `target`: Name of target body.
- `ilusrc`: Name of illumination source.
- `et`: Epoch in ephemeris seconds past J2000 TDB.
- `fixref`: Body-fixed, body-centered target body frame.
- `obsrvr`: Name of observing body.
- `spoint`: Body-fixed coordinates of a target surface point.
- `abcorr`: Aberration correction.

### Output ###

- `trgepc`: Sub-solar point epoch.
- `srfvec`: Vector from observer to sub-solar point.
- `phase`: Phase angle at the surface point.
- `incdnc`: Solar incidence angle at the surface point.
- `emissn`: Emission angle at the surface point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/illumg_c.html)
"""
function illumg(method, target, ilusrc, et, fixref, obsrvr, spoint; abcorr="NONE")
    trgepc = Ref{SpiceDouble}(0)
    srfvec = Array{SpiceDouble}(undef, 3)
    phase  = Ref{SpiceDouble}(0)
    incdnc = Ref{SpiceDouble}(0)
    emissn = Ref{SpiceDouble}(0)
    ccall((:illumg_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
           Ref{SpiceDouble}),
          method, target, ilusrc, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec, phase,
          incdnc, emissn)
    handleerror()
    trgepc[], srfvec, phase[], incdnc[], emissn[]
end

@deprecate illum illumin
@deprecate illum_pl02 illumin
@deprecate illum_plid_pl02 illumin

"""
    ilumin(method, target, et, fixref, obsrvr, spoint, abcorr)

Find the illumination angles (phase, solar incidence, and emission) at a specified surface point
of a target body.

### Arguments ###

- `method`: Computation method
- `target`: Name of target body
- `et`: Epoch in ephemeris seconds past J2000 TDB
- `fixref`: Body-fixed, body-centered target body frame
- `obsrvr`: Name of observing body
- `spoint`: Body-fixed coordinates of a target surface point
- `abcorr`: Aberration correction

### Output ###

- `trgepc`: Sub-solar point epoch
- `srfvec`: Vector from observer to sub-solar point
- `phase`: Phase angle at the surface point
- `incdnc`: Solar incidence angle at the surface point
- `emissn`: Emission angle at the surface point

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ilumin_c.html
"""
function ilumin(method, target, et, fixref, obsrvr, spoint; abcorr="NONE")
    trgepc = Ref{SpiceDouble}()
    srfvec = Array{SpiceDouble}(undef, 3)
    phase  = Ref{SpiceDouble}()
    incdnc = Ref{SpiceDouble}()
    emissn = Ref{SpiceDouble}()
    ccall((:ilumin_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
           Ref{SpiceDouble}),
          method, target, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec, phase, incdnc, emissn)
    handleerror()
    trgepc[], srfvec, phase[], incdnc[], emissn[]
end

"""
    inedpl(a, b, c, plane)

Find the intersection of a triaxial ellipsoid and a plane.

### Arguments ###

- `a`: Length of ellipsoid semi-axis lying on the x-axis
- `b`: Length of ellipsoid semi-axis lying on the y-axis
- `c`: Length of ellipsoid semi-axis lying on the z-axis
- `plane`: Plane that intersects ellipsoid

### Output ###

- `ellipse`: Intersection ellipse

Returns `nothing` if no ellipse could be found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/inedpl_c.html)
"""
function inedpl(a, b, c, plane)
    ellipse = Ref{Ellipse}()
    found = Ref{SpiceBoolean}()
    ccall((:inedpl_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{Plane}, Ref{Ellipse}, Ref{SpiceBoolean}),
          a, b, c, plane, ellipse, found)
    handleerror()
    Bool(found[]) || return nothing
    ellipse[]
end

"""
    inelpl(ellips, plane)

Find the intersection of an ellipse and a plane.

### Arguments ###

- `ellips`: An ellipse
- `plane`: A plane

### Output ###

- `nxpts`: Number of intersection points of ellipse and plane
- `xpt1`, `xpt2`: Intersection points

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/inelpl_c.html)
"""
function inelpl(ellips, plane)
    nxpts = Ref{SpiceInt}()
    xpt1 = Array{SpiceDouble}(undef, 3)
    xpt2 = Array{SpiceDouble}(undef, 3)
    ccall((:inelpl_c, libcspice), Cvoid,
          (Ref{Ellipse}, Ref{Plane}, Ref{SpiceInt}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          ellips, plane, nxpts, xpt1, xpt2)
    handleerror()
    Int(nxpts[]), xpt1, xpt2
end

"""
    inrypl(vertex, dir, plane)

Find the intersection of a ray and a plane.

### Arguments ###

- `vertex`, `dir`: Vertex and direction vector of ray
- `plane`: A plane

### Output ###

- `nxpts`: Number of intersection points of ray and plane
- `xpt1`, `xpt2`: Intersection points

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/inrypl_c.html)
"""
function inrypl(vertex, dir, plane)
    @checkdims 3 vertex dir
    nxpts = Ref{SpiceInt}()
    xpt = Array{SpiceDouble}(undef, 3)
    ccall((:inrypl_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{Plane}, Ref{SpiceInt}, Ref{SpiceDouble}),
          vertex, dir, plane, nxpts, xpt)
    handleerror()
    Int(nxpts[]), xpt
end

"""
    insrtc!(set, item)

Insert an item into a character set.

### Arguments ###

- `set`: Insertion set
- `item`: Item to be inserted

### Output ###

Returns the updated set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/insrtc_c.html)
"""
function insrtc!(set, item)
    ccall((:insrtc_c, libcspice), Cvoid, (Cstring, Ref{Cell{SpiceChar}}), item, set.cell)
    set
end

@deprecate insrtc insrtc!

"""
    insrtd!(set, item)

Insert an item into a double set.

### Arguments ###

- `set`: Insertion set
- `item`: Item to be inserted

### Output ###

Returns the updated set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/insrtd_c.html)
"""
function insrtd!(set, item)
    ccall((:insrtd_c, libcspice), Cvoid, (SpiceDouble, Ref{Cell{SpiceDouble}}), item, set.cell)
    set
end

@deprecate insrtd insrtd!

"""
    insrti!(set, item)

Insert an item into an integer set.

### Arguments ###

- `set`: Insertion set
- `item`: Item to be inserted

### Output ###

Returns the updated set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/insrti_c.html)
"""
function insrti!(set, item)
    ccall((:insrti_c, libcspice), Cvoid, (SpiceInt, Ref{Cell{SpiceInt}}), item, set.cell)
    set
end

@deprecate insrti insrti!

"""
    inter(a, b)

Intersect two sets of any data type to form a third set.

### Arguments ###

- `a`: First input set
- `b`: Second input set

### Output ###

Returns intersection of a and b.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/inter_c.html)
"""
function inter(a::SpiceCell{T}, b::SpiceCell{T}) where {T}
    n = card(a) + card(b)
    l = max(a.cell.length, b.cell.length)
    out = SpiceCell{T}(n, l)
    ccall((:inter_c, libcspice), Cvoid,
              (Ref{Cell{T}}, Ref{Cell{T}}, Ref{Cell{T}}),
              a.cell, b.cell, out.cell)
    handleerror()
    out
end

function _intmax()
    ccall((:intmax_c, libcspice), SpiceInt, ())
end

@deprecate intmax() typemax(Cint)

"""
    intmax()

!!! warning "Deprecated"
    Use `typemax(Cint)` instead.
"""
intmax

function _intmin()
    ccall((:intmin_c, libcspice), SpiceInt, ())
end

@deprecate intmin() typemin(Cint)

"""
    intmin()

!!! warning "Deprecated"
    Use `typemin(Cint)` instead.
"""
intmin

function _invert(matrix)
    out = Array{SpiceDouble}(undef, 3, 3)
    ccall((:invert_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}),
          matrix, out)
    out
end

@deprecate invert inv

"""
    invert(matrix)

!!! warning "Deprecated"
    Use `inv(matrix)` instead.
"""
invert

function _invort(matrix)
    out = Array{SpiceDouble}(undef, 3, 3)
    ccall((:invort_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}),
          matrix, out)
    out
end

@deprecate invort inv

"""
    invort(matrix)

!!! warning "Deprecated"
    Use `inv(matrix)` instead.
"""
invort

function _isordv(vec)
    vec_ = SpiceInt.(vec .- 1)
    n = length(vec)
    res = ccall((:isordv_c, libcspice), SpiceBoolean,
                (Ref{SpiceInt}, SpiceInt),
                vec_, n)
    Bool(res[])
end

@deprecate isordv isperm

"""
    isordv(vec)

!!! warning "Deprecated"
    Use `isperm(vec)` instead.
"""
isordv

function _isrchc(value, array)
    array_, m, n = chararray(array)
    res = ccall((:isrchc_c, libcspice), SpiceInt,
                (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}),
                value, m, n, array_)
    handleerror()
    res[] + 1
end

@deprecate isrchc(value, array) findfirst(array .== item)

"""
    isrchc(value, array)

!!! warning "Deprecated"
    Use `findfirst(array .== value)` instead.
"""
isrchc

function _isrchd(value, array)
    n = length(array)
    res = ccall((:isrchd_c, libcspice), SpiceBoolean,
                (SpiceDouble, SpiceInt, Ref{SpiceDouble}),
                value, n, array)
    handleerror()
    res[] + 1
end

@deprecate isrchd(value, array) findfirst(array .== item)

"""
    isrchd(value, array)

!!! warning "Deprecated"
    Use `findfirst(array .== value)` instead.
"""
isrchd

function _isrchi(value, array)
    array_ = SpiceInt.(array)
    n = length(array)
    res = ccall((:isrchi_c, libcspice), SpiceBoolean,
                (SpiceInt, SpiceInt, Ref{SpiceInt}),
                value, n, array_)
    handleerror()
    res[] + 1
end

@deprecate isrchi(value, array) findfirst(array .== item)

"""
    isrchi(value, array)

!!! warning "Deprecated"
    Use `findfirst(array .== value)` instead.
"""
isrchi

"""
    isrot(m, ntol, dtol)

Indicate whether a 3x3 matrix is a rotation matrix.

### Arguments ###

- `m`: A matrix to be tested
- `ntol`: Tolerance for the norms of the columns of `m`
- `dtol`: Tolerance for the determinant of a matrix whose columns are the unitized columns of `m`

### Output ###

Returns `true` if `m` is a rotation matrix.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/isrot_c.html)
"""
function isrot(m, ntol, dtol)
    @checkdims 3 3 m
    res = ccall((:isrot_c, libcspice), SpiceBoolean,
                (Ref{SpiceDouble}, SpiceDouble, SpiceDouble),
                m, ntol, dtol)
    handleerror()
    Bool(res[])
end

function _iswhsp(str)
    res = ccall((:iswhsp_c, libcspice), SpiceBoolean,
                (Cstring,),
                str)
    handleerror()
    Bool(res[])
end

@deprecate iswhsp(str) isempty(strip(str))

"""
    iswhsp(str)

!!! warning "Deprecated"
    Use `isempty(strip(str))` instead.
"""
iswhsp

