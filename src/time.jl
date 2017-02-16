export str2et, timout

function str2et(string)
    et = Ref{Cdouble}(0)
    ccall((:str2et_c, libcspice), Void, (Cstring, Ref{Cdouble}), string, et)
    handleerror()
    return et[]
end

function timout(et, pictur)
    string = Array(UInt8, 128)
    ccall((:timout_c, libcspice), Void, (Cdouble, Cstring, Cint, Ptr{UInt8}),
        et, pictur, 128, string)
    handleerror()
    return unsafe_string(pointer(string))
end
