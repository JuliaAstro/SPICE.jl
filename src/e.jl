export
    edlimb,
    et2utc,
    etcal,
    eul2m,
    edterm

"""
    edlimb(a, b, c, viewpt)

Find the limb of a triaxial ellipsoid, viewed from a specified point.

### Arguments ###

- `a`: Length of ellipsoid semi-axis lying on the x-axis
- `b`: Length of ellipsoid semi-axis lying on the y-axis
- `c`: Length of ellipsoid semi-axis lying on the z-axis
- `viewpt`: Location of viewing point

### Output ###

Returns the limb of the ellipsoid as seen from the viewing point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/edlimb_c.html)
"""
function edlimb(a, b, c, viewpt)
    length(viewpt) != 3 && throw(ArgumentError("Length of `viewpt` must be 3."))
    limb = Ellipse()
    ccall((:edlimb_c, libcspice), Cvoid,
           (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}, Ref{Ellipse}),
           a, b, c, viewpt, limb)
    handleerror()
    limb
end

"""
    et2utc(et, format, prec)

Convert an input time from ephemeris seconds past J2000
to Calendar, Day-of-Year, or Julian Date format, UTC.

### Arguments ###

- `et`: Input epoch, given in ephemeris seconds past J2000
- `format`: Format of output epoch. It may be any of the following:
    - `:C`: Calendar format, UTC
    - `:D`: Day-of-Year format, UTC
    - `:J`: Julian Date format, UTC
    - `:ISOC`: ISO Calendar format, UTC
    - `:ISOD`: ISO Day-of-Year format, UTC
- `prec`: Digits of precision in fractional seconds or days

### Output ###

Returns an output time string equivalent to the input epoch, in the specified format.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/et2utc_c.html)
"""
function et2utc(et, format, prec)
    lenout = 32
    utcstr = Array{UInt8}(undef, lenout)
    ccall((:et2utc_c, libcspice), Cvoid,
          (SpiceDouble, Cstring, SpiceInt, SpiceInt, Ref{UInt8}),
          et, string(format), prec, lenout, utcstr)
    handleerror()
    chararray_to_string(utcstr)
end

"""
    etcal(et, lenout=128)

Convert from an ephemeris epoch measured in seconds past the epoch of J2000 to
a calendar string format using a formal calendar free of leapseconds.

### Arguments ###

- `et`: Ephemeris time measured in seconds past J2000
- `lenout`: Length of output string (default: 128)

### Output ###

Returns a standard calendar representation of `et`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/etcal_c.html)
"""
function etcal(et, lenout=128)
    string = Array{UInt8}(undef, lenout)
    ccall((:etcal_c, libcspice), Cvoid, (SpiceDouble, SpiceInt, Ref{UInt8}),
          et, lenout, string)
    chararray_to_string(string)
end

"""
    eul2m(angle3, angle2, angle1, axis3, axis2, axis1)

Construct a rotation matrix from a set of Euler angles.

### Arguments ###

- `angle3`, `angle2`, `angle1`: Rotation angles about third, second, and first rotation axes (radians)
- `axis3`, `axis2`, `axis1`: Axis numbers of third, second, and first rotation axes

### Output ###

A rotation matrix corresponding to the product of the 3 rotations.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eul2m_c.html)
"""
function eul2m(angle3, angle2, angle1, axis3, axis2, axis1)
    r = Matrix{SpiceDouble}(undef, 3, 3)
    ccall((:eul2m_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          angle3, angle2, angle1, axis3, axis2, axis1, r)
    handleerror()
    permutedims(r)
end

"""
    edterm(trmtyp, source, target, et, fixref, obsrvr, abcorr)

Compute a set of points on the umbral or penumbral terminator of a specified
target body, where the target shape is modeled as an ellipsoid.

### Arguments ###

- `trmtyp`: Terminator type.
- `source`: Light source.
- `target`: Target body.
- `et`: Observation epoch.
- `fixref`: Body-fixed frame associated with target.
- `obsrvr`: Observer.
- `npts`: Number of points in terminator set.
- `abcorr`: Aberration correction.

### Output ###

- `trgepc`: Epoch associated with target center.
- `obspos`: Position of observer in body-fixed frame.
- `trmpts`: Terminator point set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/edterm_c.html)
"""
function edterm(trmtyp, source, target, et, fixref, obsrvr, npts; abcorr="NONE")
    trgepc = Ref{SpiceDouble}(0)
    obspos = Array{SpiceDouble}(undef, 3)
    trmpts = Array{SpiceDouble}(undef, 3, npts)
    ccall((:edterm_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          trmtyp, source, target, et, fixref, abcorr, obsrvr, npts, trgepc, obspos, trmpts)
    handleerror()
    trgepc[], obspos, trmpts
end
