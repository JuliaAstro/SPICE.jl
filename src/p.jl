export
    pckcls,
    pckcov!,
    pckcov,
    pckfrm!,
    pckfrm,
    pcklof,
    pckopn,
    pckuof,
    pckw02,
    pcpool,
    pdpool,
    pgrrec,
    phaseq,
    pipool,
    pjelpl,
    pl2nvc,
    pl2nvp,
    pl2psv,
    pltar,
    pltexp,
    pltnp,
    pltnrm,
    pltvol,
    polyds,
    pos,
    posr,
    prop2b,
    prsdp,
    prsint,
    psv2pl,
    pxform,
    pxfrm2

"""
    pckcls(handle)

Close an open PCK file.

### Arguments ###

- `handle`: Handle of the PCK file to be closed

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pckcls_c.html)
"""
function pckcls(handle)
    ccall((:pckcls_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    pckcov!(cover, pck, idcode)

Find the coverage window for a specified reference frame in a specified binary PCK file.

### Arguments ###

- `cover`: An initalized window `SpiceDoubleCell`
- `pck`: Path of PCK file
- `idcode`: Class ID code of PCK reference frame

### Output ###

Returns `cover` containing coverage in `pck` for `idcode`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pckcov_c.html)
"""
function pckcov!(cover, pck, idcode)
    ccall((:pckcov_c, libcspice), Cvoid, (Cstring, SpiceInt, Ref{Cell{SpiceDouble}}),
          pck, idcode, cover.cell)
    handleerror()
    cover
end

@deprecate pckcov pckcov!

"""
    pckfrm!(ids, pck)

Find the set of reference frame class ID codes of all frames in a specified binary PCK file.

### Arguments ###

- `ids`: An initalized `SpiceIntCell`
- `pck`: Path of PCK file

### Output ###

Returns `ids` containing a set of frame class ID codes of frames in PCK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pckfrm_c.html)
"""
function pckfrm!(ids, pck)
    ccall((:pckfrm_c, libcspice), Cvoid, (Cstring, Ref{Cell{SpiceInt}}),
          pck, ids.cell)
    handleerror()
    ids
end

@deprecate pckfrm pckfrm!

"""
    pcklof(filename)

Load a binary PCK file for use by the readers. Return the handle of the loaded
file which is used by other PCK routines to refer to the file.

### Arguments ###

- `filename`: Path of the PCK file

### Output ###

Returns an integer handle.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pcklof_c.html)
"""
function pcklof(filename)
    handle = Ref{SpiceInt}()
    ccall((:pcklof_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), filename, handle)
    handleerror()
    handle[]
end

"""
    pckopn(name, ifname, ncomch)

Create a new PCK file, returning the handle of the opened file.

### Arguments ###

- `name`: The name of the PCK file to be opened
- `ifname`: The internal filename for the PCK
- `ncomch`: The number of characters to reserve for comments

### Output ###

Returns the handle of the opened PCK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pckopn_c.html)
"""
function pckopn(name, ifname, ncomch)
    handle = Ref{SpiceInt}()
    ccall((:pckopn_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceInt, Ref{SpiceInt}),
          name, ifname, ncomch, handle)
    handleerror()
    handle[]
end

"""
    pckuof(handle)

Unload a binary PCK file so that it will no longer be searched by the readers.

### Arguments ###

- `handle`: Integer handle of a PCK file

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pckuof_c.html)
"""
function pckuof(handle)
    ccall((:pckuof_c, libcspice), Cvoid, (SpiceInt,), handle)
end

"""
    pckw02(handle, clssid, frame, first, last, segid, intlen, cdata, btime)

Write a type 2 segment to a PCK binary file given the file handle, frame class ID, base frame, time
range covered by the segment, and the Chebyshev polynomial coefficients.

### Arguments ###

- `handle`: Handle of binary PCK file open for writing.
- `clssid`: Frame class ID of body-fixed frame.
- `frame`: Name of base reference frame.
- `first`: Start time of interval covered by segment.
- `last`: End time of interval covered by segment.
- `segid`: Segment identifier.
- `intlen`: Length of time covered by logical record.
- `cdata`: Array of Chebyshev coefficients.
- `btime`: Begin time of first logical record.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pckw02_c.html)
"""
function pckw02(handle, clssid, frame, first, last, segid, intlen, cdata, btime)
    n = length(cdata)
    polydg = length(cdata[1]) - 1
    cdata_ = array_to_cmatrix(cdata, n=polydg + 1)
    ccall((:pckw02_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Cstring, SpiceDouble, SpiceDouble, Cstring, SpiceDouble, SpiceInt,
           SpiceInt, Ref{SpiceDouble}, SpiceDouble),
          handle, clssid, frame, first, last, segid, intlen, n, polydg, cdata_, btime)
    handleerror()
end

"""
    pcpool(name, vals)

Insert character data into the kernel pool.

### Arguments ###

- `name`: The kernel pool name to associate with `vals`
- `vals`: An array of values to insert into the kernel pool

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pcpool_c.html)
"""
function pcpool(name, vals)
    vals_, n, lenvals = chararray(vals)
    ccall((:pcpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}),
          name, n, lenvals, vals_)
    handleerror()
end

"""
    pdpool(name, vals)

Insert double precision data into the kernel pool.

### Arguments ###

- `name`: The kernel pool name to associate with `vals`
- `vals`: An array of values to insert into the kernel pool

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pdpool_c.html)
"""
function pdpool(name, vals)
    n = length(vals)
    ccall((:pdpool_c, libcspice), Cvoid, (Cstring, SpiceInt, Ref{SpiceDouble}), name, n, vals)
    handleerror()
end

"""
    pgrrec(body, lon, lat, alt, re, f)

Convert planetographic coordinates to rectangular coordinates.

### Arguments ###

- `body`: Body with which coordinate system is associated.
- `lon`: Planetographic longitude of a point (radians).
- `lat`: Planetographic latitude of a point (radians).
- `alt`: Altitude of a point above reference spheroid.
- `re`: Equatorial radius of the reference spheroid.
- `f`: Flattening coefficient.

### Output ###

Returns the rectangular coordinates of the point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pgrrec_c.html)
"""
function pgrrec(body, lon, lat, alt, re, f)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:pgrrec_c, libcspice), Cvoid,
          (Cstring, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          body, lon, lat, alt, re, f, rectan)
    handleerror()
    rectan
end

"""
    phaseq(et, target, illmn, obsrvr, abcorr)

Compute the apparent phase angle for a target, observer, illuminator set of ephemeris objects.

### Arguments ###

- `et`: Ephemeris seconds past J2000 TDB
- `target`: Target body name
- `illmn`: Illuminating body name
- `obsrvr`: Observer body
- `abcorr`: Aberration correction flag

### Output ###

Returns the value of the phase angle.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/phaseq_c.html)
"""
function phaseq(et, target, illmn, obsrvr, abcorr)
    retval = ccall((:phaseq_c, libcspice), SpiceDouble,
                   (SpiceDouble, Cstring, Cstring, Cstring, Cstring),
                   et, target, illmn, obsrvr, abcorr)
    handleerror()
    retval
end

# Deprecated
_pi() = ccall((:pi_c, libcspice), SpiceDouble, ())

"""
    pipool(name, ivals)

Insert integer data into the kernel pool.

### Arguments ###

- `name`: The kernel pool name to associate with the values
- `ivals`: An array of integers to insert into the pool

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pipool_c.html)
"""
function pipool(name, ivals)
    n = length(ivals)
    ivals_ = SpiceInt.(ivals)
    ccall((:pipool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceInt}),
          name, n, ivals_)
    handleerror()
end

"""
    pjelpl(elin, plane)

Project an ellipse onto a plane, orthogonally.

### Arguments ###

- `elin`: An ellipse to be projected
- `plane`: A plane onto which `elin` is to be projected

### Output ###

Returns the ellipse resulting from the projection.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pjelpl_c.html)
"""
function pjelpl(elin, plane)
    elout = Ref{Ellipse}()
    ccall((:pjelpl_c, libcspice), Cvoid,
          (Ref{Ellipse}, Ref{Plane}, Ref{Ellipse}),
          elin, plane, elout)
    handleerror()
    elout[]
end

"""
    pl2nvc(plane)

Return a unit normal vector and constant that define a specified plane.

### Arguments ###

- `plane`: A plane

### Output ###

Returns a tuple consisting of

- `normal`: A normal vector and...
- `constant`: ... constant defining the geometric plane represented by `plane`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pl2nvc_c.html)
"""
function pl2nvc(plane)
    normal = Array{SpiceDouble}(undef, 3)
    constant = Ref{SpiceDouble}()
    ccall((:pl2nvc_c, libcspice), Cvoid,
          (Ref{Plane}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          plane, normal, constant)
    normal, constant[]
end

"""
    pl2nvp(plane)

Return a unit normal vector and point that define a specified plane.

### Arguments ###

- `plane`: A plane

### Output ###

Returns a tuple consisting of

- `normal`: A normal vector and...
- `point`: ... point defining the geometric plane represented by `plane`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pl2nvp_c.html)
"""
function pl2nvp(plane)
    normal = Array{SpiceDouble}(undef, 3)
    point = Array{SpiceDouble}(undef, 3)
    ccall((:pl2nvp_c, libcspice), Cvoid,
          (Ref{Plane}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          plane, normal, point)
    normal, point
end

"""
    pl2psv(plane)

Return a point and two orthogonal spanning vectors that define a specified plane.

### Arguments ###

- `plane`: A plane

### Output ###

Returns a tuple consisting of a point in the `plane` and two vectors spanning
the input plane.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pl2psv_c.html)
"""
function pl2psv(plane)
    point = Array{SpiceDouble}(undef, 3)
    span1 = Array{SpiceDouble}(undef, 3)
    span2 = Array{SpiceDouble}(undef, 3)
    ccall((:pl2psv_c, libcspice), Cvoid,
          (Ref{Plane}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          plane, point, span1, span2)
    point, span1, span2
end

"""
    pltar(vrtces, plates)

Compute the total area of a collection of triangular plates.

### Arguments ###

- `vrtces`: Array of vertices
- `plates`: Array of plates

### Output ###

Returns the area.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pltar_c.html)
"""
function pltar(vrtces, plates)
    nv = length(vrtces)
    np = length(plates)
    vrtces_ = array_to_cmatrix(vrtces)
    plates_ = array_to_cmatrix(plates)
    res = ccall((:pltar_c, libcspice), SpiceDouble,
                (SpiceInt, Ref{SpiceDouble}, SpiceInt, Ref{SpiceInt}),
                nv, vrtces_, np, plates_)
    handleerror()
    res
end

"""
    pltexp(iverts, delta)

Expand a triangular plate by a specified amount. The expanded plate is co-planar with,
and has the same orientation as, the original. The centroids of the two plates coincide.

### Arguments ###

- `iverts`: Vertices of the plate to be expanded
- `delta`: Fraction by which the plate is to be expanded

### Output ###

Returns the vertices of the expanded plate.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pltexp_c.html)
"""
function pltexp(iverts, delta)
    iverts_ = array_to_cmatrix(iverts)
    overts = Array{SpiceDouble}(undef, 3, 3)
    ccall((:pltexp_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}),
          iverts_, delta, overts)
    cmatrix_to_array(overts)
end

"""
    pltnp(point, v1, v2, v3)

Find the nearest point on a triangular plate to a given point.

### Arguments ###

- `point`: A point in 3-dimensional space.
- `v1`, `v2`, `v3`: Vertices of a triangular plate

### Output ###

Returns a tuple consisting of

- `pnear`: Nearest point on the plate to `point`
- `dist`: Distance between `pnear` and `point`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pltnp_c.html)
"""
function pltnp(point, v1, v2, v3)
    @checkdims 3 point v1 v2 v3
    pnear = Array{SpiceDouble}(undef, 3)
    dist = Ref{SpiceDouble}()
    ccall((:pltnp_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}),
          point, v1, v2, v3, pnear, dist)
    pnear, dist[]
end

"""
    pltnrm(v1, v2, v3)

Compute an outward normal vector of a triangular plate.  The vector does not
necessarily have unit length.

### Arguments ###

- `v1`, `v2`, `v3`: Vertices of a plate

### Output ###

Returns the plate's outward normal vector.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pltnrm_c.html)
"""
function pltnrm(v1, v2, v3)
    @checkdims 3 v1 v2 v3
    normal = Array{SpiceDouble}(undef, 3)
    ccall((:pltnrm_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v1, v2, v3, normal)
    normal
end

"""
    pltvol(vrtces, plates)

Compute the volume of a three-dimensional region bounded by a collection of triangular plates.

### Arguments ###

- `vrtces`: Array of vertices
- `plates`: Array of plates

### Output ###

Returns the volume of the spatial region bounded by the plates.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pltvol_c.html)
"""
function pltvol(vrtces, plates)
    nv = length(vrtces)
    np = length(plates)
    vrtces_ = array_to_cmatrix(vrtces, n=3)
    plates_ = array_to_cmatrix(plates, n=3)
    res = ccall((:pltvol_c, libcspice), SpiceDouble,
                (SpiceInt, Ref{SpiceDouble}, SpiceInt, Ref{SpiceInt}),
                nv, vrtces_, np, plates_)
    handleerror()
    res
end

"""
    polyds(coeffs, nderiv, t)

Compute the value of a polynomial and it's first `nderiv` derivatives at the value `t`.

### Arguments ###

- `coeffs`: Coefficients of the polynomial to be evaluated
- `nderiv`: Number of derivatives to compute
- `t`: Point to evaluate the polynomial and derivatives

### Output ###

Returns the value of the polynomial and the derivatives as an array.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/polyds_c.html)
"""
function polyds(coeffs, nderiv, t)
    deg = length(coeffs) - 1
    p = Array{SpiceDouble}(undef, nderiv + 1)
    ccall((:polyds_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, SpiceInt, SpiceDouble, Ref{SpiceDouble}),
          coeffs, deg, nderiv, t, p)
    p
end

function _pos(str, substr, start)
    res = ccall((:pos_c, libcspice), SpiceInt,
                (Cstring, Cstring, SpiceInt),
                str, substr, start - 1)
    handleerror()
    res == -1 ? res : res + 1
end

@deprecate pos(str, substr, start) first(findnext(substr, str, start))

"""
    pos(str, substr, start)

!!! warning "Deprecated"
    Use `first(findnext(substr, str, start))` instead.
"""
pos

function _posr(str, substr, start)
    res = ccall((:posr_c, libcspice), SpiceInt,
                (Cstring, Cstring, SpiceInt),
                str, substr, start - 1)
    handleerror()
    res == -1 ? res : res + 1
end

@deprecate posr(str, substr, start) first(findprev(substr, str, start))

"""
    posr(str, substr, start)

!!! warning "Deprecated"
    Use `first(findprev(substr, str, start))` instead.
"""
posr

"""
    prop2b(gm, pvinit, dt)

Given a central mass and the state of massless body at time `t_0`, this routine determines
the state as predicted by a two-body force model at time `t_0 + dt`.

### Arguments ###

- `gm`: Gravity of the central mass.
- `pvinit`: Initial state from which to propagate a state.
- `dt`: Time offset from initial state to propagate to.

### Output ###

Returns the propagated state.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/prop2b_c.html)
"""
function prop2b(gm, pvinit, dt)
    @checkdims 6 pvinit
    pvprop = Array{SpiceDouble}(undef, 6)
    ccall((:prop2b_c, libcspice), Cvoid,
          (SpiceDouble, Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}),
          gm, pvinit, dt, pvprop)
    handleerror()
    pvprop
end

function _prsdp(str)
    dp = Ref{SpiceDouble}()
    ccall((:prsdp_c, libcspice), Cvoid, (Cstring, Ref{SpiceDouble}), str, dp)
    dp[]
end

@deprecate prsdp(str) parse(Float64, str)

"""
    prsdp(str)

!!! warning "Deprecated"
    Use `parse(Float64, str)` instead.
"""
prsdp

function _prsint(str)
    int = Ref{SpiceInt}()
    ccall((:prsint_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), str, int)
    int[]
end

@deprecate prsint(str) parse(Int, str)

"""
    prsint(str)

!!! warning "Deprecated"
    Use `parse(Int, str)` instead.
"""
prsint

"""
    psv2pl(point, span1, span2)

Make a plane from a point and two spanning vectors.

### Arguments ###

- `point`, `span1`, `span2`: A point and two spanning vectors defining a plane

### Output ###

Returns the plane.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/psv2pl_c.html)
"""
function psv2pl(point, span1, span2)
    @checkdims 3 point span1 span2
    plane = Ref{Plane}()
    ccall((:psv2pl_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{Plane}),
          point, span1, span2, plane)
    handleerror()
    plane[]
end

"""
    pxform(from, to, et)

Return the matrix that transforms position vectors from one specified frame to
another at a specified epoch.

### Arguments ###

- `from`: Name of the frame to transform from
- `to`: Name of the frame to transform to
- `et`: Epoch of the rotation matrix

### Output ###

Returns the rotation matrix.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pxform_c.html)
"""
function pxform(from, to, et)
    rot = Array{SpiceDouble}(undef, 3, 3)
    ccall((:pxform_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Ref{SpiceDouble}),
          from, to, et, rot)
    handleerror()
    permutedims(rot)
end

"""
    pxfrm2(from, to, etfrom, etto)

Return the 3x3 matrix that transforms position vectors from one specified frame at a
specified epoch to another specified frame at another specified epoch.

### Arguments ###

- `from`: Name of the frame to transform from
- `to`: Name of the frame to transform to
- `etfrom`: Evaluation time of `from` frame
- `etto`: Evaluation time of `to` frame

### Output ###

Returns a position transformation matrix from frame `from` to frame `to`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pxfrm2_c.html)
"""
function pxfrm2(from, to, etfrom, etto)
    rot = Array{SpiceDouble}(undef, 3, 3)
    ccall((:pxfrm2_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          from, to, etfrom, etto, rot)
    handleerror()
    permutedims(rot)
end

