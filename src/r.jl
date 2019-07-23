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
    removc!,
    removc,
    removd!,
    removd,
    removi!,
    removi,
    reordc,
    reordd,
    reordi,
    reordl,
    rotate,
    rotmat,
    rotvec,
    rpd,
    rquad

"""
    radrec(range, ra, dec)

Convert from range, right ascension, and declination to rectangular coordinates.

### Arguments ###

- `range`: Distance of a point from the origin
- `ra`: Right ascension of point in radians
- `dec`: Declination of point in radians

### Output ###

Returns the rectangular coordinates of the point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/radrec_c.html)
"""
function radrec(range, ra, dec)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:radrec_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
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
    @checkdims 3 3 rot
    @checkdims 3 av
    xform = Array{SpiceDouble}(undef, 6, 6)
    ccall((:rav2xf_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
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
    @checkdims 3 3 matrix
    axis = Array{SpiceDouble}(undef, 3)
    angle = Ref{SpiceDouble}()
    ccall((:raxisa_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
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
    @checkdims 3 rectan
    r = Ref{SpiceDouble}()
    lon = Ref{SpiceDouble}()
    z = Ref{SpiceDouble}()
    ccall((:reccyl_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
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
    @checkdims 3 rectan
    lon = Ref{SpiceDouble}()
    lat = Ref{SpiceDouble}()
    alt = Ref{SpiceDouble}()
    ccall((:recgeo_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, SpiceDouble,
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
    @checkdims 3 rectan
    lon = Ref{SpiceDouble}()
    lat = Ref{SpiceDouble}()
    rad = Ref{SpiceDouble}()
    ccall((:reclat_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
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
    @checkdims 3 rectan
    lon = Ref{SpiceDouble}()
    lat = Ref{SpiceDouble}()
    alt = Ref{SpiceDouble}()
    ccall((:recpgr_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceDouble}, SpiceDouble, SpiceDouble,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          body, rectan, re, f, lon, lat, alt)
    handleerror()
    lon[], lat[], alt[]
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
    @checkdims 3 rectan
    range = Ref{SpiceDouble}()
    ra = Ref{SpiceDouble}()
    dec = Ref{SpiceDouble}()
    ccall((:recrad_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          rectan, range, ra, dec)
    range[], ra[], dec[]
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
    @checkdims 3 rectan
    r = Ref{SpiceDouble}()
    colat = Ref{SpiceDouble}()
    lon = Ref{SpiceDouble}()
    ccall((:recsph_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          rectan, r, colat, lon)
    r[], colat[], lon[]
end

"""
    removc!(set, item)

Remove an item from a character set.

### Arguments ###

- `set`: A set
- `item`: Item to be removed

### Output ###

Returns the updated set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/removc_c.html)
"""
function removc!(set, item)
    ccall((:removc_c, libcspice), Cvoid, (Cstring, Ref{Cell{SpiceChar}}), item, set.cell)
    set
end

@deprecate removc removc!

"""
    removd!(set, item)

Remove an item from a double set.

### Arguments ###

- `set`: A set
- `item`: Item to be removed

### Output ###

Returns the updated set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/removd_c.html)
"""
function removd!(set, item)
    ccall((:removd_c, libcspice), Cvoid, (SpiceDouble, Ref{Cell{SpiceDouble}}), item, set.cell)
    set
end

@deprecate removd removd!

"""
    removi!(set, item)

Remove an item from a character set.

### Arguments ###

- `set`: A set
- `item`: Item to be removed

### Output ###

Returns the updated set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/removi_c.html)
"""
function removi!(set, item)
    ccall((:removi_c, libcspice), Cvoid, (SpiceInt, Ref{Cell{SpiceInt}}), item, set.cell)
    set
end

@deprecate removi removi!

function _reordc(iorder, array)
    iorder_ = SpiceInt.(iorder .- 1)
    array_, m, n = chararray(array)
    ccall((:reordc_c, libcspice), Cvoid,
          (Ref{SpiceInt}, SpiceInt, SpiceInt, Ref{SpiceChar}),
          iorder_, m, n, array_)
    chararray_to_string(array_, m)
end

@deprecate reordc(iorder, array) array[iorder]

"""
    reordc(iorder, array)

!!! warning "Deprecated"
    Use `array[iorder]` instead.
"""
reordc

function _reordd(iorder, array)
    iorder_ = SpiceInt.(iorder .- 1)
    n = length(iorder)
    ccall((:reordd_c, libcspice), Cvoid,
          (Ref{SpiceInt}, SpiceInt, Ref{SpiceDouble}),
          iorder_, n, array)
    array
end

@deprecate reordd(iorder, array) array[iorder]

"""
    reordd(iorder, array)

!!! warning "Deprecated"
    Use `array[iorder]` instead.
"""
reordd

function _reordi(iorder, array)
    iorder_ = SpiceInt.(iorder .- 1)
    array_ = SpiceInt.(array)
    n = length(iorder)
    ccall((:reordi_c, libcspice), Cvoid,
          (Ref{SpiceInt}, SpiceInt, Ref{SpiceInt}),
          iorder_, n, array_)
    Int.(array_)
end

@deprecate reordi(iorder, array) array[iorder]

"""
    reordi(iorder, array)

!!! warning "Deprecated"
    Use `array[iorder]` instead.
"""
reordi

function _reordl(iorder, array)
    iorder_ = SpiceInt.(iorder .- 1)
    array_ = SpiceBoolean.(array)
    n = length(iorder)
    ccall((:reordl_c, libcspice), Cvoid,
          (Ref{SpiceInt}, SpiceInt, Ref{SpiceBoolean}),
          iorder_, n, array_)
    Bool.(array_)
end

@deprecate reordl(iorder, array) array[iorder]

"""
    reordl(iorder, array)

!!! warning "Deprecated"
    Use `array[iorder]` instead.
"""
reordl

function _repmc(input, marker, value)
    lenout = length(input) - length(marker) + length(value) + 1
    out = Array{SpiceChar}(undef, lenout)
    ccall((:repmc_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceInt, Ref{SpiceChar}),
          input, marker, value, lenout, out)
    handleerror()
    chararray_to_string(out)
end

@deprecate repmc(input, marker, value) replace(input, marker=>value)

"""
    repmc(input, marker, value)

!!! warning "Deprecated"
    Use `replace(input, marker=>value)` instead.
"""
repmc

@deprecate repmct replace

"""
    repmct

!!! warning "Deprecated"
    Use `replace` instead.
"""
repmct

@deprecate repmd replace

"""
    repmd

!!! warning "Deprecated"
    Use `replace` instead.
"""
repmd

@deprecate repmf replace

"""
    repmf

!!! warning "Deprecated"
    Use `replace` instead.
"""
repmf

@deprecate repmi replace

"""
    repmi

!!! warning "Deprecated"
    Use `replace` instead.
"""
repmi

@deprecate repmot replace

"""
    repmot

!!! warning "Deprecated"
    Use `replace` instead.
"""
repmot

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
    ccall((:rotate_c, libcspice), Cvoid, (SpiceDouble, SpiceInt, Ref{SpiceDouble}), angle, iaxis, r)
    permutedims(r)
end

"""
    rotmat(m1, angle, iaxis)

Applies a rotation of `angle` radians about axis `iaxis` to a matrix `m1`. This rotation is thought
of as rotating the coordinate system.

### Arguments ###

- `m1`: Matrix to be rotated
- `angle`: Angle of rotation (radians)
- `iaxis`: Axis of rotation (X=1, Y=2, Z=3)

### Output ###

Returns the resulting rotated matrix.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/rotmat_c.html)
"""
function rotmat(m1, angle, iaxis)
    @checkdims 3 3 m1
    mout = Array{SpiceDouble}(undef, 3, 3)
    ccall((:rotmat_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, SpiceInt, Ref{SpiceDouble}),
          permutedims(m1), angle, iaxis, mout)
    permutedims(mout)
end

"""
    rotvec(v1, angle, iaxis)

Transform a vector to a new coordinate system rotated by `angle` radians about axis `iaxis`.
This transformation rotates `v1` by `-angle` radians about the specified axis.

### Arguments ###

- `v1`: Vector whose coordinate system is to be rotated
- `angle`: Angle of rotation in radians
- `iaxis`: Axis of rotation (X=1, Y=2, Z=3)

### Output ###

Returns the resulting vector expressed in the new coordinate system.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/rotvec_c.html)
"""
function rotvec(v1, angle, iaxis)
    @checkdims 3 v1
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:rotvec_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, SpiceInt, Ref{SpiceDouble}),
          v1, angle, iaxis, vout)
    vout
end

function _rpd()
    ccall((:rpd_c, libcspice), SpiceDouble, ())
end

@deprecate rpd() deg2rad(1.0)

"""
    rpd()

!!! warning "Deprecated"
    Use `deg2rad` instead.
"""
rpd

"""
    rquad(a, b, c)

Find the roots of a quadratic equation.

### Arguments ###

- `a`: Coefficient of quadratic term
- `b`: Coefficient of linear term
- `c`: Constant

### Output ###

- `root1`: Root built from positive discriminant term
- `root2`: Root built from negative discriminant term

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/rquad_c.html)
"""
function rquad(a, b, c)
    root1 = Array{SpiceDouble}(undef, 2)
    root2 = Array{SpiceDouble}(undef, 2)
    ccall((:rquad_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}, Ref{SpiceDouble}),
          a, b, c, root1, root2)
    handleerror()
    root1, root2
end

