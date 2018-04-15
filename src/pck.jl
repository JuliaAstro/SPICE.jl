export bodfnd, bodvrd, pxform, sxform

"""
Determine whether values exist for some item for any body in the kernel pool.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodfnd_c.html
"""
function bodfnd(id::Int, item::String)
    ccall((:bodfnd_c, libcspice), Bool, (Cint, Cstring), id, item)
end

"""
Fetch from the kernel pool the double precision values of an item associated with a body.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodvrd_c.html
"""
function bodvrd(bodynm::String, item::String, maxn::Int)
    values = Array{Cdouble}(maxn)
    dim = Ref{Cint}(0)
    ccall((:bodvrd_c, libcspice), Void, (Cstring, Cstring, Cint, Ref{Cint}, Ptr{Float64}), bodynm, item, maxn, dim, values)
    handleerror()
    return values
end

"""
Return the matrix that transforms position vectors from one specified frame to another at a specified epoch.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pxform_c.html
"""
function pxform(from::String, to::String, et::Float64)
    rot = Array{Cdouble}(3, 3)
    ccall((:pxform_c, libcspice), Void, (Cstring, Cstring, Cdouble, Ptr{Cdouble}), from, to, et, rot)
    handleerror()
    return rot
end

"""
Return the state transformation matrix from one frame to another at a specified epoch.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/sxform_c.html
"""
function sxform(from::String, to::String, et::Float64)
    rot = Array{Cdouble}(6, 6)
    ccall((:sxform_c, libcspice), Void, (Cstring, Cstring, Cdouble, Ptr{Cdouble}), from, to, et, rot)
    handleerror()
    return rot
end
