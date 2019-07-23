export
    occult,
    ordc,
    ordd,
    ordi,
    orderc,
    orderd,
    orderi,
    oscelt,
    oscltx

"""
    occult(targ1, shape1, frame1, targ2, shape2, frame2, abcorr, obsrvr, et)

Determines the occultation condition (not occulted, partially, etc.) of one target relative to
another target as seen by an observer at a given time.

The surfaces of the target bodies may be represented by triaxial ellipsoids or by topographic data
provided by DSK files.

### Arguments ###

- `targ1`: Name or ID of first target.
- `shape1`: Type of shape model used for first target.
- `frame1`: Body-fixed, body-centered frame for first body.
- `targ2`: Name or ID of second target.
- `shape2`: Type of shape model used for second target.
- `frame2`: Body-fixed, body-centered frame for second body.
- `abcorr`: Aberration correction flag.
- `obsrvr`: Name or ID of the observer.
- `et`: Time of the observation (seconds past J2000).

### Output ###

Returns the occultation identification code.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/occult_c.html)
"""
function occult(targ1, shape1, frame1, targ2, shape2, frame2, abcorr, obsrvr, et)
    frame1 = isempty(frame1) ? " " : frame1
    frame2 = isempty(frame2) ? " " : frame2
    ocltid = Ref{SpiceInt}()
    ccall((:occult_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, SpiceDouble,
           Ref{SpiceInt}),
          targ1, shape1, frame1, targ2, shape2, frame2, abcorr, obsrvr, et, ocltid)
    handleerror()
    Int(ocltid[])
end

"""
    ordc(set, item)

The function returns the ordinal position of any given item in a character set.

### Arguments ###

- `set`: A set to search for a given item
- `item`: An item to locate within a set

### Output ###

Returns the ordinal position or `nothing` if the items does not appear in the set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ordc_c.html)
"""
function ordc(set, item)
    res = ccall((:ordc_c, libcspice), SpiceInt,
                (Cstring, Ref{Cell{SpiceChar}}),
                item, set.cell)
    handleerror()
    res == -1 ? nothing : res + 1
end

"""
    ordd(set, item)

The function returns the ordinal position of any given item in a character set.

### Arguments ###

- `set`: A set to search for a given item
- `item`: An item to locate within a set

### Output ###

Returns the ordinal position or `nothing` if the items does not appear in the set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ordd_c.html)
"""
function ordd(set, item)
    res = ccall((:ordd_c, libcspice), SpiceInt,
                (SpiceDouble, Ref{Cell{SpiceDouble}}),
                item, set.cell)
    handleerror()
    res == -1 ? nothing : res + 1
end

"""
    ordi(set, item)

The function returns the ordinal position of any given item in a character set.

### Arguments ###

- `set`: A set to search for a given item
- `item`: An item to locate within a set

### Output ###

Returns the ordinal position or `nothing` if the items does not appear in the set.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ordi_c.html)
"""
function ordi(set, item)
    res = ccall((:ordi_c, libcspice), SpiceInt,
                (SpiceInt, Ref{Cell{SpiceInt}}),
                item, set.cell)
    handleerror()
    res == -1 ? nothing : res + 1
end

function _orderc(array)
    array_, ndim, lenvals = chararray(array)
    iorder = Array{SpiceInt}(undef, ndim)
    ccall((:orderc_c, libcspice), Cvoid,
          (SpiceInt, Ref{SpiceChar}, SpiceInt, Ref{SpiceInt}),
          lenvals, array_, ndim, iorder)
    handleerror()
    Int.(iorder) .+ 1
end

@deprecate orderc sortperm

"""
    orderc(array)

!!! warning "Deprecated"
    Use `sortperm` instead.
"""
orderc

function _orderd(array)
    ndim = length(array)
    iorder = Array{SpiceInt}(undef, ndim)
    ccall((:orderd_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, Ref{SpiceInt}),
          array, ndim, iorder)
    handleerror()
    Int.(iorder) .+ 1
end

@deprecate orderd sortperm

"""
    orderd(array)

!!! warning "Deprecated"
    Use `sortperm` instead.
"""
orderd

function _orderi(array)
    array_ = SpiceInt.(array)
    ndim = length(array)
    iorder = Array{SpiceInt}(undef, ndim)
    ccall((:orderi_c, libcspice), Cvoid,
          (Ref{SpiceInt}, SpiceInt, Ref{SpiceInt}),
          array_, ndim, iorder)
    handleerror()
    Int.(iorder) .+ 1
end

@deprecate orderi sortperm

"""
    orderi(array)

!!! warning "Deprecated"
    Use `sortperm` instead.
"""
orderi

"""
    oscelt(state, et, mu)

Determine the set of osculating conic orbital elements that corresponds to
the state (position, velocity) of a body at some epoch.

### Arguments ###

- `state`: State of body at epoch of elements
- `et`: Epoch of elements
- `mu`: Gravitational parameter (GM) of primary body

### Output ###

Returns the equivalent conic elements:

- `rp`: Perifocal distance
- `ecc`: Eccentricity
- `inc`: Inclination
- `lnode`: Longitude of the ascending node
- `argp`: Argument of periapsis
- `m0`: Mean anomaly at epoch
- `t0`: Epoch
- `mu`: Gravitational parameter

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/oscelt_c.html)
"""
function oscelt(state, et, mu)
    @checkdims 6 state
    elts = Array{SpiceDouble}(undef, 8)
    ccall((:oscelt_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          state, et, mu, elts)
    handleerror()
    elts
end

"""
    oscltx(state, et, mu)

Determine the set of osculating conic orbital elements that corresponds to the state
(position, velocity) of a body at some epoch. In addition to the classical elements,
return the true anomaly, semi-major axis, and period, if applicable.

### Arguments ###

- `state`: State of body at epoch of elements
- `et`: Epoch of elements
- `mu`: Gravitational parameter (GM) of primary body

### Output ###

Returns the extended set of classical conic elements:

- `rp`: Perifocal distance.
- `ecc`: Eccentricity.
- `inc`: Inclination.
- `lnode`: Longitude of the ascending node.
- `argp`: Argument of periapsis.
- `m0`: Mean anomaly at epoch.
- `t0`: Epoch.
- `mu`: Gravitational parameter.
- `nu`: True anomaly at epoch.
- `a`: Semi-major axis. A is set to zero if it is not computable.
- `tau`: Orbital period. Applicable only for elliptical orbits. Set to zero otherwise.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/oscltx_c.html)
"""
function oscltx(state, et, mu)
    @checkdims 6 state
    elts = Array{SpiceDouble}(undef, 11)
    ccall((:oscltx_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          state, et, mu, elts)
    handleerror()
    elts
end

