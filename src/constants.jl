export spd, tyear, clight, b1900, b1950

"Returns the number of seconds in a day."
function spd()
    ccall((:spd_c, libcspice), Cdouble, ())
end

"Returns the number of seconds per tropical year."
function tyear()
    ccall((:tyear_c, libcspice), Cdouble, ())
end

"Returns the speed of light in vacuo (km/sec)."
function clight()
    ccall((:clight_c, libcspice), Cdouble, ())
end