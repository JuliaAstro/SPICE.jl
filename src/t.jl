export
    term_pl02,
    termpt,
    timdef,
    timout,
    tipbod,
    tisbod,
    tkvrsn,
    tparse,
    tpictr,
    trace,
    tsetyr,
    twopi,
    twovec,
    tyear

"""

Find terminator points on a target body. The caller specifies
half-planes, bounded by the illumination source center-target center
vector, in which to search for terminator points.

The terminator can be either umbral or penumbral. The umbral
terminator is the boundary of the region on the target surface
where no light from the source is visible. The penumbral
terminator is the boundary of the region on the target surface
where none of the light from the source is blocked by the target
itself.

The surface of the target body may be represented either by a
triaxial ellipsoid or by topographic data.

### Arguments ###

- `method`: Computation method
- `ilusrc`: Illumination source
- `target`: Name of target body
- `et    `: Epoch in ephemeris seconds past J2000 TDB
- `fixref`: Body-fixed, body-centered target body frame
- `abcorr`: Aberration correction
- `corloc`: Aberration correction locus
- `obsrvr`: Name of observing body
- `refvec`: Reference vector for cutting half-planes
- `rolstp`: Roll angular step for cutting half-planes
- `ncuts `: Number of cutting planes
- `schstp`: Angular step size for searching
- `soltol`: Solution convergence tolerance
- `maxn  `: Maximum number of entries in output arrays

### Output ###

- `npts  `: Counts of terminator points corresponding to cuts
- `points`: Terminator points
- `epochs`: Times associated with terminator points
- `trmvcs`: Terminator vectors emanating from the observer

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/termpt_c.html)
"""
function termpt(method, ilusrc, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp,
                ncuts, schstp, soltol, maxn)
    @checkdims 3 refvec
    npts = zeros(SpiceInt, maxn)
    points = Array{SpiceDouble}(undef, 3, maxn)
    epochs = Array{SpiceDouble}(undef, maxn)
    trmvcs = Array{SpiceDouble}(undef, 3, maxn)

    ccall((:termpt_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Cstring,
           Ref{SpiceDouble}, SpiceDouble, SpiceInt, SpiceDouble, SpiceDouble, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          method, ilusrc, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp,
          ncuts, schstp, soltol, maxn, npts, points, epochs, trmvcs)
    handleerror()
    valid_points = npts .>= 1
    npts[valid_points], cmatrix_to_array(points)[valid_points],
        epochs, cmatrix_to_array(trmvcs)[valid_points]
end

@deprecate term_pl02 termpt

"""
    timdef(action, item, value="")

Set and retrieve the defaults associated with calendar input strings.

### Arguments ###

- `action`: The kind of action to take, either `:SET` or `:GET`
- `item`: The default item of interest. The items that may be requested are:
    - `:CALENDAR` with allowed values:
        - `"GREGORIAN"`
        - `"JULIAN"`
        - `"MIXED"`
    - `:SYSTEM` with allowed values:
        - `"TDB"`
        - `"TDT"`
        - `"UTC"`
    - `:ZONE` with allowed values (`0 <= HR < 13` and `0 <= MN < 60`):
        - `"EST"`
        - `"EDT"`
        - `"CST"`
        - `"CDT"`
        - `"MST"`
        - `"MDT"`
        - `"PST"`
        - `"PDT"`
        - `"UTC+\$HR"`
        - `"UTC-\$HR"`
        - `"UTC+\$HR:\$MN"`
        - `"UTC-\$HR:\$MN"`

### Output ###

Returns the value associated with the default item.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/timdef_c.html)
"""
function timdef(action, item, value="")
    lenout = 10
    val = fill(SpiceChar(0), lenout)
    val[1:length(value)] .= collect(value)
    ccall((:timdef_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceInt, Ref{SpiceChar}),
          string(action), string(item), lenout, val)
    handleerror()
    chararray_to_string(val)
end

"""
    timout(et, pictur, lenout=128)

This routine converts an input epoch represented in TDB seconds past the TDB
epoch of J2000 to a character string formatted to the specifications of a
user's format picture.

### Arguments ###

- `et`: An epoch in seconds past the ephemeris epoch J2000
- `pictur`: A format specification for the output string
- `lenout`: The length of the output string plus 1 (default: 128)

### Output ###

Returns a string representation of the input epoch.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/timout_c.html)
"""
function timout(et, pictur, lenout=128)
    string = Array{SpiceChar}(undef, lenout)
    ccall((:timout_c, libcspice), Cvoid,
          (Cdouble, Cstring, SpiceInt, Ref{SpiceChar}),
          et, pictur, lenout, string)
    handleerror()
    chararray_to_string(string)
end

"""
    tipbod(ref, body, et)

Return a 3x3 matrix that transforms positions in inertial coordinates to
positions in body-equator-and-prime-meridian coordinates.

### Arguments ###

- `ref`: Name of inertial reference frame to transform from
- `body`: ID code of body
- `et`: Epoch of transformation

### Output ###

Returns transformation matrix from intertial position to prime meridian.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/tipbod_c.html)
"""
function tipbod(ref, body, et)
    tipm = Array{SpiceDouble}(undef, 3, 3)
    ccall((:tipbod_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceDouble, Ref{SpiceDouble}),
          ref, body, et, tipm)
    handleerror()
    permutedims(tipm)
end

"""
    tisbod(ref, body, et)

Return a 6x6 matrix that transforms states in inertial coordinates to
states in body-equator-and-prime-meridian coordinates.

### Arguments ###

- `ref`: Name of inertial reference frame to transform from
- `body`: ID code of body
- `et`: Epoch of transformation

### Output ###

Returns transformation matrix from intertial state to prime meridian.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/tisbod_c.html)
"""
function tisbod(ref, body, et)
    tsipm = Array{SpiceDouble}(undef, 6, 6)
    ccall((:tisbod_c, libcspice), Cvoid, (Cstring, SpiceInt, SpiceDouble, Ref{SpiceDouble}),
        ref, body, et, tsipm)
    handleerror()
    permutedims(tsipm)
end

"""
    tkvrsn(item=:TOOLKIT)

Given an item such as the Toolkit or an entry point name, return the latest
version string.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/tkvrsn_c.html)
"""
function tkvrsn(item=:TOOLKIT)
    out = ccall((:tkvrsn_c, libcspice), Cstring, (Cstring,), string(item))
    GC.@preserve out unsafe_string(pointer(out))
end

"""
    tparse(string)

Parse a time string and return seconds past the J2000 epoch on a formal calendar.

### Arguments ###

- `string`: Input time string in UTC

### Output ###

Returns UTC expressed in seconds since J2000.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/tparse_c.html)
"""
function tparse(string)
    lenout = 128
    sp2000 = Ref{SpiceDouble}()
    errmsg = Array{SpiceChar}(undef, lenout)
    ccall((:tparse_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceDouble}, Ref{SpiceChar}),
          string, lenout, sp2000, errmsg)
    msg = chararray_to_string(errmsg)
    if !isempty(msg)
        throw(SpiceError(msg))
    end
    sp2000[]
end

"""
    tpictr(sample, lenout=80)

Given a sample time string, create a time format picture suitable for use by
the routine [`timout`](@ref).

### Arguments ###

- `sample`: A sample time string
- `lenout`: The length for the output picture string (default: 80)

### Output ###

Returns a format picture that describes sample.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/tpictr_c.html)
"""
function tpictr(sample, lenout=80)
    lenerr = 128
    pictur = Array{SpiceChar}(undef, lenout)
    ok = Ref{SpiceBoolean}()
    errmsg = Array{SpiceChar}(undef, lenerr)
    ccall((:tpictr_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}, Ref{SpiceBoolean}, Ref{SpiceChar}),
          sample, lenout, lenerr, pictur, ok, errmsg)
    if !Bool(ok[])
        throw(SpiceError(chararray_to_string(errmsg)))
    end
    chararray_to_string(pictur)
end

function _trace(matrix)
    ccall((:trace_c, libcspice), SpiceDouble, (Ref{SpiceDouble},), matrix)
end

"""
    trace(matrix)

!!! warning "Deprecated"
    Use `LinearAlgebra.tr(matrix)` instead.
"""
trace

@deprecate trace LinearAlgebra.tr

"""
    tsetyr(year)

Set the lower bound on the 100 year range.

### Arguments ###

-`year`: Lower bound on the 100 year interval of expansion

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/tsetyr_c.html)
"""
function tsetyr(year)
    ccall((:tsetyr_c, libcspice), Cvoid, (SpiceInt,), year)
end

function _twopi()
    ccall((:twopi_c, libcspice), SpiceDouble, ())
end

"""
    twopi()

!!! warning "Deprecated"
    Use `2π` instead.
"""
twopi

@deprecate twopi() 2π

"""
    twovec(axdef, indexa, plndef, indexp)

Find the transformation to the right-handed frame having a given vector as a
specified axis and having a second given vector lying in a specified coordinate
plane.

### Arguments ###

- `axdef`: Vector defining a principal axis
- `indexa`: Principal axis number of axdef (X=1, Y=2, Z=3)
- `plndef`: Vector defining (with axdef) a principal plane
- `indexp`: Second axis number (with indexa) of principal plane

### Output ###

Returns output rotation matrix.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/twovec_c.html)
"""
function twovec(axdef, indexa, plndef, indexp)
    @checkdims 3 axdef plndef
    mout = Array{SpiceDouble}(undef, 3, 3)
    ccall((:twovec_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}),
          axdef, indexa, plndef, indexp, mout)
    handleerror()
    permutedims(mout)
end

"""
    tyear()

Returns the number of seconds per tropical year.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/tyear_c.html)
"""
function tyear()
    ccall((:tyear_c, libcspice), SpiceDouble, ())
end

