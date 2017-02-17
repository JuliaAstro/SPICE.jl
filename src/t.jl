export timout

function timout(et, pictur)
    string = Array{UInt8}(128)
    ccall((:timout_c, libcspice), Void, (Cdouble, Cstring, Cint, Ptr{UInt8}),
        et, pictur, 128, string)
    handleerror()
    return unsafe_string(pointer(string))
end