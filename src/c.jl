export
    ccifrm,
    cgv2el,
    chbder,
    cidfrm,
    ckcls,
    ckcov!,
    ckcov,
    ckgp,
    ckgpav,
    cklpf,
    ckobj!,
    ckobj,
    ckopn,
    ckupf,
    ckw01,
    ckw02,
    ckw03,
    ckw05,
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

Returns `nothing` if no frame was found or

- `frcode`: ID code of the frame
- `frname`: Name of the frame
- `center`: ID code of the center of the frame

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ccifrm_c.html)
"""
function ccifrm(frclss, clssid)
    lenout = 33
    frcode = Ref{SpiceInt}()
    frname = Array{SpiceChar}(undef, lenout)
    center = Ref{SpiceInt}()
    found = Ref{SpiceBoolean}()
    ccall((:ccifrm_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar},
           Ref{SpiceInt}, Ref{SpiceBoolean}),
          frclss, clssid, lenout, frcode, frname, center, found)
    handleerror()
    Bool(found[]) || return nothing
    Int(frcode[]), chararray_to_string(frname), Int(center[])
end

"""
    cgv2el(center, vec1, vec2)

Form an ellipse from a center vector and two generating vectors.

### Arguments ###

- `center`: Center vector
- `vec1`: Generating vector
- `vec2`: Generating vector

### Output ###

Returns the ellipse defined by the input vectors.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cgv2el_c.html)
"""
function cgv2el(center, vec1, vec2)
    @checkdims 3 center vec1 vec2
    ellipse = Ref{Ellipse}()
    ccall((:cgv2el_c, libcspice), Cvoid,
        (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{Ellipse}),
        center, vec1, vec2, ellipse)
    ellipse[]
end

"""
    chbder(cp, x2s, x, nderiv)

Given the coefficients for the Chebyshev expansion of a polynomial, this returns the value of the
polynomial and its first `nderiv` derivatives evaluated at the input `x`.

### Arguments ###

- `cp`: Chebyshev polynomial coefficients
- `x2s`: Transformation parameters of polynomial
- `x`: Value for which the polynomial is to be evaluated
- `nderiv`: The number of derivatives to compute

### Output ###

Returns the derivatives of the polynomial.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/chbder_c.html)
"""
function chbder(cp, x2s, x, nderiv)
    @checkdims 2 x2s
    degp = length(cp) - 1
    partdp = Array{SpiceDouble}(undef, 3 * (nderiv + 1))
    dpdxs = Array{SpiceDouble}(undef, nderiv + 1)
    ccall((:chbder_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}, SpiceDouble, SpiceInt,
           Ref{SpiceDouble}, Ref{SpiceDouble}),
          cp, degp, x2s, x, nderiv, partdp, dpdxs)
    dpdxs
end

"""
    cidfrm(cent)

Retrieve frame ID code and name to associate with a frame center.

### Arguments ###

- `cent`: ID code for an object for which there is a preferred reference frame

### Output ###

Returns `nothing` if no frame was found or

- `frcode`: The ID code of the frame associated with `cent`
- `frname`: The name of the frame with ID `frcode`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cidfrm_c.html)
"""
function cidfrm(cent)
    lenout = 33
    frcode = Ref{SpiceInt}()
    frname = Array{SpiceChar}(undef, lenout)
    found = Ref{SpiceBoolean}()
    ccall((:cidfrm_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
          cent, lenout, frcode, frname, found)
    Bool(found[]) || return nothing
    Int(frcode[]), chararray_to_string(frname)
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

Returns `nothing` if the requested pointing is not available or

- `cmat`: C-matrix pointing data
- `clkout`: Output encoded spacecraft clock time

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckgp_c.html)
"""
function ckgp(inst, sclkdp, tol, ref)
    cmat = Array{SpiceDouble}(undef, 3, 3)
    clkout = Ref{SpiceDouble}()
    found = Ref{SpiceBoolean}()
    ccall((:ckgp_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble, SpiceDouble, Cstring,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          inst, sclkdp, tol, ref, cmat, clkout, found)
    handleerror()
    Bool(found[]) || return nothing
    permutedims(cmat), clkout[]
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

Returns `nothing` if the requested pointing is not available or

- `cmat`: C-matrix pointing data
- `av`: Angular velocity vector
- `clkout`: Output encoded spacecraft clock time

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckgpav_c.html)
"""
function ckgpav(inst, sclkdp, tol, ref)
    cmat = Array{SpiceDouble}(undef, 3, 3)
    av = Array{SpiceDouble}(undef, 3)
    clkout = Ref{SpiceDouble}()
    found = Ref{SpiceBoolean}()
    ccall((:ckgpav_c, libcspice), Cvoid,
        (SpiceInt, SpiceDouble, SpiceDouble, Cstring,
        Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
        inst, sclkdp, tol, ref, cmat, av, clkout, found)
    handleerror()
    Bool(found[]) || return nothing
    permutedims(cmat), av, clkout[]
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
    ccall((:ckobj_c, libcspice), Cvoid,
          (Cstring, Ref{Cell{SpiceInt}}),
          ck, ids.cell)
    handleerror()
    ids
end

"""
    ckopn(fname, ifname="CK_file", ncomch=0)

Open a new CK file, returning the handle of the opened file.

### Arguments ###

- `fname`: The name of the CK file to be opened
- `ifname`: The internal filename for the CK (default: "CK_file")
- `ncomch`: The number of characters to reserve for comments (default: 0)

### Output ###

- `handle`: The handle of the opened CK file

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckopn_c.html)
"""
function ckopn(fname, ifname="CK_file", ncomch=0)
    handle = Ref{SpiceInt}()
    ccall((:ckopn_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceInt, Ref{SpiceInt}),
          fname, ifname, ncomch, handle)
    handleerror()
    handle[]
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
    ckw01(handle, begtim, endtim, inst, ref, segid, sclkdp, quats, avvs=[zeros(3)])

Add a type 1 segment to a C-kernel.

### Arguments ###

- `handle`: Handle of an open CK file
- `begtim`: The beginning encoded SCLK of the segment
- `endtim`: The ending encoded SCLK of the segment
- `inst`: The NAIF instrument ID code
- `ref`: The reference frame of the segment
- `segid`: Segment identifier
- `sclkdp`: Encoded SCLK times
- `quats`: Quaternions representing instrument pointing
- `avvs`: Angular velocity vectors (optional)

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckw01_c.html)
"""
function ckw01(handle, begtim, endtim, inst, ref, segid, sclkdp, quats, avvs=[zeros(3)])
    quats_ = array_to_cmatrix(quats, n=4)
    avvs_ = array_to_cmatrix(avvs, n=3)
    nrec = length(sclkdp)
    avflag = length(avvs) == length(quats)
    ccall((:ckw01_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble, SpiceDouble, SpiceInt, Cstring, SpiceInt, Cstring, SpiceInt,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          handle, begtim, endtim, inst, ref, avflag, segid, nrec, sclkdp, quats_, avvs_)
    handleerror()
end

"""
    ckw02(handle, begtim, endtim, inst, ref, segid, start, stop, quats, avvs, rates)

Write a type 2 segment to a C-kernel.

### Arguments ###

- `handle`: Handle of an open CK file
- `begtim`: The beginning encoded SCLK of the segment
- `endtim`: The ending encoded SCLK of the segment
- `inst`: The NAIF instrument ID code
- `ref`: The reference frame of the segment
- `segid`: Segment identifier
- `start`: Encoded SCLK interval start times
- `stop`: Encoded SCLK interval stop times
- `quats`: Quaternions representing instrument pointing
- `avvs`: Angular velocity vectors
- `rates`: Number of seconds per tick for each interval

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckw02_c.html)
"""
function ckw02(handle, begtim, endtim, inst, ref, segid, start, stop, quats, avvs, rates)
    nrec = length(quats)
    @checkdims nrec start stop avvs rates
    quats_ = array_to_cmatrix(quats, n=4)
    avvs_ = array_to_cmatrix(avvs, n=3)
    ccall((:ckw02_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble, SpiceDouble, SpiceInt, Cstring, Cstring, SpiceInt, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          handle, begtim, endtim, inst, ref, segid, nrec - 1, start, stop, quats_, avvs_, rates)
    handleerror()
end

"""
    ckw03(handle, begtim, endtim, inst, ref, segid, sclkdp, quats, starts, avvs=[zeros(3)])

Add a type 3 segment to a C-kernel.

### Arguments ###

- `handle`: Handle of an open CK file
- `begtim`: The beginning encoded SCLK of the segment
- `endtim`: The ending encoded SCLK of the segment
- `inst`: The NAIF instrument ID code
- `ref`: The reference frame of the segment
- `segid`: Segment identifier
- `sclkdp`: Encoded SCLK times
- `quats`: Quaternions representing instrument pointing
- `starts`: Encoded SCLK interval start times
- `avvs`: Angular velocity vectors (optional)

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckw03_c.html)
"""
function ckw03(handle, begtim, endtim, inst, ref, segid, sclkdp, quats, starts, avvs=[zeros(3)])
    nrec = length(quats)
    avflag = length(avvs) == nrec
    nints = length(starts)
    quats_ = array_to_cmatrix(quats, n=4)
    avvs_ = array_to_cmatrix(avvs, n=3)
    @checkdims nrec sclkdp
    ccall((:ckw03_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble, SpiceDouble, SpiceInt, Cstring, SpiceBoolean, Cstring,
           SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceInt,
           Ref{SpiceDouble}),
          handle, begtim, endtim, inst, ref, avflag, segid, nrec - 1,
          sclkdp, quats_, avvs_, nints, starts)
    handleerror()
end

"""
    ckw05(handle, subtyp, degree, begtim, endtim, inst, ref, avflag, segid, sclkdp, packts,
          rate, nints, starts)

Write a type 5 segment to a CK file.

### Arguments ###

- `handle`: Handle of an open CK file
- `subtyp`: CK type 5 subtype code
- `degree`: Degree of interpolating polynomials
- `begtim`: The beginning encoded SCLK of the segment
- `endtim`: The ending encoded SCLK of the segment
- `inst`: The NAIF instrument ID code
- `ref`: The reference frame of the segment
- `avflag`: True if the segment will contain angular velocity
- `segid`: Segment identifier
- `sclkdp`: Encoded SCLK times
- `packts`: Array of packets
- `rate`: Nominal SCLK rate in seconds per tick
- `nints`: Number of intervals
- `starts`: Encoded SCLK interval start times

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ckw05_c.html)
"""
function ckw05(handle, subtyp, degree, begtim, endtim, inst, ref, avflag, segid, sclkdp, packts,
               rate, nints, starts)
    n = length(packts)
    @checkdims n sclkdp
    if subtyp == 0
        packts_ = array_to_cmatrix(packts, n=8)
    elseif subtyp == 1
        packts_ = array_to_cmatrix(packts, n=4)
    elseif subtyp == 2
        packts_ = array_to_cmatrix(packts, n=14)
    elseif subtyp == 3
        packts_ = array_to_cmatrix(packts, n=7)
    end
    ccall((:ckw05_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, SpiceDouble, SpiceDouble, SpiceInt, Cstring, SpiceBoolean,
           Cstring, SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble},
           SpiceDouble, SpiceInt, Ref{SpiceDouble}),
          handle, subtyp, degree, begtim, endtim, inst, ref, avflag, segid, n, sclkdp, packts_, rate,
          nints, starts)
    handleerror()
end

@deprecate cleard empty!

"""
    cleard(array)

!!! warning "Deprecated"
    Use `empty!(array)` instead.
"""
cleard

"""
    clight()

Returns the speed of light in vacuo (km/sec).

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/clight_c.html)
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
    output = Array{SpiceChar}(undef, lenout)
    ccall((:cmprss_c, libcspice), Cvoid,
          (Cchar, SpiceInt, Cstring, SpiceInt, Ref{SpiceChar}),
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
function cnmfrm(cname, lenout=256)
    frcode = Ref{SpiceInt}()
    frname = Array{SpiceChar}(undef, lenout)
    found = Ref{SpiceBoolean}()
    ccall((:cnmfrm_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
          cname, lenout, frcode, frname, found)
    Bool(found[]) || return nothing
    frcode[], chararray_to_string(frname)
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
    @checkdims 8 elts
    state = Array{Float64}(undef, 6)
    ccall((:conics_c, libcspice), Cvoid, (Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}), elts, et, state)
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
    idx = Int(ccall((:cpos_c, libcspice), SpiceInt,
                    (Cstring, Cstring, SpiceInt),
                    str, chars, start - 1))
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
    idx = Int(ccall((:cposr_c, libcspice), SpiceInt,
                    (Cstring, Cstring, SpiceInt),
                    str, chars, start - 1))
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

Returns `true` if variables for `agent` have been updated.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/cvpool_c.html)
"""
function cvpool(agent)
    update = Ref{SpiceBoolean}()
    ccall((:cvpool_c, libcspice), Cvoid, (Cstring, Ref{SpiceBoolean}), agent, update)
    Bool(update[])
end

"""
    cyllat(r, lonc, z)

Convert from cylindrical to latitudinal coordinates.

### Arguments ###

- `r`: Distance of point from z axis
- `lonc`: Cylindrical angle of point from XZ plane (radians)
- `z`: Height of point above XY plane

### Output ###

- `radius`: Radius
- `lon`: Longitude (radians)
- `lat`: Latitude (radians)

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
    ccall((:cylrec_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
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

- `radius`: Distance of the point from the origin
- `colat`: Polar angle (co-latitude in radians)
- `lon`: Azimuthal angle (longitude)

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

