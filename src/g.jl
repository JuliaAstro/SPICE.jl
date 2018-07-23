export gdpool

"""
    gdpool(name; start=1, room=100)

Return the value of a kernel variable from the kernel pool.

### Arguments ###

- `name`: Name of the variable whose value is to be returned
- `start`: Which component to start retrieving for name (default: 1)
- `room`: The largest number of values to return (default: 100)

### Output ###

Returns an array of values if the variable exists or `nothing` if not.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gdpool_c.html)
"""
function gdpool(name; start=1, room=100)
    n = Ref{SpiceInt}()
    values = Array{SpiceDouble}(undef, room)
    found = Ref{SpiceInt}()
    ccall((:gdpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{SpiceDouble}, Ref{SpiceBoolean}),
          name, start - 1, room, n, values, found)
    handleerror()
    found[] == 1 ? values[1:n[]] : nothing
end
