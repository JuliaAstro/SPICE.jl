export
    gcpool,
    gdpool,
    georec,
    getfov,
    gfpa,
    gfpa!,
    gipool

"""
    gcpool(name; start=1, room=100, lenout=128)

Return the value of a kernel variable from the kernel pool.

### Arguments ###

- `name`: Name of the variable whose value is to be returned
- `start`: Which component to start retrieving for name (default: 1)
- `room`: The largest number of values to return (default: 100)
- `lenout`: The length of the longest string to return (default: 128)

### Output ###

Returns an array of values if the variable exists or `nothing` if not.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gcpool_c.html)
"""
function gcpool(name; start=1, room=100, lenout=128)
    n = Ref{SpiceInt}()
    values = Array{UInt8}(undef, lenout, room)
    found = Ref{SpiceInt}()
    ccall((:gcpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{UInt8}, Ref{SpiceBoolean}),
          name, start - 1, room, lenout, n, values, found)
    handleerror()
    if Bool(found[])
        return [unsafe_string(pointer(values[:,i])) for i in 1:n[]]
    end
    nothing
end

"""
    gdpool(name; start=1, room=100)

Return the value of a kernel variable from the kernel pool.

### Arguments ###

- `name`: Name of the variable whose value is to be returned
- `start`: Which component to start retrieving for name (default: 1)
- `room`: The largest number of values to return (default: 100)

### Output ###

Returns an array of values if the variable exists or `nothing` if not.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gdpool_c.html)
"""
function gdpool(name; start=1, room=100)
    n = Ref{SpiceInt}()
    values = Array{SpiceDouble}(undef, room)
    found = Ref{SpiceInt}()
    ccall((:gdpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{SpiceDouble}, Ref{SpiceBoolean}),
          name, start - 1, room, n, values, found)
    handleerror()
    Bool(found[]) ? values[1:n[]] : nothing
end

"""
    georec(lon, lat, alt, re, f)

Convert geodetic coordinates to rectangular coordinates.

### Arguments ###

- `lon`: Geodetic longitude of point (radians)
- `lat`: Geodetic latitude  of point (radians)
- `alt`: Altitude of point above the reference spheroid
- `re`: Equatorial radius of the reference spheroid
- `f`: Flattening coefficient

### Output ###

Returns the rectangular coordinates of point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/georec_c.html)
"""
function georec(lon, lat, alt, re, f)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:georec_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble,
           Ptr{SpiceDouble}),
          lon, lat, alt, re, f, rectan)
    handleerror()
    rectan
end

"""
    getfov(instid, room=10, shapelen=128, framelen=128)

Return the field-of-view (FOV) parameters for a specified instrument.
The instrument is specified by its NAIF ID code.

### Arguments ###

- `instid  `: NAIF ID of an instrument
- `room    `: Maximum number of vectors that can be returned (default: 10)
- `shapelen`: Space available in the string `shape` (default: 128)
- `framelen`: Space available in the string `frame` (default: 128)

### Output ###

Returns a tuple consisting of

- `shape `: Instrument FOV shape
- `frame `: Name of the frame in which FOV vectors are defined
- `bsight`: Boresight vector
- `bounds`: FOV boundary vectors

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/getfov_c.html)
"""
function getfov(instid, room=10, shapelen=128, framelen=128)
    shape = Array{UInt8}(undef, shapelen)
    frame = Array{UInt8}(undef, framelen)
    bsight = Array{SpiceDouble}(undef, 3)
    n = Ref{SpiceInt}()
    bounds = Array{SpiceDouble}(undef, 3, room)
    ccall((:getfov_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, SpiceInt,
           Ptr{UInt8}, Ptr{UInt8}, Ptr{SpiceDouble}, Ref{SpiceInt}, Ptr{SpiceDouble}),
          instid, room, shapelen, framelen, shape, frame, bsight, n, bounds)
    handleerror()
    arr_bounds = cmatrix_to_array(bounds)
    unsafe_string(pointer(shape)), unsafe_string(pointer(frame)), bsight, arr_bounds[1:n[]]
end

"""
    gfpa!(cnfine, result, target, illmn, abcorr, obsrvr, relate, refval, adjust, step, nintvls)

Determine time intervals for which a specified constraint on the phase angle between an
illumination source, a target, and observer body centers is met.

### Arguments ###

- `cnfine`: Window to which the search is confined
- `target`: Name of the target body
- `illmn`: Name of the illuminating body
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `relate`: Relational operator
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count

### Output ###

Returns a tuple consisting of

- `cnfine`: Window to which the search is confined.
- `result`: Window containing results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfpa_c.html)
"""
function gfpa!(cnfine, result, target, illmn, abcorr, obsrvr, relate, refval, adjust, step, nintvls)
    ccall((:gfpa_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring,
           SpiceDouble, SpiceDouble, SpiceDouble,
           SpiceInt,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          target, illmn, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine.cell, result.cell)
    handleerror()
    cnfine, result
end

@deprecate gfpa gfpa!

"""
    gipool(name; start=1, room=100)

Return the value of a kernel variable from the kernel pool.

### Arguments ###

- `name`: Name of the variable whose value is to be returned
- `start`: Which component to start retrieving for name (default: 1)
- `room`: The largest number of values to return (default: 100)

### Output ###

Returns an array of values if the variable exists or `nothing` if not.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gipool_c.html)
"""
function gipool(name; start=1, room=100)
    n = Ref{SpiceInt}()
    values = Array{SpiceInt}(undef, room)
    found = Ref{SpiceBoolean}()
    ccall((:gipool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{SpiceInt}, Ref{SpiceBoolean}),
          name, start - 1, room, n, values, found)
    handleerror()
    Bool(found[]) ? Int.(values[1:n[]]) : nothing
end
