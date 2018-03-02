using Documenter, SPICE

makedocs(
    format = :html,
    sitename = "SPICE.jl",
    authors = "Helge Eichhorn",
    pages = [
        "Home" => "index.md",
        "API" => "api.md",
    ],
    doctest = false,
)

deploydocs(
    repo = "github.com/JuliaAstro/SPICE.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
    julia = "0.6",
)
