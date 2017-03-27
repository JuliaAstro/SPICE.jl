
function unload(kernel::AbstractString)
    ccall((:unload_c, libcspice), Void, (Cstring,), kernel)
    handleerror()
end

unload{T<:AbstractString}(kernels::Vector{T}) = for k in kernels; unload(k); end
