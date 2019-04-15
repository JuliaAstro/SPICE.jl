module SPICE

export SpiceError

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
    nothing
end

struct SpiceError <: Exception
    msg::String
end

Base.show(io::IO, ex::SpiceError) = print(io, ex.msg)

function handleerror()
    failed = ccall((:failed_c, libcspice), Bool, ())
    if failed
        # Retrive error message
        msg = Array{UInt8}(undef, 1841)
        ccall((:getmsg_c, libcspice), Cvoid, (Cstring, Cint, Ref{UInt8}), "LONG", 1841, msg)
        message = String(msg[1:findfirst(iszero, msg) - 1])
        # Reset error status and throw Julia error
        ccall((:reset_c, libcspice), Cvoid, ())
        throw(SpiceError(message))
    end
    nothing
end

macro checkdims(m::Int, n::Int, arr::Symbol)
    name = string(arr)
    quote
        m1, n1 = size($(esc(arr)))
        if (m1, n1) != ($m, $n)
            msg = string("`$($name)` must be a $($m)x$($n) matrix but is ", m1, "x", n1, ".")
            throw(ArgumentError(msg))
        end
        nothing
    end
end

macro checkdims(len, arr::Symbol...)
    ex = :()
    for a in arr
        name = string(a)
        expr = quote
            n = length($(esc(a)))
            if n != $(esc(len))
                throw(ArgumentError("`$($name)` must have $($(esc(len))) elements but has $n."))
            end
        end
        push!(ex.args, expr)
    end
    :($ex; nothing)
end

# CSPICE data types
const SpiceBoolean = Cint
const SpiceChar = UInt8
const SpiceDouble = Cdouble
const SpiceInt = Cint

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

function chararray_to_string(array::Vector{UInt8})
    idx = findfirst(iszero, array)
    idx = idx === nothing ? length(array) : idx - 1
    String(array[1:idx])
end

function chararray_to_string(array::Matrix{UInt8}, nmax=-1)
    strings = String[]
    m, n = size(array)
    n = nmax == -1 ? n : nmax
    n == 0 && return strings
    for i = 1:n
        line = array[:, i]
        idx = findfirst(iszero, line)
        idx = idx === nothing ? length(line) : idx - 1
        push!(strings, String(line[1:idx]))
    end
    strings
end

function array_to_cmatrix(array; n=0)
    cmat = hcat(array...)
    if n != 0
        m = size(cmat, 1)
        m != n && throw(ArgumentError("Expected each vector to have $n elements."))
    end
    cmat
end

function array_to_cmatrix(array::Vector{Vector{Int}}; n=0)
    array = map(x->SpiceInt.(x), array)
    cmat = hcat(array...)
    if n != 0
        m = size(cmat, 1)
        m != n && throw(ArgumentError("Expected each vector to have $n elements."))
    end
    cmat
end

function cmatrix_to_array(matrix)
    arr = [matrix[:, i] for i in 1:size(matrix, 2)]
end

function cmatrix_to_array(matrix::Matrix{SpiceInt})
    arr = [Int.(matrix[:, i]) for i in 1:size(matrix, 2)]
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
