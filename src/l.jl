export 
    lastnb,
    latcyl,
    latrec,
    latsph,
    latsrf

"""
    lastnb(str)
    
Return the zero based index of the last non-blank character in
a character string.

### Arguments ###

- `str`: Input character string

### Output ###

The function returns the zero-based index of the last non-blank 
character in a character string. If the string is entirely blank 
or is empty, the value -1 is returned.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/lastnb_c.html)
"""
function lastnb(str)
    r = ccall((:lastnb_c, libcspice), SpiceInt, (Cstring,), str)
    handleerror()
    r
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
    ccall((:latcyl_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble,  Ref{SpiceDouble},  Ref{SpiceDouble},  Ref{SpiceDouble}), radius, lon, lat, r, lonc, z)
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
    ccall((:latrec_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble, Ptr{SpiceDouble}), radius, lon, lat, rectan)
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
    ccall((:latsph_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble,  Ref{SpiceDouble},  Ref{SpiceDouble},  Ref{SpiceDouble}), radius, lon, lat, rho, colat, lons)
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
function latsrf(method, target, et, fixref, npts, lonlat)
    srfpts = Matrix{SpiceDouble}(undef,npts,3)
    ccall((:latsrf_c, libcspice), Cvoid, (Cstring, Cstring, SpiceDouble, Cstring,  SpiceInt,  Ptr{SpiceDouble}, Ptr{SpiceDouble}), method, target, et, fixref, npts, lonlat, srfpts)
    handleerror()
    srfpts
end

function latsrf(method, target, et, fixref, lonlat)
    npts=size(lonlat)[2]
    srfpts = Matrix{SpiceDouble}(undef,npts,3)
    ccall((:latsrf_c, libcspice), Cvoid, (Cstring, Cstring, SpiceDouble, Cstring,  SpiceInt,  Ptr{SpiceDouble}, Ptr{SpiceDouble}), method, target, et, fixref, npts, permutedims(lonlat), srfpts)
    handleerror()
    permutedims(srfpts)
end



