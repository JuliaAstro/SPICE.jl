export nvc2pl,
    nvp2pl

"""
    nvc2pl(norm, point)

Make a SPICE plane from a normal vector and a point.

### Arguments ###

- `norm`: A normal vector...
- `constant`: ...and a constant defining a plane

### Output ###

Returns a struct representing the plane.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/nvc2pl_c.html)
"""
function nvc2pl(normal, constant)
    plane = Ref{Plane}(Plane())
    ccall((:nvc2pl_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceDouble, Ref{Plane}), normal, constant, plane)
    handleerror()
    plane[]
end

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
