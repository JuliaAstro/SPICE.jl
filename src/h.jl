export halfpi, hrmint, hx2dp

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
    hrmint(xvals, yvals, x)

Evaluate a Hermite interpolating polynomial at a specified abscissa value.

### Arguments ###

- `xvals`: Abscissa values
- `yvals`: Ordinate and derivative values
- `x`: Point at which to interpolate the polynomial

### Output ###

- `f`: Interpolated function value at `x`
- `df`: Interpolated function's derivative at `x`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/hrmint_c.html)
"""
function hrmint(xvals, yvals, x)
    n = length(xvals)
    @checkdims 2n yvals
    work = Array{SpiceDouble}(undef, 4n)
    f = Ref{SpiceDouble}()
    df = Ref{SpiceDouble}()
    ccall((:hrmint_c, libcspice), Cvoid,
          (SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}, SpiceDouble, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}),
          n, xvals, yvals, x, work, f, df)
    handleerror()
    f[], df[]
end

"""
    hx2dp(str)

Convert a string representing a double precision number in a base 16 "scientific notation"
into its equivalent double precision number.

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
    errmsg = Array{SpiceChar}(undef, 46)
    ccall((:hx2dp_c, libcspice), Cvoid,
        (Cstring, SpiceInt, Ref{SpiceDouble}, Ref{SpiceBoolean}, Ref{SpiceChar}),
        str, 46, dp, error, errmsg)
    if Bool(error[])
        throw(SpiceError(chararray_to_string(errmsg)))
    end
    dp[]
end
