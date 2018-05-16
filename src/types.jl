export
    Ellipse,
    center,
    semi_major,
    semi_minor

mutable struct Ellipse
    center::NTuple{3, SpiceDouble}
    semi_major::NTuple{3, SpiceDouble}
    semi_minor::NTuple{3, SpiceDouble}
end

function Ellipse()
    Ellipse(
        (0.0, 0.0, 0.0),
        (0.0, 0.0, 0.0),
        (0.0, 0.0, 0.0),
    )
end

center(e::Ellipse) = collect(e.center)
semi_major(e::Ellipse) = collect(e.semi_major)
semi_minor(e::Ellipse) = collect(e.semi_minor)