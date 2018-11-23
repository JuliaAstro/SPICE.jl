export q2m

q2m(q...) = q2m(collect(q))
    
function q2m(q)
    length(q) != 4 && throw(ArgumentError("`q` needs to be an iterable with four elements."))    
    r = Matrix{SpiceDouble}(undef, 3, 3)
    ccall((:q2m_c, libcspice), Cvoid, (Ptr{SpiceDouble}, Ptr{SpiceDouble}), collect(q), r)
    permutedims(r)
end