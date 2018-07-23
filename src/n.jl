export nvp2pl

"""
    nvp2pl(norm, point)

Make a SPICE plane from a normal vector and a point.

### Arguments ###

- `norm`: A normal vector...
- `point`: ...and a point defining a plane

### Output ###

Returns a struct representing the plane.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/nvp2pl_c.html)
"""
function nvp2pl(norm, orig)
    plane = Ref{Plane}(Plane())
    ccall((:nvp2pl_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ref{Plane}), norm, orig, plane)
    handleerror()
    plane[]
end
