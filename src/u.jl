import LinearAlgebra

export ucase,
    ucrss,
    unload

function _ucase(in)
    n = length(in) + 1
    out = Array{UInt8}(undef, n)
    ccall((:ucase_c, libcspice), Cvoid, (Cstring, SpiceInt, Ptr{UInt8}),
          in, n, out)
    unsafe_string(pointer(out))
end

"""
    ucase(in)

**Deprecated:** Use `uppercase(in)` instead.
"""
ucase

@deprecate ucase uppercase

function _ucrss(v1, v2)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:ucrss_c ,libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          v1, v2, vout)
    vout
end

"""
    ucrss(v1, v2)

**Deprecated:** Use `LinearAlgebra.normalize(LinearAlgebra.cross(v1, v2))` instead.
"""
ucrss

@deprecate ucrss(v1, v2) LinearAlgebra.normalize(LinearAlgebra.cross(v1, v2))

function unload(kernel)
    ccall((:unload_c, libcspice), Cvoid, (Cstring,), kernel)
    handleerror()
end
