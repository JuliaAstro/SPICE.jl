# SPICE.jl

**SPICE.jl** is a Julia wrapper for the [SPICE toolkit](https://naif.jpl.nasa.gov/naif/index.html) which is provided by NASA's Navigation and Ancillary Information Facility (NAIF).
It provides functionality to read SPICE data files and compute derived observation geometry such as altitude, latitude/longitude and lighting angles.
Please refer to its comprehensive [documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/index.html) if you are not yet familiar with SPICE.

**Note:** This project is *not* affiliated with NASA, NAIF or JPL in any way.

## Installation

```julia
julia> import Pkg; Pkg.add("SPICE")
```

## Quickstart

```julia
# Download SPICE kernels from https://naif.jpl.nasa.gov/pub/naif/generic_kernels/

using SPICE

# Load leap seconds kernel
furnsh("naif0012.tls")

# Convert the calendar date to ephemeris seconds past J2000
et = utc2et("2018-02-06T20:45:00")

# Load a planetary ephemeris kernel
furnsh("de430.bsp")

# Get the position of Mars at `et` w.r.t. Earth
spkpos("mars_barycenter", et, "J2000", "none", "earth")
```

## Notable differences to CSPICE

SPICE.jl follows the Julia language's style and conventions which introduces the following differences to CSPICE.

- SPICE.jl does not wrap all CSPICE functions since many general purpose utilities already exist in Julia's standard library or can be approximated with a Julia one-liner.  If you try to call an unwrapped function, SPICE.jl will return a deprecation warning that shows the equivalent Julia code.
- Functions that mutate one of their input arguments are suffixed with `!` and the to-be-mutated argument will be the first parameter, e.g. `wninsd!(window, left, right)` instead of `wninsd(left, right, window)`.

## Next Steps

Please refer to the [API](@ref) reference.
