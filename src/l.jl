export
    lastnb,
    latcyl,
    latrec,
    latsph,
    latsrf,
    lcase,
    ldpool,
    lgrind,
    limbpt,
    lmpool,
    lparse,
    lparsm,
    lparss,
    lspcn,
    lstlec,
    lstled,
    lstlei,
    lstle,
    lstltc,
    lstltd,
    lstlti,
    lstlt,
    ltime,
    lx4dec,
    lx4num,
    lx4sgn,
    lx4uns,
    lxqstr

function _lastnb(str)
    r = ccall((:lastnb_c, libcspice), SpiceInt, (Cstring,), str)
    handleerror()
    r + 1
end

@deprecate lastnb(str) findprev(!isspace, str, length(str))

"""
    lastnb(str)

!!! warning "Deprecated"
    Use `findprev(!isspace, str, length(str))` instead.
"""
lastnb

"""
    latcyl(radius, lon, lat)

Convert from latitudinal coordinates to cylindrical coordinates.

### Arguments ###

- `radius`: Distance of a point from the origin
- `lon`: Angle of the point from the XZ plane in radians
- `lat`: Angle of the point from the XY plane in radians

### Output ###

Return the tuple `(r, lonc, z)`.

- `r`: Distance of the point from the z axis
- `lonc`: Angle of the point from the XZ plane in radians. 'lonc' is set equal to 'lon'
- `z`: Height of the point above the XY plane

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/latcyl_c.html)
"""
function latcyl(radius, lon, lat)
    r = Ref{SpiceDouble}()
    lonc = Ref{SpiceDouble}()
    z = Ref{SpiceDouble}()
    ccall((:latcyl_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          radius, lon, lat, r, lonc, z)
    r[], lonc[], z[]
end

"""
    latrec(radius, lon, lat)

Convert from latitudinal coordinates to rectangular coordinates.

### Arguments ###

- `radius`: Distance of a point from the origin
- `lon`: Angle of the point from the XZ plane in radians
- `lat`: Angle of the point from the XY plane in radians

### Output ###

Return the rectangular coordinates vector of the point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/latrec_c.html)
"""
function latrec(radius, lon, lat)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:latrec_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          radius, lon, lat, rectan)
    rectan
end

"""
    latsph(radius, lon, lat)

Convert from latitudinal coordinates to rectangular coordinates.

### Arguments ###

- `radius`: Distance of a point from the origin
- `lon`: Angle of the point from the XZ plane in radians
- `lat`: Angle of the point from the XY plane in radians

### Output ###

Return the tuple `(rho, colat, lons)`.

- `rho`: Distance of the point from the origin
- `colat`: Angle of the point from positive z axis (radians)
- `lons`: Angle of the point from the XZ plane (radians)

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/latsph_c.html)
"""
function latsph(radius, lon, lat)
    rho = Ref{SpiceDouble}()
    colat = Ref{SpiceDouble}()
    lons = Ref{SpiceDouble}()
    ccall((:latsph_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble},  Ref{SpiceDouble},  Ref{SpiceDouble}),
          radius, lon, lat, rho, colat, lons)
    rho[], colat[], lons[]
end

"""
    latsrf(method, target, et, fixref, npts, lonlat)

Map array of planetocentric longitude/latitude coordinate pairs
to surface points on a specified target body.

The surface of the target body may be represented by a triaxial
ellipsoid or by topographic data provided by DSK files.

### Arguments ###

- `method`: Computation method
- `target`: Name of target body
- `et`: Epoch in TDB seconds past J2000 TDB
- `fixref`: Body-fixed, body-centered target body frame
- `lonlat`: Array of longitude/latitude coordinate pairs

### Output ###

Returns an array of surface points.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/latsrf_c.html)
"""
function latsrf(method, target, et, fixref, lonlat)
    npts = length(lonlat)
    lonlat_ = array_to_cmatrix(lonlat, n=2)
    srfpts = Array{SpiceDouble}(undef, 3, npts)
    ccall((:latsrf_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}),
          method, target, et, fixref, npts, lonlat_, srfpts)
    handleerror()
    cmatrix_to_array(srfpts)
end

_lcase(in) = _lcase(in,length(in)+1)

function _lcase(in,lenout)
    out = Array{SpiceChar}(undef, lenout)
    ccall((:lcase_c, libcspice), Cvoid, (Cstring, SpiceInt, Ref{SpiceChar}), in, lenout, out)
    handleerror()
    chararray_to_string(out)
end
"""
    lcase(in)

!!! warning "Deprecated"
    Use `lowercase(in)` instead.
"""
lcase

@deprecate lcase(in) lowercase(in)

"""
   ldpool(kernel)

Load the variables contained in a NAIF ASCII kernel file into the
kernel pool.

### Arguments ###

- `kernel`: Name of the kernel file

### Output ###

None

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ldpool_c.html)
"""
function ldpool(kernel)
    ccall((:ldpool_c, libcspice), Cvoid, (Cstring,), kernel)
    handleerror()
end

"""
    lgrind(xvals, yvals, x)

Evaluate a Lagrange interpolating polynomial for a specified
set of coordinate pairs, at a specified abscissa value.
Return the value of both polynomial and derivative.

### Arguments ###

- `xvals`: Abscissa values of coordinate pairs
- `yvals`: Ordinate values of coordinate pairs
- `x`: Point at which to interpolate the polynomial

### Output ###

- `p`: The value at x of the unique polynomial of
       degree n-1 that fits the points in the plane
       defined by xvals and yvals
- `dp`: The derivative at x of the interpolating
        polynomial described above

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lgrind_c.html)
"""
function lgrind(xvals, yvals, x)
    n = length(xvals)
    @checkdims n yvals
    p = Ref{SpiceDouble}()
    dp = Ref{SpiceDouble}()
    work = Matrix{SpiceDouble}(undef, 2, n)
    ccall((:lgrind_c, libcspice), Cvoid,
          (SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble},
           Ref{SpiceDouble}),
          n, xvals, yvals, work, x, p, dp)
    handleerror()
    p[], dp[]
end

"""
    limbpt(method, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp, ncuts, schstp,
           soltol, maxn)

Find limb points on a target body. The limb is the set of points of tangency on the target of rays
emanating from the observer.  The caller specifies half-planes bounded by the observer-target
center vector in which to search for limb points.

The surface of the target body may be represented either by a triaxial ellipsoid or by
topographic data.

### Arguments ###

- `method`: Computation method
- `target`: Name of target body
- `et`: Epoch in ephemeris seconds past J2000 TDB
- `fixref`: Body-fixed, body-centered target body frame
- `abcorr`: Aberration correction
- `corloc`: Aberration correction locus
- `obsrvr`: Name of observing body
- `refvec`: Reference vector for cutting half-planes
- `rolstp`: Roll angular step for cutting half-planes
- `ncuts`: Number of cutting half-planes
- `schstp`: Angular step size for searching
- `soltol`: Solution convergence tolerance
- `maxn`: Maximum number of entries in output arrays

### Output ###

Returns the tuple `(npts, points, epochs, tangts)`.

- `npts`: Counts of limb points corresponding to cuts
- `points`: Limb points
- `epochs`: Times associated with limb points
- `tangts`: Tangent vectors emanating from the observer

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lgrind_c.html)
"""
function limbpt(method, target, et, fixref, abcorr, corloc, obsrvr, refvec,
                rolstp, ncuts, schstp, soltol, maxn)
    @checkdims 3 refvec
    npts = Array{SpiceInt}(undef, ncuts)
    points = Array{SpiceDouble}(undef, 3, maxn)
    epochs = Array{SpiceDouble}(undef, maxn)
    tangts = Array{SpiceDouble}(undef, 3, maxn)
    ccall((:limbpt_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Cstring,
          Ref{SpiceDouble}, SpiceDouble, SpiceInt, SpiceDouble, SpiceDouble,
          SpiceInt, Ref{SpiceInt}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          method, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp,
          ncuts, schstp, soltol, maxn, npts, points, epochs, tangts)
    handleerror()
    npts, cmatrix_to_array(points), epochs, cmatrix_to_array(tangts)
end

@deprecate limb_pl02 limbpt
@deprecate llgrid_pl02 latsrf

"""
   lmpool(cvals)

Load the variables contained in an internal buffer into the
kernel pool.

### Arguments ###

- `cvals`: An array that contains a SPICE text kernel

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lmpool_c.html)
"""
function lmpool(cvals)
    cvals_, n, lenvals = chararray(cvals)
    ccall((:lmpool_c, libcspice), Cvoid, (Ref{SpiceChar}, SpiceInt, SpiceInt), cvals_, lenvals, n)
    handleerror()
end

function _lparse(list, delim, nmax)
    lenout = length(list)+1
    n = Ref{SpiceInt}()
    items = Array{SpiceChar}(undef, lenout, nmax)
    ccall((:lparse_c, libcspice), Cvoid, (Cstring, Cstring, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}),
          list, delim, nmax, lenout, n , items)
    handleerror()
    chararray_to_string(items, n[])
end

@deprecate lparse(list, delim, nmax) split(list, delim, limit=nmax)

"""
   lparse(list, delim, nmax)

!!! warning "Deprecated"
    Use `split(list, delim, limit=nmax)` instead.
"""
lparse

function _lparsm(list, delims, nmax)
    lenout = length(list) + 1
    n = Ref{SpiceInt}()
    items = Array{SpiceChar}(undef, lenout, nmax)
    ccall((:lparsm_c, libcspice), Cvoid, (Cstring, Cstring, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}),
          list, delims, nmax, lenout, n , items)
    handleerror()
    chararray_to_string(items, n[])
end

@deprecate lparsm(list, delim, nmax) split(list, delim, limit=nmax, keepempty=false)

"""
   lparsm(list, delims, nmax)

!!! warning "Deprecated"
    Use `split(list, delim, limit=nmax, keepempty=false)` instead.
"""
lparsm

function _lparss(list, delims)
    items = SpiceCharCell(length(list), length(list))
    ccall((:lparss_c, libcspice), Cvoid, (Cstring, Cstring, Ref{Cell{SpiceChar}}),
          list, delims, Ref(items.cell))
    handleerror()
    items
end

@deprecate lparss(list, delim) Set(split(list, collect(delim)))

"""
   lparss(list, delims)

!!! warning "Deprecated"
    Use `Set(split(list, collect(delim)))` instead.
"""
lparss

"""
   lspcn(body, et, abcorr)

Compute L_s, the planetocentric longitude of the sun, as seen
from a specified body.

### Arguments ###

- `body`: Name of the central body
- `et`: Epoch in seconds past J2000 TDB
- `abcorr`: Aberration correction

### Output ###

Returns the planetocentric longitude of the sun for the specified body
at the specified time in radians.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lspcn_c.html)
"""
function lspcn(body, et, abcorr)
    out = ccall((:lspcn_c, libcspice), SpiceDouble, (Cstring, SpiceDouble, Cstring),
         body, et, abcorr)
    handleerror()
    out
end


function _lstle(string::AbstractString, array)
    n = length(array)
    array_, n, lenvals = chararray(array)
    out = ccall((:lstlec_c, libcspice), SpiceInt, (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}),
                string, n, lenvals, array_)
    handleerror()
    out + 1
end

function _lstle(x::AbstractFloat, array)
    n = length(array)
    out = ccall((:lstled_c, libcspice), SpiceInt, (SpiceDouble, SpiceInt, Ref{SpiceDouble}),
                x, n, array)
    out + 1
end

function _lstle(x::Signed, array)
    n = length(array)
    array_ = SpiceInt.(array)
    out = ccall((:lstlei_c, libcspice), SpiceInt, (SpiceInt, SpiceInt, Ref{SpiceInt}),
                x, n, array_)
    out + 1
end

@deprecate lstlec(item, array) findfirst(item .<= array)
@deprecate lstled(item, array) searchsortedlast(array, item)
@deprecate lstlei(item, array) searchsortedlast(array, item)

"""
    lstlecd(x, array)

!!! warning "Deprecated"
    Use `findfirst(item .<= array)` instead.
"""
lstlec

"""
    lstle[di](x, array)

!!! warning "Deprecated"
    Use `searchsortedlast(array, x)` instead.
"""
lstled
lstlei

function _lstlt(string::AbstractString, array)
    n = length(array)
    array_, n, lenvals = chararray(array)
    out = ccall((:lstltc_c, libcspice), SpiceInt, (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}),
                string, n, lenvals, array_)
    handleerror()
    out + 1
end

function _lstlt(x::AbstractFloat, array)
    n = length(array)
    out = ccall((:lstltd_c, libcspice), SpiceInt, (SpiceDouble, SpiceInt, Ref{SpiceDouble}),
                x, n, array)
    out + 1
end

function _lstlt(x::Signed, array)
    n = length(array)
    array_ = SpiceInt.(array)
    out = ccall((:lstlti_c, libcspice), SpiceInt, (SpiceInt, SpiceInt, Ref{SpiceInt}),
                x, n, array_)
    out + 1
end

@deprecate lstltc(item, array) findfirst(item .< array)
@deprecate lstltd(item, array) searchsortedlast(array, item, lt=<=)
@deprecate lstlti(item, array) searchsortedlast(array, item, lt=<=)

"""
    lstltcd(x, array)

!!! warning "Deprecated"
    Use `findfirst(item .< array)` instead.
"""
lstltc

"""
    lstlt[di](x, array)

!!! warning "Deprecated"
    Use `searchsortedlast(array, x, lt=<=)` instead.
"""
lstltd
lstlti


"""
    ltime(etobs, obs, dir, targ)

This routine computes the transmit (or receive) time
of a signal at a specified target, given the receive
(or transmit) time at a specified observer. The elapsed
time between transmit and receive is also returned.

### Arguments ###

- `etobs`: Epoch of a signal at some observer
- `obs`: NAIF ID of some observer
- `dir`: Direction the signal travels ( "->" or "<-" )
- `targ`: Time between transmit and receipt of the signal

### Output ###

- `ettarg`: Epoch of the signal at the target
- `obs`: NAIF ID of some observer

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ltime_c.html)
"""
function ltime(etobs, obs, dir, targ)
    ettarg = Ref{SpiceDouble}()
    elapsd = Ref{SpiceDouble}()
    ccall((:ltime_c, libcspice), Cvoid,
          (SpiceDouble, SpiceInt, Cstring, SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}),
          etobs, obs, dir, targ, ettarg, elapsd)
    ettarg[], elapsd[]
end

"""
    lx4dec(string, first)

Scan a string from a specified starting position for the
end of a decimal number.

### Arguments ###

- `string`: Any character string
- `first`: First character to scan from in string

### Output ###

- `last`: Last character that is part of a decimal number. If there is no such
          character, last will be returned with the value first-1.
- `nchar`: Number of characters in the decimal number

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lx4dec_c.html)
"""
function lx4dec(string, first)
    last = Ref{SpiceInt}()
    nchar = Ref{SpiceInt}()
    ccall((:lx4dec_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}),
          string, first - 1, last, nchar)
    handleerror()
    last[] + 1, Int(nchar[])
end

"""
    lx4num(string, first)

Scan a string from a specified starting position for the
end of a number.

### Arguments ###

- `string`: Any character string
- `first`: First character to scan from in string

### Output ###

- `last`: Last character that is part of a number. If there is no such
          character, last will be returned with the value first-1.
- `nchar`: Number of characters in the number

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lx4num_c.html)
"""
function lx4num(string, first)
    last = Ref{SpiceInt}()
    nchar = Ref{SpiceInt}()
    ccall((:lx4num_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}),
          string, first - 1, last, nchar)
    handleerror()
    last[] + 1, Int(nchar[])
end

"""
    lx4sgn(string, first)

Scan a string from a specified starting position for the end of a signed integer.

### Arguments ###

- `string`: Any character string
- `first`: First character to scan from in string

### Output ###

- `last`: Last character that is part of a signed integer. If there is no such
          character, last will be returned with the value first-1.
- `nchar`: Number of characters in the signed integer

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lx4sgn_c.html)
"""
function lx4sgn(string, first)
    last = Ref{SpiceInt}()
    nchar = Ref{SpiceInt}()
    ccall((:lx4sgn_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}),
          string, first - 1, last, nchar)
    handleerror()
    last[] + 1, nchar[]
end

"""
    lx4uns(string, first)

Scan a string from a specified starting position for the
end of a unsigned integer.

### Arguments ###

- `string`: Any character string
- `first`: First character to scan from in string

### Output ###

- `last`: Last character that is part of an unsigned integer. If there is no such
          character, last will be returned with the value first-1.
- `nchar`: Number of characters in the unsigned integer

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lx4uns_c.html)
"""
function lx4uns(string, first)
    last = Ref{SpiceInt}()
    nchar = Ref{SpiceInt}()
    ccall((:lx4uns_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}),
          string, first - 1, last, nchar)
    handleerror()
    last[] + 1, nchar[]
end

"""
    lxqstr(string, qchar, first)

Lex (scan) a quoted string.

### Arguments ###

- `string`: String to be scanned
- `qchar`: Quote delimiter character
- `first`: Character position at which to start scanning

### Output ###

- `last`: Character position of end of token
- `nchar`: Number of characters in token

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lxqstr_c.html)
"""
function lxqstr(string, qchar, first)
    last = Ref{SpiceInt}()
    nchar = Ref{SpiceInt}()
    ccall((:lxqstr_c, libcspice), Cvoid,
          (Cstring, SpiceChar, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}),
          string, qchar, first - 1, last, nchar)
    handleerror()
    last[] + 1, nchar[]
end

