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
    inter

function _ident()
    matrix = Array{SpiceDouble}(undef, 3, 3)
    ccall((:ident_c, libcspice), Cvoid, (Ptr{SpiceDouble},), matrix)
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
    length(spoint) != 3 && throw(ArgumentError("Length of `spoint` must be 3."))
    trgepc = Ref{SpiceDouble}()
    srfvec = Array{SpiceDouble}(undef, 3)
    phase = Ref{SpiceDouble}()
    incdnc = Ref{SpiceDouble}()
    emissn = Ref{SpiceDouble}()
    visibl = Ref{SpiceBoolean}()
    lit = Ref{SpiceBoolean}()
    ccall((:illumf_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble},
           Ref{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
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

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/illumg_c.html
"""
function illumg(method, target, ilusrc, et, fixref, obsrvr, spoint; abcorr="NONE")
    trgepc = Ref{SpiceDouble}(0)
    srfvec = Array{SpiceDouble}(undef, 3)
    phase  = Ref{SpiceDouble}(0)
    incdnc = Ref{SpiceDouble}(0)
    emissn = Ref{SpiceDouble}(0)
    ccall((:illumg_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble},
           Ref{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
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

- `method`: Computation method.
- `target`: Name of target body.
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

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ilumin_c.html
"""
function ilumin(method, target, et, fixref, obsrvr, spoint; abcorr="NONE")
    trgepc = Ref{SpiceDouble}(0)
    srfvec = Array{SpiceDouble}(undef, 3)
    phase  = Ref{SpiceDouble}(0)
    incdnc = Ref{SpiceDouble}(0)
    emissn = Ref{SpiceDouble}(0)
    ccall((:ilumin_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble},
           Ref{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
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

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/XXX_c.html)
"""
function inedpl(a, b, c, plane)
    ellipse = Ellipse()
    found = Ref{SpiceBoolean}()
    ccall((:inedpl_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{Plane}, Ref{Ellipse}, Ref{SpiceBoolean}),
          a, b, c, plane, ellipse, found)
    handleerror()
    !Bool(found[]) && return nothing
    ellipse
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
          (Ref{Ellipse}, Ref{Plane}, Ref{SpiceInt}, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          ellips, plane, nxpts, xpt1, xpt2)
    handleerror()
    nxpts[], xpt1, xpt2
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
    length(vertex) != 3 && throw(ArgumentError("Length of `vertex` must be 3."))
    length(dir) != 3 && throw(ArgumentError("Length of `dir` must be 3."))
    nxpts = Ref{SpiceInt}()
    xpt = Array{SpiceDouble}(undef, 3)
    ccall((:inrypl_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ref{Plane}, Ref{SpiceInt}, Ptr{SpiceDouble}),
          vertex, dir, plane, nxpts, xpt)
    handleerror()
    nxpts[], xpt
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

Insert an item into a character set.

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
function inter(a::T, b::T) where {T <: SpiceCell{S}} where S
	n = card(a) + card(b)
	l = max(a.cell.length, b.cell.length)
	out = SpiceCell{S}(n, l)
	ccall((:inter_c, libcspice), Cvoid,
		  (Ref{Cell{S}}, Ref{Cell{S}}, Ref{Cell{S}}),
		  a.cell, b.cell, out.cell)
	handleerror()
	out
end

