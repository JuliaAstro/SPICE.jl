export
    gcpool,
    gdpool

"""
    gcpool(name; start=1, room=100, lenout=128)

Return the value of a kernel variable from the kernel pool.

### Arguments ###

- `name`: Name of the variable whose value is to be returned
- `start`: Which component to start retrieving for name (default: 1)
- `room`: The largest number of values to return (default: 100)
- `lenout`: The length of the longest string to return (default: 128)

### Output ###

Returns an array of values if the variable exists or `nothing` if not.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gcpool_c.html)
"""
function gcpool(name; start=1, room=100, lenout=128)
    n = Ref{SpiceInt}()
    values = Array{UInt8}(undef, lenout, room)
    found = Ref{SpiceInt}()
    ccall((:gcpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{UInt8}, Ref{SpiceBoolean}),
          name, start - 1, room, lenout, n, values, found)
    handleerror()
    if Bool(found[])
        return [unsafe_string(pointer(values[:,i])) for i in 1:n[]]
    end
    nothing
end

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
    Bool(found[]) ? values[1:n[]] : nothing
end
