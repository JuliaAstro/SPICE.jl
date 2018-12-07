export
    kclear,
    ktotal

"""
    kclear()

Clear the KEEPER subsystem: unload all kernels, clear the kernel
pool, and re-initialize the subsystem. Existing watches on kernel
variables are retained.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kclear_c.html)
"""
function kclear()
    ccall((:kclear_c, libcspice), Cvoid, ())
    handleerror()
end

"""
    ktotal(kind) 

Return the current number of kernels that have been loaded 
via the KEEPER interface that are of a specified type. 

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ktotal_c.html)
"""
function ktotal(kind)
    count = Ref{SpiceInt}()
    ccall((:ktotal_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), string(kind), count)
    handleerror()
    Int(count[])
end 
