# SPICEApplications.jl

!!! note
    The `SPICEApplications` module is not included within `SPICE`. To access
    the functions documented on this page, install `SPICEApplications` using
    Julia's package manager: `Pkg.install("SPICEApplications")`.

The JPL SPICE Toolkit provides executables for interacting with SPICE kernels, such as
`mkspk`, `brief`, and others. `SPICEApplications.jl` provides idiomatic Julia
interfaces to these executables, which themselves are packaged by `CSPICE_jll.jl`.

## Usage

Each executable can be called through its corresponding function without
arguments, or programatically using function arguments. For example, the SPICE
Toolkit's `BRIEF` program prints the description of a provided kernel. When the
`brief` executable is called without arguments, it prints its "help" text; this
can be replicated by calling `SPICEApplications.brief()` without arguments.
Alternatively, you can pass the kernel that you want to inspect as a positional
argument: `brief(kernel_file)`.

All SPICE Toolkit executables are documented within the [SPICE Toolkit Documentation](https://naif.jpl.nasa.gov/naif/utilities.html).

```@repl
using SPICEApplications

kernel = download("https://naif.jpl.nasa.gov/pub/naif/CASSINI/kernels/spk/000202R_SK_V1P32_V2P12.bsp")

brief(kernel);
```

## Example

For a concrete usage example, see how `SPICEApplications` is used to 
[generate](https://github.com/cadojo/SPICEKernels.jl/blob/main/gen/make.jl) 
docstrings for [`SPICEKernels.jl`](https://github.com/cadojo/SPICEKernels.jl).

## Reference

```@autodocs
Modules = [SPICEApplications]
Order = [:module, :type, :function, :constant]
```