module SPICE

#= __precompile__() =#

deps = abspath(joinpath(splitdir(@__FILE__)[1], "..", "deps", "deps.jl"))
if isfile(deps)
    include(deps)
else
    error("libcspice was not found. Please run 'Pkg.build(\"SPICE\").")
end

function __init__()
    # Set error handling to return on error
    ccall((:erract_c, libcspice), Void, (Cstring, Cint, Cstring), "SET", 0, "RETURN")
    # Do not print error messages
    ccall((:errprt_c, libcspice), Void, (Cstring, Cint, Cstring), "SET", 0, "NONE")
end

function handleerror()
    failed = ccall((:failed_c, libcspice), Bool, ())
    if failed
        # Retrive error message
        msg = Array(UInt8, 1841)
        ccall((:getmsg_c, libcspice), Void, (Cstring, Cint, Ptr{UInt8}), "LONG", 1841, msg)
        message = unsafe_string(pointer(msg))
        # Reset error status and throw Julia error
        ccall((:reset_c, libcspice), Void, ())
        error(message)
    end
end

# CSPICE data types
typealias SpiceBoolean Cint
typealias SpiceChar UInt8
typealias SpiceDouble Cdouble
typealias SpiceInt Cint

include("cells.jl")

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
