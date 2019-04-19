# SPICE.jl

*Julia wrapper for NASA NAIF's SPICE toolkit*

[![Build Status Unix][travis-badge]][travis-url] [![Build Status Windows][av-badge]][av-url] [![Build Status FreeBSD][cirrus-badge]][cirrus-url] [![Coveralls][coveralls-badge]][coveralls-url] [![Codecov][codecov-badge]][codecov-url] [![Docs Stable][docs-badge-stable]][docs-url-stable] [![Docs Latest][docs-badge-dev]][docs-url-dev]

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

## Citing

If you publish work that uses SPICE.jl, please cite the underlying SPICE toolkit. The citation information can be found [here](https://github.com/JuliaAstro/SPICE.jl/blob/master/CITATION.md).

## Documentation

Please refer to the [documentation][docs-url-stable] for additional information.

## Acknowledgements

SPICE.jl's test suite is based on the unit tests for the Python wrapper [SpiceyPy](https://github.com/AndrewAnnex/SpiceyPy) by Andrew Annex.

[travis-badge]: https://travis-ci.org/JuliaAstro/SPICE.jl.svg?branch=master
[travis-url]: https://travis-ci.org/JuliaAstro/SPICE.jl
[av-badge]: https://ci.appveyor.com/api/projects/status/rv89bw5tl1bfqo7h?svg=true
[av-url]: https://ci.appveyor.com/project/helgee/spice-jl
[cirrus-badge]: https://api.cirrus-ci.com/github/JuliaAstro/SPICE.jl.svg
[cirrus-url]: https://cirrus-ci.com/github/JuliaAstro/SPICE.jl
[coveralls-badge]: https://coveralls.io/repos/github/JuliaAstro/SPICE.jl/badge.svg?branch=master
[coveralls-url]: https://coveralls.io/github/JuliaAstro/SPICE.jl?branch=master
[codecov-badge]: http://codecov.io/github/JuliaAstro/SPICE.jl/coverage.svg?branch=master
[codecov-url]: http://codecov.io/github/JuliaAstro/SPICE.jl?branch=master
[docs-badge-dev]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-url-dev]: https://juliaastro.github.io/SPICE.jl/dev/
[docs-badge-stable]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-url-stable]: https://juliaastro.github.io/SPICE.jl/stable/
