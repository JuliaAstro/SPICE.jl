export eul2m

"""
    eul2m(angle3, angle2, angle1, axis3, axis2, axis1)

Construct a rotation matrix from a set of Euler angles.

### Arguments ###

- `angle3`, `angle2`, `angle1`: Rotation angles about third, second, and first rotation axes (radians)
- `axis3`, `axis2`, `axis1`: Axis numbers of third, second, and first rotation axes

### Output ###

A rotation matrix corresponding to the product of the 3 rotations.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eul2m_c.html)
"""
function eul2m(angle3, angle2, angle1, axis3, axis2, axis1)
    r = Matrix{SpiceDouble}(undef, 3, 3)
    ccall((:eul2m_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt, SpiceInt, SpiceInt, Ptr{SpiceDouble}),
          angle3, angle2, angle1, axis3, axis2, axis1, r)
    handleerror()
    permutedims(r)

end