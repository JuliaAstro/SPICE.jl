import LinearAlgebra

export ucase,
    ucrss,
    uddf,
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

"""
    uddf(udfunc, x, dx)

Routine to calculate the first derivative of a caller-specified function using
a three-point estimation.

### Arguments ###

- `udfunc`: A callable that computes the scalar value of interest,
    e.g. `f(x::Float64) -> Float64`.
- `x`: Independent variable of 'udfunc'
- `dx`: Interval from `x` for derivative calculation

### Output ###

Returns the approximate derivative of `udfunc` at `x`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/uddf_c.html)
"""
function uddf(udfunc, x, dx)
    function _udfunc(et::SpiceDouble, value::Ptr{SpiceDouble})
        value = unsafe_wrap(Array, value, 1)
        value[1] = udfunc(et)
        nothing
    end
    func = @cfunction($_udfunc, Cvoid, (SpiceDouble, Ptr{SpiceDouble}))
    deriv = Ref{SpiceDouble}()
    ccall((:uddf_c, libcspice), Cvoid,
          (Ptr{Cvoid}, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          func, x, dx, deriv)
    deriv[]
end

function unload(kernel)
    ccall((:unload_c, libcspice), Cvoid, (Cstring,), kernel)
    handleerror()
end
