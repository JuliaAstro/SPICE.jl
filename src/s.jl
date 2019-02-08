export
    scard,
    scard!,
    sincpt,
    spd,
    spkcls,
    spkcpo,
    spkezr,
    spkopn,
    spkpos,
    spkw13,
    str2et,
    subpnt,
    subslr,
    surfpt,
    swpool,
    sxform

"""
    scard!(cell::SpiceCell{T}, card) where T

Set the cardinality of a cell.

### Arguments ###

- `cell`: The cell
- `card`: Cardinality of (number of elements in) the cell

### Output ###

Returns `cell` with its cardinality set to `card`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/scard_c.html)
"""
function scard!(cell::SpiceCell{T}, card) where T
    ccall((:scard_c, libcspice), Cvoid, (SpiceInt, Ref{Cell{T}}), card, cell.cell)
    cell
end

@deprecate scard scard!

"""
    sincpt(method, target, et, fixref, abcorr, obsrvr, dref, dvec)

Given an observer and a direction vector defining a ray, compute the surface intercept
of the ray on a target body at a specified epoch, optionally corrected for light time
and stellar aberration.

The surface of the target body may be represented by a triaxial ellipsoid or by
topographic data provided by DSK files.

### Arguments ###

- `method`: Computation method
- `target`: Name of target body
- `et`: Epoch in TDB seconds past J2000 TDB
- `fixref`: Body-fixed, body-centered target body frame
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of observing body
- `dref`: Reference frame of ray's direction vector
- `dvec`: Ray's direction vector

### Output ###

Returns a tuple consisting of the following data or `nothing` if no intercept was found.

- `spoint`: Surface intercept point on the target body
- `trgepc`: Intercept epoch
- `srfvec`: Vector from observer to intercept point

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/sincpt_c.html)
"""
function sincpt(method, target, et, fixref, abcorr, obsrvr, dref, dvec)
    length(dvec) != 3 && throw(ArgumentError("Length of `dvec` must be 3."))

    spoint = Array{SpiceDouble}(undef, 3)
    trgepc = Ref{SpiceDouble}()
    srfvec = Array{SpiceDouble}(undef, 3)
    found = Ref{SpiceBoolean}()

    ccall((:sincpt_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Cstring, Ptr{SpiceDouble},
           Ptr{SpiceDouble}, Ref{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceInt}),
          method, target, et, fixref, abcorr, obsrvr, dref, dvec, spoint, trgepc, srfvec, found)

    handleerror()
    Bool(found[]) || return nothing

    spoint, trgepc[], srfvec
end

function str2et(string)
    et = Ref{SpiceDouble}(0)
    ccall((:str2et_c, libcspice), Cvoid, (Cstring, Ref{SpiceDouble}), string, et)
    handleerror()
    et[]
end

"""
Returns the state of a target body relative to an observing body.

- [NAIF documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkezr_c.html)
"""
function spkezr(targ::AbstractString, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE")
    starg = Array{SpiceDouble}(undef, 6)
    lt = Ref{SpiceDouble}(0)
    ccall((:spkezr_c, libcspice), Cvoid, (Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble}, Ref{SpiceDouble}), targ, et, ref, abcorr, obs, starg, lt)
    handleerror()
    return starg, lt[]
end
spkezr(targ::Int, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkezr(string(targ), et, ref, string(obs), abcorr=abcorr)
spkezr(targ::AbstractString, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkezr(targ, et, ref, string(obs), abcorr=abcorr)
spkezr(targ::Int, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE") = spkezr(string(targ), et, ref, obs, abcorr=abcorr)

"""
Returns the state of a target body relative to an observing body.

- [NAIF documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkpos_c.html)
"""
function spkpos(targ::AbstractString, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE")
    starg = Array{SpiceDouble}(undef, 3)
    lt = Ref{SpiceDouble}(0)
    ccall((:spkpos_c, libcspice), Cvoid, (Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble}, Ref{SpiceDouble}), targ, et, ref, abcorr, obs, starg, lt)
    handleerror()
    return starg, lt[]
end
spkpos(targ::Int, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkpos(string(targ), et, ref, string(obs), abcorr=abcorr)
spkpos(targ::AbstractString, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkpos(targ, et, ref, string(obs), abcorr=abcorr)
spkpos(targ::Int, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE") = spkpos(string(targ), et, ref, obs, abcorr=abcorr)

"""
Returns the state of a target body relative to a constant-position observer location.

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkcpo_c.html]
(https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkcpo_c.html)
"""
function spkcpo(target, et, outref, refloc, obspos, obsctr, obsref; abcorr="NONE")
    state = Array{SpiceDouble}(6)
    lt = Ref{SpiceDouble}(0)
    ccall(
        (:spkcpo_c, libcspice), Cvoid,
        (Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble}, Cstring, Cstring, Ptr{SpiceDouble}, Ref{SpiceDouble}),
        target, et, outref, refloc, abcorr, obspos, obsctr, obsref, state, lt
    )
    handleerror()
    return state, lt[]
end

function spkopn(name, ifname, ncomch)
    handle = Ref{SpiceInt}(0)
    ccall(
        (:spkopn_c, libcspice), Cvoid,
        (Cstring, Cstring, Cint, Ref{Cint}), name, ifname, ncomch, handle
    )
    handleerror()
    return handle[]
end

function spkcls(handle)
    ccall(
        (:spkcls_c, libcspice), Cvoid,
        (SpiceInt,), handle
    )
    handleerror()
    return handle
end

function spkw13(handle, body, center, frame, first, last, segid, degree, states, epochs)
    n = length(epochs)
    ccall(
        (:spkw13_c, libcspice), Cvoid,
        (Cint, Cint, Cint, Cstring, SpiceDouble, SpiceDouble, Cstring, Cint, Cint, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
        handle[], body, center, frame, first, last, segid, degree, n, states, epochs
    )
    handleerror()
end

"Returns the number of seconds in a day."
function spd()
    ccall((:spd_c, libcspice), SpiceDouble, ())
end





"""
    subslr(method, target, et, fixref, obsrvr, abcorr)

Compute the rectangular coordinates of the sub-solar point on
a target body at a specified epoch, optionally corrected for
light time and stellar aberration.

### Arguments ###

- `method`: Computation method.
- `target`: Name of target body.
- `et`: Epoch in ephemeris seconds past J2000 TDB.
- `fixref`: Body-fixed, body-centered target body frame.
- `obsrvr`: Name of observing body.
- `abcorr`: Aberration correction.

### Output ###

- `spoint`: Sub-solar point on the target body.
- `trgepc`: Sub-solar point epoch.
- `srfvec`: Vector from observer to sub-solar point.

Returns `cell` with its cardinality set to `card`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/subslr_c.html)
"""
function subslr(method, target, et, fixref, obsrvr; abcorr="NONE")
    spoint = Array{SpiceDouble}(undef, 3)
    trgepc = Ref{SpiceDouble}()
    srfvec = Array{SpiceDouble}(undef, 3)
    ccall((:subslr_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring,
           Ptr{SpiceDouble}, Ref{SpiceDouble}, Ptr{SpiceDouble}),
          method, target, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec)
    handleerror()
    spoint, trgepc[], srfvec
end

"""
    subpnt(method, target, et, fixref, obsrvr, abcorr)

Compute the rectangular coordinates of the sub-observer point on
a target body at a specified epoch, optionally corrected for
light time and stellar aberration.

### Arguments ###

- `method`: Computation method.
- `target`: Name of target body.
- `et`: Epoch in ephemeris seconds past J2000 TDB.
- `fixref`: Body-fixed, body-centered target body frame.
- `obsrvr`: Name of observing body.
- `abcorr`: Aberration correction.

### Output ###

- `spoint`: Sub-solar point on the target body.
- `trgepc`: Sub-solar point epoch.
- `srfvec`: Vector from observer to sub-solar point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/subpnt_c.html)
"""
function subpnt(method, target, et, fixref, obsrvr; abcorr="NONE")
    spoint = Array{SpiceDouble}(undef, 3)
    trgepc = Ref{SpiceDouble}()
    srfvec = Array{SpiceDouble}(undef, 3)
    ccall((:subpnt_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring,
           Ptr{SpiceDouble}, Ref{SpiceDouble}, Ptr{SpiceDouble}),
          method, target, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec)
    handleerror()
    spoint, trgepc[], srfvec
end

"""
positn     I   Position of the observer in body-fixed frame.
u          I   Vector from the observer in some direction.
a          I   Length of the ellipsoid semi-axis along the x-axis.
b          I   Length of the ellipsoid semi-axis along the y-axis.
c          I   Length of the ellipsoid semi-axis along the z-axis.
point      O   Point on the ellipsoid pointed to by u.
found      O   Flag indicating if u points at the ellipsoid.
"""
function surfpt(positn, u, a, b, c)
    length(positn) != 3 && throw(ArgumentError("Length of `positn` must be 3."))
    length(u) != 3 && throw(ArgumentError("Length of `u` must be 3."))
    point = Array{SpiceDouble}(undef, 3)
    found = Ref{SpiceBoolean}()
    ccall((:surfpt_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, SpiceDouble, SpiceDouble, SpiceDouble,
           Ptr{SpiceDouble}, Ref{SpiceBoolean}),
          positn, u, a, b, c, point, found)
    handleerror()
    !Bool(found[]) && return nothing

    point
end

"""
    swpool(agent, names)

Add a name to the list of agents to notify whenever a member of a list of kernel variables is updated.

### Arguments ###

- `agent`: The name of an agent to be notified after updates
- `names`: Variable names whose update causes the notice

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/swpool_c.html)
"""
function swpool(agent, names)
    names, m, n = chararray(names)
    ccall((:swpool_c, libcspice), Cvoid, (Cstring, SpiceInt, SpiceInt, Ptr{SpiceChar}),
          agent, m, n, names)
    handleerror()
    nothing
end

"""
Return the state transformation matrix from one frame to another at a specified epoch.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/sxform_c.html
"""
function sxform(from::String, to::String, et::Float64)
    rot = Array{SpiceDouble}(undef, 6, 6)
    ccall((:sxform_c, libcspice), Cvoid, (Cstring, Cstring, SpiceDouble, Ptr{SpiceDouble}), from, to, et, rot)
    handleerror()
    return rot
end
