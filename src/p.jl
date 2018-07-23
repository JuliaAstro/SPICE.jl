export pxform,
    pdpool

"""
Return the matrix that transforms position vectors from one specified frame to another at a specified epoch.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pxform_c.html
"""
function pxform(from::String, to::String, et::Float64)
    rot = Array{Cdouble}(undef, 3, 3)
    ccall((:pxform_c, libcspice), Cvoid, (Cstring, Cstring, Cdouble, Ptr{Cdouble}), from, to, et, rot)
    handleerror()
    return rot
end

"""
    pdpool(name, vals)

Insert double precision data into the kernel pool.

### Arguments ###

- `name`: The kernel pool name to associate with `vals`
- `vals`: An array of values to insert into the kernel pool

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pdpool_c.html)
"""
function pdpool(name, vals)
    n = length(vals)
    ccall((:pdpool_c, libcspice), Cvoid, (Cstring, SpiceInt, Ptr{SpiceDouble}), name, n, vals)
    handleerror()
end
