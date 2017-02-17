export j1900, j1950, j2000, j2100, jyear

"""
    j1900()

Returns the Julian Date of 1899 DEC 31 12:00:00 (1900 JAN 0.5).

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j1900_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j1900_c.html)
"""
function j1900()
    ccall((:j1900_c, libcspice), Cdouble, ())
end

"""
    j1950()

Returns the Julian Date of 1950 JAN 01 00:00:00 (1950 JAN 1.0).

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j1950_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j1950_c.html)
"""
function j1950()
    ccall((:j1950_c, libcspice), Cdouble, ())
end

"""
    j2000()

Returns the Julian Date of 2000 JAN 01 12:00:00 (2000 JAN 1.5).

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j2000_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j2000_c.html)
"""
function j2000()
    ccall((:j2000_c, libcspice), Cdouble, ())
end

"""
    j2100()

Returns the Julian Date of 2100 JAN 01 12:00:00 (2100 JAN 1.5).

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j2100_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j2100_c.html)
"""
function j2100()
    ccall((:j2100_c, libcspice), Cdouble, ())
end


"""
    jyear()

Returns the number of seconds per Julian year.

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/jyear_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/jyear_c.html)
"""
function jyear()
    ccall((:jyear_c, libcspice), Cdouble, ())
end