export timout, tisbod

function timout(et, pictur)
    string = Array{UInt8}(128)
    ccall((:timout_c, libcspice), Void, (Cdouble, Cstring, Cint, Ptr{UInt8}),
        et, pictur, 128, string)
    handleerror()
    return unsafe_string(pointer(string))
end

function tisbod(ref, body, et)
    tsipm = Array{SpiceDouble}(6, 6)
    ccall((:tisbod_c, libcspice), Void, (Cstring, SpiceInt, SpiceDouble, Ptr{SpiceDouble}),
        ref, body, et, tsipm)
    handleerror()
    tsipm'
end
