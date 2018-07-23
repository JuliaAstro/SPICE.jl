#= __precompile__() =#

module SPICE

export SpiceException

deps = abspath(joinpath(splitdir(@__FILE__)[1], "..", "deps", "deps.jl"))
if isfile(deps)
    include(deps)
else
    error("libcspice was not found. Please run 'Pkg.build(\"SPICE\").")
end

function __init__()
    # Set error handling to return on error
    ccall((:erract_c, libcspice), Cvoid, (Cstring, Cint, Cstring), "SET", 0, "RETURN")
    # Do not print error messages
    ccall((:errprt_c, libcspice), Cvoid, (Cstring, Cint, Cstring), "SET", 0, "NONE")
end

struct SpiceException <: Exception
    msg::String
end

Base.show(io::IO, ex::SpiceException) = print(io, ex.msg)

function handleerror()
    failed = ccall((:failed_c, libcspice), Bool, ())
    if failed
        # Retrive error message
        msg = Array{UInt8}(undef, 1841)
        ccall((:getmsg_c, libcspice), Cvoid, (Cstring, Cint, Ptr{UInt8}), "LONG", 1841, msg)
        message = unsafe_string(pointer(msg))
        # Reset error status and throw Julia error
        ccall((:reset_c, libcspice), Cvoid, ())
        throw(SpiceException(message))
    end
end

# CSPICE data types
const SpiceBoolean = Cint
const SpiceChar = UInt8
const SpiceDouble = Cdouble
const SpiceInt = Cint

const LENOUT = 256

function chararray(strings)
    m = length(strings)
    # Longest string + terminator
    n = maximum(length.(strings)) + 1
    out = fill(UInt8(0), (n, m))
    for (i, s) in enumerate(strings)
        start = n * (i - 1) + 1
        stop = start + length(s) - 1
        out[start:stop] = codeunits(s)
    end
    out, m, n
end

include("cells.jl")
include("types.jl")

include("a.jl")
include("b.jl")
include("c.jl")
include("d.jl")
include("e.jl")
include("f.jl")
include("g.jl")
include("h.jl")
include("i.jl")
include("j.jl")
include("k.jl")
include("l.jl")
include("m.jl")
include("n.jl")
include("o.jl")
include("p.jl")
include("q.jl")
include("r.jl")
include("s.jl")
include("t.jl")
include("u.jl")
include("v.jl")
include("w.jl")
include("x.jl")



end # module
