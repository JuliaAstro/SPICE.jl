using Documenter, SPICE

makedocs(
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
    ),
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
)
