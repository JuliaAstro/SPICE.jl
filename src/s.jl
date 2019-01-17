export
    scard,
    scard!,
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

function str2et(string)
    et = Ref{Cdouble}(0)
    ccall((:str2et_c, libcspice), Cvoid, (Cstring, Ref{Cdouble}), string, et)
    handleerror()
    return et[]
end

"""
Returns the state of a target body relative to an observing body.

- [NAIF documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkezr_c.html)
"""
function spkezr(targ::AbstractString, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE")
    starg = Array{Cdouble}(undef, 6)
    lt = Ref{Cdouble}(0)
    ccall((:spkezr_c, libcspice), Cvoid, (Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}), targ, et, ref, abcorr, obs, starg, lt)
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
    starg = Array{Cdouble}(undef, 3)
    lt = Ref{Cdouble}(0)
    ccall((:spkpos_c, libcspice), Cvoid, (Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}), targ, et, ref, abcorr, obs, starg, lt)
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
    state = Array{Cdouble}(6)
    lt = Ref{Cdouble}(0)
    ccall(
        (:spkcpo_c, libcspice), Cvoid,
        (Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}),
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
        (Cint, Cint, Cint, Cstring, Cdouble, Cdouble, Cstring, Cint, Cint, Ptr{Cdouble}, Ptr{Cdouble}),
        handle[], body, center, frame, first, last, segid, degree, n, states, epochs
    )
    handleerror()
end

"Returns the number of seconds in a day."
function spd()
    ccall((:spd_c, libcspice), Cdouble, ())
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

Returns `cell` with its cardinality set to `card`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/subslr_c.html)
"""
function subpnt(method::AbstractString, target::AbstractString, et::Float64, fixref::AbstractString, obsrvr::AbstractString; abcorr::AbstractString="NONE")
    spoint = Array{Cdouble}(undef, 3)
    trgepc = Ref{Cdouble}(0)
    srfvec = Array{Cdouble}(undef, 3)
    ccall((:subpnt_c, libcspice), Cvoid, (Cstring, Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}, Ptr{Cdouble}), method, target, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec) 
    handleerror()
    return spoint, trgepc[], srfvec
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
function subslr(method::AbstractString, target::AbstractString, et::Float64, fixref::AbstractString, obsrvr::AbstractString; abcorr::AbstractString="NONE")
    spoint = Array{Cdouble}(undef, 3)
    trgepc = Ref{Cdouble}(0)
    srfvec = Array{Cdouble}(undef, 3)
    ccall((:subslr_c, libcspice), Cvoid, (Cstring, Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}, Ptr{Cdouble}), method, target, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec) 
    handleerror()
    return spoint, trgepc[], srfvec
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
    _names, m, n = chararray(names)
    ccall((:swpool_c, libcspice), Cvoid, (Cstring, SpiceInt, SpiceInt, Ptr{SpiceChar}),
          agent, m, n, _names)
    handleerror()
    nothing
end

"""
Return the state transformation matrix from one frame to another at a specified epoch.

https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/sxform_c.html
"""
function sxform(from::String, to::String, et::Float64)
    rot = Array{Cdouble}(undef, 6, 6)
    ccall((:sxform_c, libcspice), Cvoid, (Cstring, Cstring, Cdouble, Ptr{Cdouble}), from, to, et, rot)
    handleerror()
    return rot
end
