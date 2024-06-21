export
    axisar,
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
    azlrec(range, az, el, azccw, elplsz)

Convert from range, azimuth and elevation of a point to rectangular coordinates.

### Arguments ###

- `range`: Distance of the point from the origin
- `az`: Azimuth in radians
- `el`: Elevation in radians
- `azccw`: Flag indicating how azimuth is measured
- `elplsz`: Flag indicating how elevation is measured

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
