[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliaastro.github.io/SPICE.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliaastro.github.io/SPICE.jl/dev)

# `SPICEApplications`

_Generate ephemeris kernel files using NASA JPL's `SPICEApplications` program,
all from within Julia!_

## Installation

Choose one of the following two lines!

```julia
import Pkg; Pkg.add("SPICEApplications");
```

```julia
]add SPICEApplications # in Julia's REPL
```

## Documentation

The documentation for `SPICEApplications.jl` is hosted within the `SPICE.jl`
[documentation](http://juliaastro.org/SPICE.jl/stable/executables).

## Credits

NASA JPL developed and maintains the
[NAIF SPICE Toolkit](https://naif.jpl.nasa.gov/naif/toolkit.html), including
`SPICEApplications`. Helge Eichhorn developed and maintains
[`SPICE.jl`](https://github.com/JuliaAstro/SPICE.jl), as well as the
[Julia wrappers](https://juliahub.com/ui/Packages/CSPICE_jll/XJqVo/67.0.0+0)
around the SPICE Toolkit.
