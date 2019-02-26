export
    ccifrm,
    cgv2el,
    cidfrm,
    ckcls,
    ckcov,
    ckcov!,
    ckobj,
    ckobj!,
    ckgp,
    ckgpav,
    cklpf,
    ckopn,
    ckupf,
    ckw01,
    clight,
    clpool,
    cmprss,
    cnmfrm,
    conics,
    convrt,
    cpos,
    cposr,
    cvpool,
    cyllat,
    cylrec,
    cylsph

"""
    ccifrm(frclss, clssid)

Return the frame name, frame ID, and center associated with a given frame class and class ID.

### Arguments ###

- `frclss`: Class of frame
- `clssid`: Class ID of frame

### Output ###

Return the tuple `(frcode, frname, center)`.

- `frcode`: ID code of the frame
- `frname`: Name of the frame
- `center`: ID code of the center of the frame

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ccifrm_c.html)
"""
function ccifrm(frclss, clssid)
    lenout = 33
    frcode = Ref{SpiceInt}()
    frname = Array{UInt8}(undef, lenout)
    center = Ref{SpiceInt}()
    found = Ref{SpiceBoolean}()
    ccall((:ccifrm_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{UInt8}, Ref{SpiceInt}, Ref{SpiceBoolean}),
          frclss, clssid, lenout, frcode, frname, center, found,
         )
    handleerror()
    found[] == 0 && throw(SpiceError("No frame with class $frclss and class ID $clssid found."))
    frcode[], chararray_to_string(frname), center[]
end

"""
    cgv2el(center, vec1, vec2)

Form a CSPICE ellipse from a center vector and two generating vectors.

### Arguments ###

- `center`: Center vector
- `vec1`: Generating vector
- `vec2`: Generating vector

### Output ###

The CSPICE ellipse defined by the input vectors.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cgv2el_c.html)
"""
function cgv2el(center, vec1, vec2)
    ellipse = Ellipse()
    ccall((:cgv2el_c, libcspice), Cvoid,
        (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ref{Ellipse}),
        center, vec1, vec2, ellipse)
    ellipse
end

"""
    ckcov(ck, idcode, needav, level, tol, timsys)

Find the coverage window for a specified object in a specified CK file.

### Arguments ###

- `ck`: Name of CK file
- `idcode`: ID code of object
- `needav`: Flag indicating whether angular velocity is needed
- `level`: Coverage level:  "SEGMENT" OR "INTERVAL"
- `tol`: Tolerance in ticks
- `timsys`: Time system used to represent coverage

### Output ###

Window giving coverage for `idcode`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckcov_c.html)
"""
function ckcov(ck, idcode, needav, level, tol, timsys)
    cover = SpiceDoubleCell(20000)
    ckcov!(ck, idcode, needav, level, tol, timsys, cover)
end

"""
    ckcov!(ck, idcode, needav, level, tol, timsys, cover)

Find the coverage window for a specified object in a specified CK file.

### Arguments ###

- `ck`: Name of CK file
- `idcode`: ID code of object
- `needav`: Flag indicating whether angular velocity is needed
- `level`: Coverage level:  "SEGMENT" OR "INTERVAL"
- `tol`: Tolerance in ticks
- `timsys`: Time system used to represent coverage
- `cover`: Window giving coverage for `idcode`. Data already present in `cover`
    will be combined with coverage found for the object designated by `idcode`
    in the file `ck`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckcov_c.html)
"""
function ckcov!(ck, idcode, needav, level, tol, timsys, cover)
    ccall((:ckcov_c, libcspice), Cvoid,
        (Cstring, SpiceInt, SpiceBoolean, Cstring, SpiceDouble, Cstring,
            Ref{Cell{SpiceDouble}}),
        ck, idcode, needav, level, tol, timsys, cover.cell)
    handleerror()
    cover
end

"""
    ckgp(inst, sclkdp, tol, ref)

Get pointing (attitude) for a specified spacecraft clock time.

### Arguments ###

- `inst`: NAIF ID of instrument, spacecraft, or structure
- `sclkdp`: Encoded spacecraft clock time
- `tol`: Time tolerance
- `ref`: Reference frame

### Outputs ###

- `cmat`: C-matrix pointing data
- `clkout`: Output encoded spacecraft clock time
- `found`: `true` when requested pointing is available

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckgp_c.html)
"""
function ckgp(inst, sclkdp, tol, ref)
    cmat = Matrix{SpiceDouble}(undef, 3, 3)
    clkout = Ref{SpiceDouble}(0.0)
    found = Ref{SpiceBoolean}(0)
    ccall((:ckgp_c, libcspice), Cvoid,
        (SpiceInt, SpiceDouble, SpiceDouble, Cstring,
        Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
        inst, sclkdp, tol, ref, cmat, clkout, found)
    handleerror()
    # TODO: Revisit this API in Julia 1.0 and use `nothing`
    cmat', clkout[], found[] == 1
end

"""
    ckgpav(inst, sclkdp, tol, ref)

Get pointing (attitude) and angular velocity for a specified spacecraft clock time.

### Arguments ###

- `inst`: NAIF ID of instrument, spacecraft, or structure
- `sclkdp`: Encoded spacecraft clock time
- `tol`: Time tolerance
- `ref`: Reference frame

### Outputs ###

- `cmat`: C-matrix pointing data
- `av`: Angular velocity vector
- `clkout`: Output encoded spacecraft clock time
- `found`: `true` when requested pointing is available

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckgpav_c.html)
"""
function ckgpav(inst, sclkdp, tol, ref)
    cmat = Matrix{SpiceDouble}(undef, 3, 3)
    av = Vector{SpiceDouble}(undef, 3)
    clkout = Ref{SpiceDouble}(0.0)
    found = Ref{SpiceBoolean}(0)
    ccall((:ckgpav_c, libcspice), Cvoid,
        (SpiceInt, SpiceDouble, SpiceDouble, Cstring,
        Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
        inst, sclkdp, tol, ref, cmat, av, clkout, found)
    handleerror()
    # TODO: Revisit this API in Julia 1.0 and use `nothing`
    cmat', av, clkout[], found[] == 1
end

"""
    cklpf(filename)

Load a CK pointing file for use by the CK readers.  Return that file's handle, to be used by other CK
routines to refer to the file.

### Arguments ###

- `filename`: Name of the CK file to be loaded

### Output ###

Loaded file's handle

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cklpf_c.html)
"""
function cklpf(filename)
    handle = Ref{SpiceInt}()
    ccall((:cklpf_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), filename, handle)
    handleerror()
    handle[]
end

"""
    ckobj(ck)

Find the set of ID codes of all objects in a specified CK file.

### Arguments ##

- `ck`: Name of CK file

### Output ###

Set of ID codes of objects in CK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckobj_c.html)
"""
function ckobj(ck)
    ids = SpiceIntCell(1000)
    ckobj!(ck, ids)
end

"""
    ckobj!(ck, ids)

Find the set of ID codes of all objects in a specified CK file.

### Arguments ##

- `ck`: Name of CK file
- `ids`: Set of ID codes of objects in CK file. Data already present in
    `ids` will be combined with ID code set found for the file `ck`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckobj_c.html)
"""
function ckobj!(ck, ids)
    ccall((:ckobj_c, libcspice), Cvoid, (Cstring, Ref{Cell{SpiceInt}}),
        ck, ids.cell)
    handleerror()
    ids
end

"""
    cidfrm(cent)

Retrieve frame ID code and name to associate with a frame center.

### Arguments ###

- `cent`: ID code for an object for which there is a preferred reference frame

### Output ###

Returns the tuple `(frcode, frname)`

- `frcode`: The ID code of the frame associated with `cent`
- `frname`: The name of the frame with ID `frcode`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cidfrm_c.html)
"""
function cidfrm(cent)
    lenout = 33
    frcode = Ref{SpiceInt}()
    frname = Array{UInt8}(undef, lenout)
    found = Ref{SpiceBoolean}()
    ccall((:cidfrm_c, libcspice), Cvoid, (SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{UInt8}, Ref{SpiceBoolean}),
          cent, lenout, frcode, frname, found)
    found[] == 0 && throw(SpiceError("No frame associated with body $cent found."))
    frcode[], chararray_to_string(frname)
end

"""
    ckopn(fname, ifname="CK_file", ncomch=0)

Open a new CK file, returning the handle of the opened file.

### Arguments ###

- `fname`: The name of the CK file to be opened
- `ifname="CK_file"`: The internal filename for the CK, default is "CK_file"
- `ncomch=0`: The number of characters to reserve for comments, default is zero

### Output ###

- `handle`: The handle of the opened CK file

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckopn_c.html)
"""
function ckopn(fname, ifname="CK_file", ncomch=0)
    handle = Ref{SpiceInt}()
    ccall((:ckopn_c, libcspice), Cvoid, (Cstring, Cstring, SpiceInt, Ref{SpiceInt}),
          fname, ifname, ncomch, handle)
    handleerror()
    handle[]
end

"""
    ckcls(handle)

Close an open CK file.

### Arguments ###

- `handle`: Handle of the CK file to be closed

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckcls_c.html)
"""
function ckcls(handle)
    ccall((:ckcls_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    ckupf(handle)

Unload a CK pointing file so that it will no longer be searched by the readers.

### Arguments ###

- `handle`: Handle of CK file to be unloaded

### References ###
- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckupf_c.html)
"""
function ckupf(handle)
    ccall((:ckupf_c, libcspice), Cvoid, (SpiceInt,), handle)
end

"""
    ckw01(handle, inst, ref, segid, sclkdp, quats, avvs=Matrix{SpiceDouble}(0,0);
        begtim=sclkdp[1], endtim=sclkdp[end])

Add a type 1 segment to a C-kernel.

### Arguments ###

- `handle`: Handle of an open CK file
- `inst`: The NAIF instrument ID code
- `ref`: The reference frame of the segment
- `segid`: Segment identifier
- `sclkdp`: Encoded SCLK times
- `quats`: Quaternions representing instrument pointing
- `avvs`: Angular velocity vectors (optional)
- `begtim`: The beginning encoded SCLK of the segment (optional)
- `endtim`: The ending encoded SCLK of the segment (optional)

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckw01_c.html)
"""
function ckw01(handle, inst, ref, segid, sclkdp, quats, avvs=Matrix{SpiceDouble}(0,0);
               begtim=sclkdp[1], endtim=sclkdp[end])
    nrec = length(sclkdp)
    avflag = length(avvs) > 0 ? 1 : 0
    ccall((:ckw01_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble, SpiceDouble, SpiceInt, Cstring, SpiceInt, Cstring, SpiceInt,
           Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          handle, begtim, endtim, inst, ref, avflag, segid, nrec, sclkdp, quats, avvs)
    handleerror()
end

"""
    clight()

Returns the speed of light in vacuo (km/sec).
"""
function clight()
    ccall((:clight_c, libcspice), Cdouble, ())
end

"""
    clpool()

Remove all variables from the kernel pool. Watches on kernel variables are retained.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/clpool_c.html)
"""
function clpool()
    ccall((:clpool_c, libcspice), Cvoid, ())
end

"""
    cmprss(delim, n, input)

Compress a character string by removing occurrences of more than `n` consecutive occurrences
of a specified character.

### Arguments ###

- `delim`: Delimiter to be compressed
- `n`: Maximum consecutive occurrences of delim
- `input`: Input string

### Output ###

Returns the compressed string.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cmprss_c.html)
"""
function cmprss(delim, n, input)
    lenout = length(input)
    output = Array{UInt8}(undef, lenout)
    ccall((:cmprss_c, libcspice), Cvoid,
          (Cchar, SpiceInt, Cstring, SpiceInt, Ptr{UInt8}),
          first(delim), n, input, lenout, output)
    handleerror()
    chararray_to_string(output)
end

"""
    cnmfrm(cname)

Retrieve frame ID code and name to associate with an object.

### Arguments ###
- `cname`: Name of the object to find a frame for

### Output ###

Returns a tuple of the ID code and the name of the frame associated with `cname` or `nothing` if no
frame is found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cnmfrm_c.html)

"""
function cnmfrm(cname, lenout=LENOUT)
    frcode = Ref{SpiceInt}()
    frname = Array{UInt8}(undef, lenout)
    found = Ref{SpiceBoolean}()
    ccall((:cnmfrm_c, libcspice), Cvoid, (Cstring, SpiceInt, Ref{SpiceInt}, Ptr{UInt8}, Ref{SpiceBoolean}),
          cname, lenout, frcode, frname, found)
    if Bool(found[])
        code = frcode[]
        name = chararray_to_string(frname)
        return code, name
    end
    nothing
end

"""
    conics(elts, et)

Determine the state (position, velocity) of an orbiting body from a set of elliptic, hyperbolic,
or parabolic orbital elements.

### Arguments ###

- `elts`: Conic elements
- `et`: Input time

### Output ###

Returns the state of orbiting body at `et`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/conics_c.html)
"""
function conics(elts, et)
    state = Array{Float64}(undef, 6)
    ccall((:conics_c, libcspice), Cvoid, (Ptr{SpiceDouble}, SpiceDouble, Ptr{SpiceDouble}), elts, et, state)
    handleerror()
    state
end

"""
    convrt(x, in, out)

Take a measurement `x`, the units associated with `x`, and units to which `x` should be converted;
return `y` - the value of the measurement in the output units.

### Arguments ###

- `x`: Number representing a measurement in some units
- `in`: The units in which x is measured
- `out`: Desired units for the measurement

### Output ###

Returns the measurement in the desired units.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/convrt_c.html)
"""
function convrt(x, in, out)
    y = Ref{SpiceDouble}()
    ccall((:convrt_c, libcspice), Cvoid, (SpiceDouble, Cstring, Cstring, Ref{SpiceDouble}),
          x, in, out, y)
    handleerror()
    y[]
end


"""
    cpos(str, chars, start)

Find the first occurrence in a string of a character belonging to a collection of characters,
starting at a specified location, searching forward.

### Arguments ###

- `str`: Any character string
- `chars`: A collection of characters
- `start`: Position to begin looking for one of chars

### Output ###

Returns the index of the first character of `str` that is one of the characters in string
`chars`. Returns -1 if none of the characters was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cpos_c.html)
"""
function cpos(str, chars, start)
    idx = ccall((:cpos_c, libcspice), SpiceInt, (Cstring, Cstring, SpiceInt), str, chars, start - 1)
    handleerror()
    idx != -1 ? idx + 1 : idx
end

"""
    cposr(str, chars, start)

Find the first occurrence in a string of a character belonging to a collection of characters,
starting at a specified location, searching in reverse.

### Arguments ###

- `str`: Any character string
- `chars`: A collection of characters
- `start`: Position to begin looking for one of chars

### Output ###

Returns the index of the last character of `str` that is one of the characters in string
`chars`. Returns -1 if none of the characters was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cposr_c.html)
"""
function cposr(str, chars, start)
    idx = ccall((:cposr_c, libcspice), SpiceInt, (Cstring, Cstring, SpiceInt), str, chars, start - 1)
    handleerror()
    idx != -1 ? idx + 1 : idx
end

"""
    cvpool(agent)

Indicate whether or not any watched kernel variables that have a specified agent on their
notification list have been updated.

### Arguments ###

- `agent`: Name of the agent to check for notices

### Output ###

`true` if variables for `agent` have been updated.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cvpool_c.html)
"""
function cvpool(agent)
    update = Ref{SpiceBoolean}()
    ccall((:cvpool_c, libcspice), Cvoid, (Cstring, Ref{SpiceBoolean}), agent, update)
    update[] == 1
end

"""
    cyllat(r, lonc, z)

Convert from cylindrical to latitudinal coordinates.

### Arguments ###

- `r`: Distance of point from z axis
- `lonc`: Cylindrical angle of point from XZ plane (radians)
- `z`: Height of point above XY plane

### Output ###

Returns a tuple of radius, longitude (radians), and latitude (radians).

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cyllat_c.html)
"""
function cyllat(r, lonc, z)
    radius = Ref{SpiceDouble}()
    lon = Ref{SpiceDouble}()
    lat = Ref{SpiceDouble}()
    ccall((:cyllat_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          r, lonc, z, radius, lon, lat)
    radius[], lon[], lat[]
end

"""
    cylrec(r, lon, z)

Convert from cylindrical to rectangular coordinates.

### Arguments ###

- `r`: Distance of the point of interest from z axis
- `lon`: Cylindrical angle (in radians) of the point of interest from XZ plane
- `z`: Height of the point above XY plane

### Output ###

Returns rectangular coordinates of the point of interest.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cylrec_c.html)
"""
function cylrec(r, lon, z)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:cylrec_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble, Ptr{SpiceDouble}),
          r, lon, z, rectan)
    rectan
end

"""
    cylsph(r, lonc, z)

Convert from cylindrical to spherical coordinates.

### Arguments ###

- `r`: Distance of point from z axis
- `lonc`: Angle (radians) of point from XZ plane
- `z`: Height of point above XY plane

### Output ###

Returns a tuple of distance of the point from the origin, polar angle (co-latitude in radians),
and azimuthal angle (longitude).

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cylsph_c.html)
"""
function cylsph(r, lonc, z)
    radius = Ref{SpiceDouble}()
    colat = Ref{SpiceDouble}()
    lon = Ref{SpiceDouble}()
    ccall((:cylsph_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          r, lonc, z, radius, colat, lon)
    radius[], colat[], lon[]
end

