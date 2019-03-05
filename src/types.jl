export
    DLADescr,
    DSKDescr,
    EKAttDsc,
    Ellipse,
    center,
    semi_major,
    semi_minor,
    Plane

struct Ellipse
    center::NTuple{3, SpiceDouble}
    semi_major::NTuple{3, SpiceDouble}
    semi_minor::NTuple{3, SpiceDouble}
end

center(e::Ellipse) = collect(e.center)
semi_major(e::Ellipse) = collect(e.semi_major)
semi_minor(e::Ellipse) = collect(e.semi_minor)

struct Plane
    normal::NTuple{3, SpiceDouble}
    constant::SpiceDouble
end

normal(p::Plane) = collect(p.normal)
constant(p::Plane) = p.constant

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

struct EKAttDsc
    cclass::SpiceInt
    dtype::SpiceInt
    strlen::SpiceInt
    size::SpiceInt
    indexd::SpiceInt
    nullok::SpiceInt
end

