export
    axisar,
    azlcpo,
    azlrec

"""
    axisar(axis, angle)

Construct a rotation matrix that rotates vectors by a specified `angle` about a specified `axis`.

### Arguments ###

- `axis`: Rotation axis
- `angle`: Rotation angle in radians

### Output ###

Rotation matrix corresponding to `axis` and `angle`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/axisar_c.html)
"""
function axisar(axis, angle)
    @checkdims 3 axis
    r = Matrix{Float64}(undef, 3,3)
    ccall((:axisar_c, libcspice), Cvoid, (Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}), axis, angle, r)
    permutedims(r)
end

"""
    azlcpo(method, target, et, abcorr, azccw, elplsz, obspos, obsctr, obsref)

Return the azimuth/elevation coordinates of a specified target relative to an "observer," 
where the observer has constant position in a specified reference frame. 
The observer's position is provided by the calling program rather than by loaded SPK files.

### Arguments ###

- `method`: Method to obtain the surface normal vector. The only choice currently supported is `"ELLIPSOID"`
- `target`: Name of target ephemeris object
- `et`: Observation epoch
- `abcorr`: Aberration correction
- `azccw`: Flag indicating how azimuth is measured. If `true`, the azimuth increases in the counterclockwise direction; otherwise it increases in the clockwise direction
- `elplsz`: Flag indicating how elevation is measured. If `true`, the elevation increases from the XY plane toward +Z; otherwise toward -Z
- `obspos`: Observer position relative to center of motion
- `obsctr`: Center of motion of observer
- `obsref`: Body-fixed, body-centered frame of observer's center

### Output ###

- `azlsta`: State of target with respect to observer, in azimuth/elevation coordinates: `azlsta = [r, az, el, dr/dt, daz/dt, del/dt]`
- `lt`: One-way light time between target and observer

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/azlcpo_c.html)
"""
function azlcpo(method, target, et, abcorr, azccw, elplsz, obspos, obsctr, obsref)
    @checkdims 3 obspos
    azlsta = Array{SpiceDouble}(undef, 6)
    lt = Ref{SpiceDouble}()
    ccall((:azlcpo_c, libcspice), Cvoid, (Cstring, Cstring, SpiceDouble, Cstring, SpiceBoolean, SpiceBoolean, Ref{SpiceDouble}, Cstring, Cstring, Ref{SpiceDouble}, Ref{SpiceDouble}), 
        method, target, et, abcorr, azccw, elplsz, obspos, obsctr, obsref, azlsta, lt)
    azlsta, lt[]
end

"""
    azlrec(range, az, el, azccw, elplsz)

Convert from range, azimuth and elevation of a point to rectangular coordinates.

### Arguments ###

- `range`: Distance of the point from the origin
- `az`: Azimuth in radians
- `el`: Elevation in radians
- `azccw`: Flag indicating how azimuth is measured. If `true`, the azimuth increases in the counterclockwise direction; otherwise it increases in the clockwise direction
- `elplsz`: Flag indicating how elevation is measured. If `true`, the elevation increases from the XY plane toward +Z; otherwise toward -Z

### Output ###

- `rectan`: Rectangular coordinates of the point

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/azlrec_c.html)
"""
function azlrec(range, az, el, azccw, elplsz)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:azlrec_c, libcspice), Cvoid, (SpiceDouble, SpiceDouble, SpiceDouble, SpiceBoolean, SpiceBoolean, Ref{SpiceDouble}), 
        range, az, el, azccw, elplsz, rectan)
    rectan
end
