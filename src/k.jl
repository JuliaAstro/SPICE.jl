export kclear

"""
    kclear()

Clear the KEEPER subsystem: unload all kernels, clear the kernel
pool, and re-initialize the subsystem. Existing watches on kernel
variables are retained.

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kclear_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kclear_c.html)
"""
function kclear()
    ccall((:kclear_c, libcspice), Void, ())
    handleerror()
end