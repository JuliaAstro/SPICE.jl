export spkezr, spkpos, spkcpo

"""
Returns the state of a target body relative to an observing body.

[NAIF documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkezr_c.html)
"""
function spkezr(targ::AbstractString, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE")
    starg = Array(Cdouble, 6)
    lt = Ref{Cdouble}(0)
    ccall((:spkezr_c, libcspice), Void, (Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}), targ, et, ref, abcorr, obs, starg, lt)
    handleerror()
    return starg, lt[]
end
spkezr(targ::Int, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkezr(string(targ), et, ref, string(obs), abcorr=abcorr)
spkezr(targ::AbstractString, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkezr(targ, et, ref, string(obs), abcorr=abcorr)
spkezr(targ::Int, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE") = spkezr(string(targ), et, ref, obs, abcorr=abcorr)

"""
Returns the state of a target body relative to an observing body.

[NAIF documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkpos_c.html)
"""
function spkpos(targ::AbstractString, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE")
    starg = Array(Cdouble, 3)
    lt = Ref{Cdouble}(0)
    ccall((:spkpos_c, libcspice), Void, (Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}), targ, et, ref, abcorr, obs, starg, lt)
    handleerror()
    return starg, lt[]
end
spkpos(targ::Int, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkpos(string(targ), et, ref, string(obs), abcorr=abcorr)
spkpos(targ::AbstractString, et::Float64, ref::AbstractString, obs::Int; abcorr::AbstractString="NONE") = spkpos(targ, et, ref, string(obs), abcorr=abcorr)
spkpos(targ::Int, et::Float64, ref::AbstractString, obs::AbstractString; abcorr::AbstractString="NONE") = spkpos(string(targ), et, ref, obs, abcorr=abcorr)

"""
Returns the state of a target body relative to a constant-position observer location.

[NAIF documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkcpo_c.html)
"""
function spkcpo(target, et, outref, refloc, obspos, obsctr, obsref; abcorr="NONE")
    state = Array(Cdouble, 6)
    lt = Ref{Cdouble}(0)
    ccall(
        (:spkcpo_c, libcspice), Void,
        (Cstring, Cdouble, Cstring, Cstring, Cstring, Ptr{Cdouble}, Cstring, Cstring, Ptr{Cdouble}, Ref{Cdouble}),
        target, et, outref, refloc, abcorr, obspos, obsctr, obsref, state, lt
    )
    handleerror()
    return state, lt[]
end
