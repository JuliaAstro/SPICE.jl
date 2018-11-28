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
    lmpool

"""
    lastnb(str)
    
Return the zero based index of the last non-blank character in
a character string.

### Arguments ###

- `str`: Input character string

### Output ###

The function returns the one-based index of the last non-blank 
character in a character string. If the string is entirely blank 
or is empty, the value 0 is returned.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lastnb_c.html)
"""
function lastnb(str)
    r = ccall((:lastnb_c, libcspice), SpiceInt, (Cstring,), str)
    handleerror()
    r+1
end

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
    ccall((:latcyl_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble,  
          Ref{SpiceDouble},  Ref{SpiceDouble},  Ref{SpiceDouble}), radius, lon, lat, r, lonc, z)
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
    ccall((:latrec_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble, Ptr{SpiceDouble}),
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
    ccall((:latsph_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble,  
          Ref{SpiceDouble},  Ref{SpiceDouble},  Ref{SpiceDouble}), radius, lon, lat, rho, colat, lons)
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
- `npts`: Number of coordinate pairs in input array
- `lonlat`: Array of longitude/latitude coordinate pairs

### Output ###

Returns an array of surface points

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/latsrf_c.html)
"""
function latsrf(method, target, et, fixref, lonlat)
    npts = length(lonlat)
    lonlat = permutedims(hcat(collect.(lonlat)...))
    srfpts = Matrix{SpiceDouble}(undef, npts, 3)
    ccall((:latsrf_c, libcspice), Cvoid, (Cstring, Cstring, SpiceDouble, Cstring,  SpiceInt,  Ptr{SpiceDouble}, Ptr{SpiceDouble}), method, target, et, fixref, npts, lonlat, srfpts)
    handleerror()
    [srfpts[i, :] for i in 1:size(srfpts,1)]
end

_lcase(in) = _lcase(in,length(in)+1)

function _lcase(in,lenout)
    out = Array{UInt8}(undef, lenout)
    ccall((:lcase_c, libcspice), Cvoid, (Cstring, SpiceInt, Ptr{UInt8}), in, lenout, out)
    handleerror()
    unsafe_string(pointer(out))
end
"""
    lcase(in)

**Deprecated:** Use `lowercase(in)` instead.
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

Returns the tuple `(p, dp)`.

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
    p = Ref{SpiceDouble}()
    dp = Ref{SpiceDouble}()
    work = Matrix{SpiceDouble}(undef,2,n)
    ccall((:lgrind_c, libcspice), Cvoid, (SpiceInt, Ptr{SpiceDouble}, Ptr{SpiceDouble},
          Ptr{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}), n, xvals, yvals, work, x, p, dp)
    handleerror()
    p[], dp[]
end

"""
    limbpt(method, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp, ncuts, schstp, soltol, maxn)
    
Find limb points on a target body. The limb is the set of points 
of tangency on the target of rays emanating from the observer. 
The caller specifies half-planes bounded by the observer-target 
center vector in which to search for limb points. 
  
The surface of the target body may be represented either by a 
triaxial ellipsoid or by topographic data. 
 
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
function limbpt(method, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp, ncuts, schstp, soltol, maxn)
    npts = Array{SpiceInt}(undef, ncuts)
    points = Matrix{SpiceDouble}(undef, 3, maxn)
    epochs = Array{SpiceDouble}(undef, maxn)
    tangts = Matrix{SpiceDouble}(undef, 3, maxn)
    ccall((:limbpt_c, libcspice), Cvoid, (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Cstring,
          Ptr{SpiceDouble}, SpiceDouble, SpiceInt, SpiceDouble, SpiceDouble, SpiceInt, Ptr{SpiceInt}, Ptr{SpiceDouble}, 
          Ptr{SpiceDouble}, Ptr{SpiceDouble}), method, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp, 
          ncuts, schstp, soltol, maxn, npts, points, epochs, tangts)
    handleerror()
    npts, permutedims(points), epochs, permutedims(tangts)
end

# WIP
"""
   lmpool(cvals)
    
Load the variables contained in an internal buffer into the 
kernel pool.

### Arguments ###

- `cvals`: An array that contains a SPICE text kernel

### Output ###

None

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lmpool_c.html)
"""
function lmpool(cvals)
    cvals, n, lenvals = chararray(cvals)
    ccall((:lmpool_c, libcspice), Cvoid, (Ptr{UInt8}, SpiceInt, SpiceInt), cvals, lenvals, n)
    handleerror()
end





