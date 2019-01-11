export halfpi, hx2dp

function _halfpi()
    ccall((:halfpi_c, libcspice), SpiceDouble, ())
end

"""
    halfpi()

!!! warning "Deprecated"
    Use `π/2` instead.
"""
halfpi

@deprecate halfpi() π/2

"""
    hx2dp(str)

Convert a string representing a double precision number in a
base 16 "scientific notation" into its equivalent double
precision number.

### Arguments ###

- `str`: Hex form string to convert to double precision

### Output ###

- `dp`: Double precision value to be returned

### References ###
- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/hx2dp_c.html)
"""
function hx2dp(str)
    dp = Ref{SpiceDouble}()
    error = Ref{SpiceBoolean}()
    errmsg = Array{UInt8}(undef, 46)
    ccall((:hx2dp_c, libcspice), Cvoid,
        (Cstring, SpiceInt, Ref{SpiceDouble}, Ref{SpiceBoolean}, Ptr{UInt8}),
        str, 46, dp, error, errmsg
    )
    error[] == 1 && throw(SpiceError(unsafe_string(pointer(errmsg))))
    dp[]
end
