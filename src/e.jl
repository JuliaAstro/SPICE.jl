export 
    eul2m,
    et2utc

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
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt, SpiceInt, SpiceInt, Ptr{SpiceDouble}),
          angle3, angle2, angle1, axis3, axis2, axis1, r)
    handleerror()
    permutedims(r)
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

Returns an output time string equivalent to the input
epoch, in the specified format.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/et2utc_c.html)
"""
function et2utc(et, format, prec)
    lenout = 32
    utcstr = Array{UInt8}(undef, lenout)
    ccall((:et2utc_c, libcspice), Cvoid,
          (SpiceDouble, Cstring, SpiceInt, SpiceInt, Ptr{UInt8}),
          et, string(format), prec, lenout, utcstr)
    handleerror()
    unsafe_string(pointer(utcstr))
end
