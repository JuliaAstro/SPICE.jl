export rav2xf

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
          rot, av, xform)
    xform
end

