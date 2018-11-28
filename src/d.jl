export
    dtpool

"""
    dtpool(name)
    
Return the data about a kernel pool variable. 
 
### Arguments ###

- `name`: Name of the variable whose value is to be returned

### Output ###

Returns the tuple `(n ,vartype)`.

- `n`: Number of values returned for name
- `vartype`: Type of the variable:  'C', 'N', or 'X' 

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dtpool_c.html)
"""
function dtpool(name)
    found = Ref{SpiceBoolean}()
    n = Ref{SpiceInt}()
    vartype = Array{UInt8}(undef, 1)
    ccall((:dtpool_c, libcspice), Cvoid, (Cstring, Ref{SpiceBoolean}, Ref{SpiceInt}, Ptr{UInt8}), 
          name, found, n, vartype)
    handleerror() 
    n[], unsafe_string(pointer(vartype))
end


