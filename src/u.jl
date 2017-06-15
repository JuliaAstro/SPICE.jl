export unload

function unload(kernel)
    ccall((:unload_c, libcspice), Void, (Cstring,), kernel)
    handleerror()
end
