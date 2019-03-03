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
    length(axis) != 3 && throw(ArgumentError("`axis` must have three elements."))
    r = Matrix{Float64}(undef, 3,3)
    ccall((:axisar_c, libcspice), Cvoid, (Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble}), axis, angle, r)
    permutedims(r)
end
