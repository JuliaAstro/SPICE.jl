export
    pckcov,
    pckcov!,
    pckfrm,
    pckfrm!,
    pcklof,
    pckuof,
    pxform,
    pcpool,
    pdpool,
    pgrrec

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
    pcpool(name, vals)

Insert character data into the kernel pool.

### Arguments ###

- `name`: The kernel pool name to associate with `vals`
- `vals`: An array of values to insert into the kernel pool

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pcpool_c.html)
"""
function pcpool(name, vals)
    cvals, n, lenvals = chararray(vals)
    ccall((:pcpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ptr{UInt8}),
          name, n, lenvals, cvals)
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
    ccall((:pdpool_c, libcspice), Cvoid, (Cstring, SpiceInt, Ptr{SpiceDouble}), name, n, vals)
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
          (Cstring, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, Ptr{SpiceDouble}),
          body, lon, lat, alt, re, f, rectan)
    handleerror()
    rectan
end

"""
Return the matrix that transforms position vectors from one specified frame to another at a specified epoch.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pxform_c.html
"""
function pxform(from::String, to::String, et::Float64)
    rot = Array{Cdouble}(undef, 3, 3)
    ccall((:pxform_c, libcspice), Cvoid, (Cstring, Cstring, Cdouble, Ptr{Cdouble}), from, to, et, rot)
    handleerror()
    return rot
end