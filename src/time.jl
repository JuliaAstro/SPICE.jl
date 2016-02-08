export str2et

function str2et(string)
    et = Ref{Cdouble}(0)
    ccall((:str2et_c, libcspice), Void, (Cstring, Ref{Cdouble}), string, et)
    handleerror()
    return et.x
end
