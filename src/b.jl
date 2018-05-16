export b1900, b1950, badkpv, bltfrm, bodc2n, bodc2s, boddef, bodfnd, bodn2c, bods2c, bodvcd, bodvrd

"""
    b1900()

Returns the Julian Date corresponding to Besselian date 1900.0.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/b1900_c.html)
"""
function b1900()
    ccall((:b1900_c, libcspice), SpiceDouble, ())
end

"""
    b1950()

Returns the Julian Date corresponding to Besselian date 1950.0.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/b1950_c.html)
"""
function b1950()
    ccall((:b1950_c, libcspice), SpiceDouble, ())
end

"""
    badkpv(caller, name, comp, size, divby, typ)

Determine if a kernel pool variable is present and if so that it has the correct size and type.

### Arguments ###

- `caller`: Name of the routine calling this routine
- `name`: Name of a kernel pool variable
- `comp`: Comparison operator
- `size`: Expected size of the kernel pool variable
- `divby`: A divisor of the size of the kernel pool variable
- `type`: Expected type of the kernel pool variable

### Output ###

The function returns `false` if the kernel pool variable is OK otherwise an exception is thrown.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/badkpv_c.html)
"""
function badkpv(caller, name, comp, size, divby, typ)
    res = ccall((:badkpv_c, libcspice), SpiceBoolean,
                (Cstring, Cstring, Cstring, SpiceInt, SpiceInt, SpiceChar),
                caller, name, comp, size, divby, first(typ))
    handleerror()
    res == 1
end

"""
    bltfrm(frmcls)

Return a SPICE set containing the frame IDs of all built-in frames of a specified class.

### Arguments ###

- `frmcls`: Frame class

### Output ###

- `idset`: Set of ID codes of frames of the specified class

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bltfrm_c.html)
"""
function bltfrm(frmcls)
    idset = SpiceIntCell(256)
    ccall((:bltfrm_c, libcspice), Void, (SpiceInt, Ref{Cell{SpiceInt}}), frmcls, Ref(idset.cell))
    idset
end

"""
    bodc2n(code)

Translate the SPICE integer code of a body into a common name for that body.

### Arguments ###

- `code`: Integer ID code to be translated into a name

### Output ###

- `name`: A common name for the body identified by code

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodc2n_c.html)
"""
function bodc2n(code)
    len = 36
    name = Array{UInt8}(len)
    found = Ref{SpiceBoolean}()
    ccall((:bodc2n_c, libcspice), Void, (SpiceInt, SpiceInt, Ptr{UInt8}, Ref{SpiceBoolean}),
          code, 36, name, found)
    found[] == 0 && throw(SpiceException("No body with code $code found."))
    unsafe_string(pointer(name))
end

"""
    bodc2s(code)

Translate a body ID code to either the corresponding name or if no name to ID code mapping exists,
the string representation of the body ID value.

### Arguments ###

- `code`: Integer ID code to translate to a string

### Output ###

- `name`: String corresponding to `code`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodc2n_c.html)
"""
function bodc2s(code)
    len = 36
    name = Array{UInt8}(len)
    ccall((:bodc2s_c, libcspice), Void, (SpiceInt, SpiceInt, Ptr{UInt8}),
          code, 36, name)
    unsafe_string(pointer(name))
end

"""
    boddef(name, code)

Define a body name/ID code pair for later translation via [`bodn2c`](@ref) or [`bodc2n`](@ref).

### Arguments ###

- `name`: Common name of some body
- `code`: Integer code for that body

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/boddef_c.html)
"""
function boddef(name, code)
    length(name) > 35 && throw(SpiceException("The maximum allowed length for a name is 35 characters."))
    ccall((:boddef_c, libcspice), Void, (Cstring, SpiceInt), name, code)
end

"""
    bodfnd(body, item)

Determine whether values exist for some item for any body in the kernel pool.

### Arguments ###

- `body`: ID code of body
- `item`: Item to find ("RADII", "NUT_AMP_RA", etc.)

### Output ###

- `found`: `true` if the item is in the kernel pool and `false` if it is not.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodfnd_c.html)
"""
function bodfnd(body, item)
    res = ccall((:bodfnd_c, libcspice), SpiceBoolean, (SpiceInt, Cstring), body, item)
    res == 1
end

"""
    bodn2c(name)

Translate the name of a body or object to the corresponding SPICE integer ID code.

### Arguments ###

- `name`: Body name to be translated into a SPICE ID code

### Output ###

- `code`: SPICE integer ID code for the named body

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodn2c_c.html)
"""
function bodn2c(name)
    code = Ref{SpiceInt}()
    found = Ref{SpiceBoolean}()
    ccall((:bodn2c_c, libcspice), Void, (Cstring, Ref{SpiceInt}, Ref{SpiceBoolean}),
          name, code, found)
    found[] == 0 && throw(SpiceException("No body with name '$name' found."))
    Int(code[])
end

"""
    bods2c(name)

Translate a string containing a body name or ID code to an integer code.

### Arguments ###

- `name`: String to be translated to an ID code

### Output ###

- `code`: Integer ID code corresponding to `name`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bods2c_c.html)
"""
function bods2c(name)
    code = Ref{SpiceInt}()
    found = Ref{SpiceBoolean}()
    ccall((:bods2c_c, libcspice), Void, (Cstring, Ref{SpiceInt}, Ref{SpiceBoolean}),
          name, code, found)
    found[] == 0 && throw(SpiceException("Neither a body with name '$name' found nor is it an integer."))
    Int(code[])
end

"""
    bodvcd(bodyid, item)

Fetch from the kernel pool the double precision values of an item associated with a body, where the body
is specified by an integer ID code.

### Arguments ###

- `bodyid`: Body ID code
- `item`: Item for which values are desired. ("RADII", "NUT_PREC_ANGLES", etc.)

### Output ###

- `values`: Values

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodvcd_c.html)
"""
function bodvcd(bodyid, item)
    maxn = 100
    values = Array{SpiceDouble}(maxn)
    dim = Ref{SpiceInt}()
    ccall((:bodvcd_c, libcspice), Void, (SpiceInt, Cstring, SpiceInt, Ref{SpiceInt}, Ptr{SpiceDouble}),
          bodyid, item, maxn, dim, values)
    handleerror()
    values[1:dim[]]
end

"""
    bodvrd(bodynm, item)

Fetch from the kernel pool the double precision values of an item associated with a body.

### Arguments ###

- `bodynm`: Body name
- `item`: Item for which values are desired. ("RADII", "NUT_PREC_ANGLES", etc.)
- `maxn`: Maximum number of values that may be returned. 

### Output ###

- `values`: Values

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/bodvrd_c.html)
"""
function bodvrd(bodynm, item, maxn = 100)
    values = Array{SpiceDouble}(maxn)
    dim = Ref{SpiceInt}()
    ccall((:bodvrd_c, libcspice), Void, (Cstring, Cstring, SpiceInt, Ref{SpiceInt}, Ptr{SpiceDouble}),
          bodynm, item, maxn, dim, values)
    handleerror()
    values[1:dim[]]
end
