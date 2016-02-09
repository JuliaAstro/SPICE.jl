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
        message = bytestring(pointer(msg))
        # Reset error status and throw Julia error
        ccall((:reset_c, libcspice), Void, ())
        error(message)
    end
end

include("constants.jl")
include("kernels.jl")
include("time.jl")

end # module
