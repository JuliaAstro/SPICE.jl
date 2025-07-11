using SPICE
using SPICEApplications
using Documenter
using Documenter.Remotes: GitHub
using DocumenterInterLinks

links = InterLinks(
    "Julia" => "https://docs.julialang.org/en/v1/",
)

makedocs(
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        size_threshold = 800*1024,
        canonical="https://juliaastro.org/SPICE/stable/",
    ),
    repo = GitHub("JuliaAstro/SPICE.jl"),
    sitename = "SPICE.jl",
    authors = "Helge Eichhorn",
    pages = [
        "Home" => "index.md",
        "API" => "api.md",
        "Executables" => "executables.md"
    ],
    plugins = [links],
)

deploydocs(
    repo = "github.com/JuliaAstro/SPICE.jl.git",
    push_preview = true,
    versions = ["stable" => "v^", "v#.#"], # Restrict to minor releases
)
