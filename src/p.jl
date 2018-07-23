export pxform

"""
Return the matrix that transforms position vectors from one specified frame to another at a specified epoch.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pxform_c.html
"""
function pxform(from::String, to::String, et::Float64)
    rot = Array{Cdouble}(3, 3)
    ccall((:pxform_c, libcspice), Cvoid, (Cstring, Cstring, Cdouble, Ptr{Cdouble}), from, to, et, rot)
    handleerror()
    return rot
end
