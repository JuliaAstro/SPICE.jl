export furnsh, unload

function furnsh(kernel::AbstractString)
    ccall((:furnsh_c, libcspice), Void, (Cstring,), kernel)
    handleerror()
end

furnsh{T<:AbstractString}(kernels::Vector{T}) = for k in kernels; furnsh(k); end

function unload(kernel::AbstractString)
    ccall((:unload_c, libcspice), Void, (Cstring,), kernel)
    handleerror()
end

unload{T<:AbstractString}(kernels::Vector{T}) = for k in kernels; unload(k); end
