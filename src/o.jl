export oscelt

"""
    oscelt(state, et, mu)

Determine the set of osculating conic orbital elements that corresponds to
the state (position, velocity) of a body at some epoch.

### Arguments ###

- `state`: State of body at epoch of elements
- `et`: Epoch of elements
- `mu`: Gravitational parameter (GM) of primary body

### Output ###

Returns the equivalent conic elements.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/oscelt_c.html)
"""
function oscelt(state, et, mu)
    elts = Array{SpiceDouble}(undef, 8)
    ccall((:oscelt_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceDouble, SpiceDouble, Ptr{SpiceDouble}),
          state, et, mu, elts)
    handleerror()
    elts
end
