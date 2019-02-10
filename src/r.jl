export
    radrec,
    rav2xf,
    raxisa,
    reccyl,
    recgeo,
    reclat,
    recpgr,
    recsph,
    recrad,
    rotate

"""
    radrec(range, ra, dec)

Convert from range, right ascension, and declination to rectangular coordinates.

### Arguments ###

range      I   Distance of a point from the origin.
ra         I   Right ascension of point in radians.
dec        I   Declination of point in radians.

### Output ###

Returns the rectangular coordinates of the point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/radrec_c.html)
"""
function radrec(range, ra, dec)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:radrec_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ptr{SpiceDouble}),
          range, ra, dec, rectan)
    rectan
end

"""
    rav2xf(rot, av)

Determine a state transformation matrix from a rotation matrix and the angular
velocity of the rotation.

### Arguments ###

- `rot`: Rotation matrix
- `av`: Angular velocity vector

### Output ###

Returns state transformation matrix associated with `rot` and `av`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/rav2xf_c.html)
"""
function rav2xf(rot, av)
    xform = Array{SpiceDouble}(undef, 6, 6)
    ccall((:rav2xf_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          permutedims(rot), av, xform)
    permutedims(xform)
end

"""
    raxisa(matrix)

Compute the axis of the rotation given by an input matrix and the angle of the rotation
about that axis.

### Arguments ###

- `matrix`: A 3x3 rotation matrix

### Output ###

- `axis`: Axis of the rotation
- `angle`: Angle through which the rotation is performed

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/raxisa_c.html)
"""
function raxisa(matrix)
    size(matrix) != (3, 3) && throw(ArgumentError("`matrix` must be a 3x3 matrix."))
    axis = Array{SpiceDouble}(undef, 3)
    angle = Ref{SpiceDouble}()
    ccall((:raxisa_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceDouble}),
          permutedims(matrix), axis, angle)
    handleerror()
    axis, angle[]
end

"""
    reccyl(rectan)

Convert from rectangular to cylindrical coordinates.

### Arguments ###

- `rectan`: Rectangular coordinates of a point

### Output ###

- `r`: Distance of the point from the Z axis
- `lon`: Angle (radians) of the point from the XZ plane
- `z`: Height of the point above the XY plane

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/reccyl_c.html)
"""
function reccyl(rectan)
    length(rectan) != 3 && throw(ArgumentError("Length of `rectan` must be 3."))
    r = Ref{SpiceDouble}()
    lon = Ref{SpiceDouble}()
    z = Ref{SpiceDouble}()
    ccall((:reccyl_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          rectan, r, lon, z)
    r[], lon[], z[]
end


"""
    recgeo(rectan, re, f)

Convert from rectangular coordinates to geodetic coordinates.

### Arguments ###

- `rectan`: Rectangular coordinates of a point
- `re`: Equatorial radius of the reference spheroid
- `f`: Flattening coefficient

### Output ###

- `lon`: Geodetic longitude of the point (radians)
- `lat`: Geodetic latitude  of the point (radians)
- `alt`: Altitude of the point above reference spheroid

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/recgeo_c.html)
"""
function recgeo(rectan, re, f)
    length(rectan) != 3 && throw(ArgumentError("Length of `rectan` must be 3."))
    lon = Ref{SpiceDouble}()
    lat = Ref{SpiceDouble}()
    alt = Ref{SpiceDouble}()
    ccall((:recgeo_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceDouble, SpiceDouble,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          rectan, re, f, lon, lat, alt)
    handleerror()
    lon[], lat[], alt[]
end

"""
    reclat(rectan)

Convert from rectangular coordinates to latitudinal coordinates.

### Arguments ###

- `rectan`: Rectangular coordinates of a point

### Output ###

Returns a tuple consisting of:

- `rad`: Distance of the point from the origin
- `lon`: Planetographic longitude of the point (radians)
- `lat`: Planetographic latitude of the point (radians)

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/reclat_c.html)
"""
function reclat(rectan)
    length(rectan) != 3 && throw(ArgumentError("Length of `rectan` must be 3."))
    lon = Ref{SpiceDouble}()
    lat = Ref{SpiceDouble}()
    rad = Ref{SpiceDouble}()
    ccall((:reclat_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          collect(rectan), rad, lon, lat)
    rad[], lon[], lat[]
end

"""
    recpgr(body, rectan, re, f)

Convert rectangular coordinates to planetographic coordinates.

### Arguments ###

- `body`: Body with which coordinate system is associated
- `rectan`: Rectangular coordinates of a point
- `re`: Equatorial radius of the reference spheroid
- `f`: flattening coefficient

### Output ###

- `lon`: Planetographic longitude of the point (radians).
- `lat`: Planetographic latitude of the point (radians).
- `alt`: Altitude of the point above reference spheroid.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/recpgr_c.html)
"""
function recpgr(body, rectan, re, f)
    length(rectan) != 3 && throw(ArgumentError("Length of `rectan` must be 3."))
    lon = Ref{SpiceDouble}()
    lat = Ref{SpiceDouble}()
    alt = Ref{SpiceDouble}()
    ccall((:recpgr_c, libcspice), Cvoid,
          (Cstring, Ptr{SpiceDouble}, SpiceDouble, SpiceDouble,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          body, rectan, re, f, lon, lat, alt)
    handleerror()
    lon[], lat[], alt[]
end


"""
    recsph(rectan)

Convert from rectangular coordinates to spherical coordinates.

### Arguments ###

- `rectan`: Rectangular coordinates of a point

### Output ###

- `r     `: Distance of the point from the origin
- `colat `: Angle of the point from the Z-axis in radian
- `lon   `: Longitude of the point in radians

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/recsph_c.html)
"""
function recsph(rectan)
    length(rectan) != 3 && throw(ArgumentError("Length of `rectan` must be 3."))
    r = Ref{SpiceDouble}()
    colat = Ref{SpiceDouble}()
    lon = Ref{SpiceDouble}()
    ccall((:recsph_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          rectan, r, colat, lon)
    r[], colat[], lon[]
end

"""
    rotate(angle, iaxis)

Calculate the 3x3 rotation matrix generated by a rotation
of a specified angle about a specified axis. This rotation
is thought of as rotating the coordinate system.

### Arguments ###

- `angle`: Angle of rotation (radians)
- `iaxis`: Axis of rotation (X=1, Y=2, Z=3)

### Output ###

Returns rotation matrix associated with `angle` and `iaxis`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/rotate_c.html)
"""
function rotate(angle, iaxis)
    r = Matrix{SpiceDouble}(undef, 3, 3)
    ccall((:rotate_c, libcspice), Cvoid, (SpiceDouble, SpiceInt, Ptr{SpiceDouble}), angle, iaxis, r)
    permutedims(r)
end

"""
    recrad(rectan)

Convert rectangular coordinates to range, right ascension, and
declination.

### Arguments ###

- `rectan`: Rectangular coordinates of a point

### Output ###

Return the tuple `(range, ra, dec)`.

- `range`: Distance of the point from the origin
- `ra`: Right ascension in radians
- `dec`: Declination in radians

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/recrad_c.html)
"""
function recrad(rectan)
    range = Ref{SpiceDouble}()
    ra = Ref{SpiceDouble}()
    dec = Ref{SpiceDouble}()
    ccall((:recrad_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          rectan, range, ra, dec)
    range[], ra[], dec[]
end
