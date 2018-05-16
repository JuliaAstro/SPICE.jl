export axisar

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
    r = Matrix{Float64}(3,3)
    ccall((:axisar_c, libcspice), Void, (Ptr{SpiceDouble}, SpiceDouble, Ptr{SpiceDouble}), axis, angle, r)
    return r'
end