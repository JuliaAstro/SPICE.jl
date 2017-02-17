export b1900, b1950

"""
    b1900()

Returns the Julian Date corresponding to Besselian date 1900.0.

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/b1900_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/b1900_c.html)
"""
function b1900()
    ccall((:b1900_c, libcspice), SpiceDouble, ())
end

"""
    b1950()

Returns the Julian Date corresponding to Besselian date 1950.0.

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/b1950_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/b1950_c.html)
"""
function b1950()
    ccall((:b1950_c, libcspice), SpiceDouble, ())
end