export unload

function unload(kernel)
    ccall((:unload_c, libcspice), Cvoid, (Cstring,), kernel)
    handleerror()
end
