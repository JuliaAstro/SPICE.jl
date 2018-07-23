export timout, tisbod, tyear

function timout(et, pictur)
    string = Array{UInt8}(undef, 128)
    ccall((:timout_c, libcspice), Cvoid, (Cdouble, Cstring, Cint, Ptr{UInt8}),
        et, pictur, 128, string)
    handleerror()
    return unsafe_string(pointer(string))
end

function tisbod(ref, body, et)
    tsipm = Array{SpiceDouble}(undef, 6, 6)
    ccall((:tisbod_c, libcspice), Cvoid, (Cstring, SpiceInt, SpiceDouble, Ptr{SpiceDouble}),
        ref, body, et, tsipm)
    handleerror()
    tsipm'
end

"Returns the number of seconds per tropical year."
function tyear()
    ccall((:tyear_c, libcspice), Cdouble, ())
end
