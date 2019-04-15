import LinearAlgebra

export ucase,
    ucrss,
    uddf,
    union,
    unitim,
    unload,
    unorm,
    unormg,
    utc2et

function _ucase(in)
    n = length(in) + 1
    out = Array{SpiceChar}(undef, n)
    ccall((:ucase_c, libcspice), Cvoid, (Cstring, SpiceInt, Ref{SpiceChar}),
          in, n, out)
    chararray_to_string(out)
end

"""
    ucase(in)

!!! warning "Deprecated"
    Use `uppercase(in)` instead.
"""
ucase

@deprecate ucase uppercase

function _ucrss(v1, v2)
    vout = Array{SpiceDouble}(undef, 3)
    ccall((:ucrss_c ,libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v1, v2, vout)
    vout
end

"""
    ucrss(v1, v2)

!!! warning "Deprecated"
    Use `LinearAlgebra.normalize(LinearAlgebra.cross(v1, v2))` instead.
"""
ucrss

@deprecate ucrss(v1, v2) LinearAlgebra.normalize(LinearAlgebra.cross(v1, v2))

"""
    uddf(udfunc, x, dx)

Routine to calculate the first derivative of a caller-specified function using
a three-point estimation.

### Arguments ###

- `udfunc`: A callable that computes the scalar value of interest,
    e.g. `f(x::Float64) -> Float64`
- `x`: Independent variable of `udfunc`
- `dx`: Interval from `x` for derivative calculation

### Output ###

Returns the approximate derivative of `udfunc` at `x`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/uddf_c.html)
"""
function uddf(udfunc, x, dx)
    function _udfunc(et::SpiceDouble, value::Ptr{SpiceDouble})
        value_ = GC.@preserve value unsafe_wrap(Array{SpiceDouble}, value, 1)
        value_[1] = udfunc(et)
        nothing
    end
    func = @cfunction($_udfunc, Cvoid, (SpiceDouble, Ptr{SpiceDouble}))
    deriv = Ref{SpiceDouble}()
    ccall((:uddf_c, libcspice), Cvoid,
          (Ref{Cvoid}, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          func, x, dx, deriv)
    deriv[]
end

"""
    union(a::T, b::T) where T <: SpiceCell

Compute the union of two sets of any data type to form a third set.

### Arguments ###

- `a`: First input set
- `b`: Second input set

### Output ###

Returns a cell containing the union of `a` and `b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/union_c.html)
"""
function Base.union(a::SpiceCell{T}, b::SpiceCell{T}) where T
    size = max(a.cell.size, b.cell.size)
    if T <: SpiceChar
        length = max(a.cell.length, b.cell.length)
        out = SpiceCell{T}(size, length)
    else
        out = SpiceCell{T}(size)
    end
    ccall((:union_c, libcspice), Cvoid, (Ref{Cell{T}}, Ref{Cell{T}}, Ref{Cell{T}}),
          a.cell, b.cell, out.cell)
    handleerror()
    out
end

"""
    unitim(epoch, insys, outsys)

Transform time from one uniform scale to another.

### Arguments ###

- `epoch`: An epoch to be converted
- `insys`: The time scale associated with the input epoch
- `outsys`: The time scale associated with the function value

The uniform time scales are:

- `:TAI`
- `:TDT`
- `:TDB`
- `:ET`
- `:JED`
- `:JDTDB`
- `:JDTDT`

### Output ###

Returns the time in the system specified by `outsys` that is equivalent to the
`epoch` in the `insys` time scale.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/unitim_c.html)
"""
function unitim(epoch, insys, outsys)
    out = ccall((:unitim_c, libcspice), SpiceDouble,
                (SpiceDouble, Cstring, Cstring),
                epoch, string(insys), string(outsys))
    handleerror()
    out
end

"""
    unload(file)

Unload a SPICE kernel.

### Arguments ###

- `file`: The file name of a kernel to unload

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/unload_c.html)
"""
function unload(file)
    ccall((:unload_c, libcspice), Cvoid, (Cstring,), file)
    handleerror()
end

function _unorm(v1)
    vout = Array{SpiceDouble}(undef, 3)
    vmag = Ref{SpiceDouble}()
    ccall((:unorm_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v1, vout, vmag)
    vout, vmag[]
end

"""
    unorm(v1)

!!! warning "Deprecated"
    Use `(LinearAlgebra.normalize(v1), LinearAlgebra.norm(v1))` instead.
"""
unorm

@deprecate unorm(v) (normalize(v), norm(v))

function _unormg(v1)
    ndim = length(v1)
    vout = Array{SpiceDouble}(undef, ndim)
    vmag = Ref{SpiceDouble}()
    ccall((:unormg_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}),
          v1, ndim, vout, vmag)
    vout, vmag[]
end

"""
    unormg(v1)

!!! warning "Deprecated"
    Use `(LinearAlgebra.normalize(v1), LinearAlgebra.norm(v1))` instead.
"""
unormg

@deprecate unormg(v) (normalize(v), norm(v))

"""
    utc2et(utcstr)

Convert an input time from Calendar or Julian Date format, UTC, to ephemeris
seconds past J2000.

### Arguments ###

- `utcstr`: Input time string, UTC

### Output ###

Returns the equivalent of utcstr, expressed in ephemeris seconds past J2000.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/utc2et_c.html)
"""
function utc2et(utcstr)
    et = Ref{SpiceDouble}()
    ccall((:utc2et_c, libcspice), Cvoid, (Cstring, Ref{SpiceDouble}),
          string(utcstr), et)
    handleerror()
    et[]
end

