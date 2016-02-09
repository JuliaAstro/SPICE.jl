# SPICE.jl

[![Build Status](https://travis-ci.org/helgee/SPICE.jl.svg?branch=master)](https://travis-ci.org/helgee/SPICE.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/ty9j5n61bghu5y5p?svg=true)](https://ci.appveyor.com/project/helgee/spice-jl)

## Installation

On Linux and OSX CMake and a C compiler are needed.

```julia
Pkg.clone("https://github.com/helgee/SPICE.jl.git")
# Pkg.add("SPICE")
```

## Roadmap

* [X] Julia-native error handling
* [ ] Wrap the most used [CSPICE APIs](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/info/mostused.html) 
* [ ] Provide julian APIs
