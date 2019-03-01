export
    DLADescr,
    DSKDescr,
    Ellipse,
    center,
    semi_major,
    semi_minor,
    Plane

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

mutable struct Plane
    normal::NTuple{3, SpiceDouble}
    constant::SpiceDouble
end

Plane() = Plane((0.0, 0.0, 0.0), 0.0)

struct DLADescr
    bwdptr::SpiceInt
    fwdptr::SpiceInt
    ibase::SpiceInt
    isize::SpiceInt
    dbase::SpiceInt
    dsize::SpiceInt
    cbase::SpiceInt
    csize::SpiceInt
end

struct DSKDescr
    surfce::SpiceInt
    center::SpiceInt
    dclass::SpiceInt
    dtype::SpiceInt
    frmcde::SpiceInt
    corsys::SpiceInt
    corpar::NTuple{10, SpiceDouble}
    co1min::SpiceDouble
    co1max::SpiceDouble
    co2min::SpiceDouble
    co2max::SpiceDouble
    co3min::SpiceDouble
    co3max::SpiceDouble
    start::SpiceDouble
    stop::SpiceDouble
end

