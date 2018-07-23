export xf2eul

function xf2eul(xform, axisa, axisb, axisc)
    eulang = Array{SpiceDouble}(6)
    unique = Ref{SpiceBoolean}()
    ccall((:xf2eul_c, libcspice), Cvoid, (Ptr{SpiceDouble}, SpiceInt, SpiceInt, SpiceInt, Ptr{SpiceDouble}, Ref{SpiceBoolean}), permutedims(xform), axisa, axisb, axisc, eulang, unique)
    handleerror()
    eulang, unique[]
end
