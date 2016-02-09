export spd, jyear, tyear, clight, b1900, b1950
export j1900, j1950, j2000, j2100

"Returns the number of seconds in a day."
function spd()
    ccall((:spd_c, libcspice), Cdouble, ())
end

"Returns the number of seconds per Julian year."
function jyear()
    ccall((:jyear_c, libcspice), Cdouble, ())
end

"Returns the number of seconds per tropical year."
function tyear()
    ccall((:tyear_c, libcspice), Cdouble, ())
end

"Returns the speed of light in vacuo (km/sec)."
function clight()
    ccall((:clight_c, libcspice), Cdouble, ())
end

"Returns the Julian Date corresponding to Besselian date 1900.0."
function b1900()
    ccall((:b1900_c, libcspice), Cdouble, ())
end

"Returns the Julian Date corresponding to Besselian date 1950.0."
function b1950()
    ccall((:b1950_c, libcspice), Cdouble, ())
end

"Returns the Julian Date of 1899 DEC 31 12:00:00 (1900 JAN 0.5)."
function j1900()
    ccall((:j1900_c, libcspice), Cdouble, ())
end

"Returns the Julian Date of 1950 JAN 01 00:00:00 (1950 JAN 1.0)."
function j1950()
    ccall((:j1950_c, libcspice), Cdouble, ())
end

"Returns the Julian Date of 2000 JAN 01 12:00:00 (2000 JAN 1.5)."
function j2000()
    ccall((:j2000_c, libcspice), Cdouble, ())
end

"Returns the Julian Date of 2100 JAN 01 12:00:00 (2100 JAN 1.5)."
function j2100()
    ccall((:j2100_c, libcspice), Cdouble, ())
end
