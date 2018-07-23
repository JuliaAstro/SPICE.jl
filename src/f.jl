export furnsh

function furnsh(kernels...)
    for kernel in kernels
        ccall((:furnsh_c, libcspice), Cvoid, (Cstring,), kernel)
        handleerror()
    end
end
