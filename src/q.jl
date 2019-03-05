export
    q2m,
    qxq,
    qdq2av

"""
    q2m(q)

Find the rotation matrix corresponding to a specified unit quaternion.

### Arguments ###

- `q`: A unit quaternion

### Output ###

A rotation matrix corresponding to `q`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/q2m_c.html)
"""
function q2m(q)
    @checkdims 4 q
    r = Matrix{SpiceDouble}(undef, 3, 3)
    ccall((:q2m_c, libcspice), Cvoid, (Ref{SpiceDouble}, Ref{SpiceDouble}), q, r)
    permutedims(r)
end

"""
    qxq(q1, q2)

Multiply two quaternions.

### Arguments ###

- `q1`: First SPICE quaternion factor (as any kind of iterable with four elements)
- `q2`: Second SPICE quaternion factor (as any kind of iterable with four elements)

### Output ###

A quaternion corresponding to the product of `q1' and `q2'

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/qxq_c.html)
"""
function qxq(q1, q2)
    @checkdims 4 q1 q2
    q = Array{SpiceDouble}(undef, 4)
    ccall((:qxq_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          q1, q2, q)
    q
end

"""
    qdq2av(q, dq)

Derive angular velocity from a unit quaternion and its derivative
with respect to time.

### Arguments ###

- `q`: Unit SPICE quaternion (as any kind of iterable with four elements)
- `dq`: Derivative of `q' with respect to time

### Output ###

Angular velocity vector defined by `q' and `dq'

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/qdq2av_c.html)
"""
function qdq2av(q,dq)
    @checkdims 4 q dq
    av = Array{SpiceDouble}(undef, 3)
    ccall((:qdq2av_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          q, dq, av)
    av
end

