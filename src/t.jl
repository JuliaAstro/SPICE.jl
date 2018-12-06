export
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
    val = fill(UInt8(0), lenout)
    val[1:length(value)] .= collect(value)
    ccall((:timdef_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceInt, Ptr{UInt8}),
          string(action), string(item), lenout, val)
    handleerror()
    unsafe_string(pointer(val))
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
    string = Array{UInt8}(undef, lenout)
    ccall((:timout_c, libcspice), Cvoid,
          (Cdouble, Cstring, Cint, Ptr{UInt8}),
          et, pictur, lenout, string)
    handleerror()
    unsafe_string(pointer(string))
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
          (Cstring, SpiceInt, SpiceDouble, Ptr{SpiceDouble}),
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
    ccall((:tisbod_c, libcspice), Cvoid, (Cstring, SpiceInt, SpiceDouble, Ptr{SpiceDouble}),
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
    unsafe_string(pointer(out))
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
    errmsg = Array{UInt8}(undef, lenout)
    ccall((:tparse_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceDouble}, Ptr{UInt8}),
          string, lenout, sp2000, errmsg)
    msg = unsafe_string(pointer(errmsg))
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
    pictur = Array{UInt8}(undef, lenout)
    ok = Ref{SpiceBoolean}()
    errmsg = Array{UInt8}(undef, lenerr)
    ccall((:tpictr_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ptr{UInt8}, Ref{SpiceBoolean}, Ptr{UInt8}),
          sample, lenout, lenerr, pictur, ok, errmsg)
    if !Bool(ok[])
        msg = unsafe_string(pointer(errmsg))
        throw(SpiceError(msg))
    end
    unsafe_string(pointer(pictur))
end

function _trace(matrix)
    ccall((:trace_c, libcspice), SpiceDouble, (Ptr{SpiceDouble},), matrix)
end

"""
    trace(matrix)

**Deprecated:** Use `LinearAlgebra.tr(matrix)` instead.
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

**Deprecated:** Use `2π` instead.
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
    length(axdef) != 3 && throw(ArgumentError("`axdef` must be an iterable with three elements."))
    length(plndef) != 3 && throw(ArgumentError("`plndef` must be an iterable with three elements."))
    mout = Array{SpiceDouble}(undef, 3, 3)
    ccall((:twovec_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceInt, Ptr{SpiceDouble}, SpiceInt, Ptr{SpiceDouble}),
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
    ccall((:tyear_c, libcspice), Cdouble, ())
end
