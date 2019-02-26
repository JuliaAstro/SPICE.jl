export
    dafac,
    dafbbs,
    dafbfs,
    dafcls,
    dafcs,
    dafdc,
    dafec,
    daffna,
    daffpa,
    dafgda,
    dafgh,
    dafgn,
    dafgs,
    dafopr,
    dafopw,
    dtpool

"""
    dafac(handle, buffer)

Add comments from a buffer of character strings to the comment area of a binary DAF file, appending
them to any comments which are already present in the file's comment area.

### Arguments ###

- `handle`: Handle of a DAF opened with write access
- `buffer`: Buffer of comments to put into the comment area

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafac_c.html)
"""
function dafac(handle, buffer)
    buffer, n, lenvals = chararray(buffer)
    ccall((:dafac_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ptr{SpiceChar}),
          handle, n, lenvals, buffer)
    handleerror()
end

"""
    dafbbs(handle)

Begin a backward search for arrays in a DAF.

### Arguments ###

- `handle`: Handle of DAF to be searched

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafbbs_c.html)
"""
function dafbbs(handle)
    ccall((:dafbbs_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    dafbfs(handle)

Begin a forward search for arrays in a DAF.

### Arguments ###

- `handle`: Handle of DAF to be searched

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafbfs_c.html)
"""
function dafbfs(handle)
    ccall((:dafbfs_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    dafcls(handle)

Close the DAF associated with a given handle.

### Arguments ###

- `handle`: Handle of DAF to be closed

### Output ###

Returns the handle of the closed file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafcls_c.html)
"""
function dafcls(handle)
    ccall((:dafcls_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
    handle
end

"""
    dafcs(handle)

Select a DAF that already has a search in progress as the one to continue searching.

### Arguments ###

- `handle`: Handle of DAF to continue searching

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafcs_c.html)
"""
function dafcs(handle)
    ccall((:dafcs_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    dafdc(handle)

Delete the entire comment area of a specified DAF file.

### Arguments ###

- `handle`: The handle of a binary DAF opened for writing

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafdc_c.html)
"""
function dafdc(handle)
    ccall((:dafdc_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    dafec(handle; bufsiz=256, lenout=1024)

Extract comments from the comment area of a binary DAF.

### Arguments ###

- `handle`: Handle of binary DAF opened with read access
- `bufsiz`: Maximum size, in lines, of buffer (default: 256)
- `lenout`: Length of strings in output buffer (default: 1024)

### Output ###

Returns a buffer where extracted comment lines are placed.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafec_c.html)
"""
function dafec(handle; bufsiz=256, lenout=1024)
    n = Ref{SpiceInt}()
    buffer = Array{SpiceChar}(undef, lenout, bufsiz)
    done = Ref{SpiceBoolean}()
    ccall((:dafec_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{SpiceChar}, Ref{SpiceBoolean}),
          handle, bufsiz, lenout, n, buffer, done)
    handleerror()
    output = chararray_to_string(buffer, n[])
    while !Bool(done[])
        buffer = Array{SpiceChar}(undef, lenout, bufsiz)
        ccall((:dafec_c, libcspice), Cvoid,
              (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ptr{SpiceChar}, Ref{SpiceBoolean}),
              handle, bufsiz, lenout, n, buffer, done)
        handleerror()
        append!(output, chararray_to_string(buffer, n[]))
    end
    output
end

"""
    daffna()

Find the next (forward) array in the current DAF.

### Output ###

Returns `true` if an array was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/daffna_c.html)
"""
function daffna()
    found = Ref{SpiceBoolean}()
    ccall((:daffna_c, libcspice), Cvoid, (Ref{SpiceBoolean},), found)
    handleerror()
    Bool(found[])
end

"""
    daffpa()

Find the previous (backward) array in the current DAF.

### Output ###

Returns `true` if an array was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/daffpa_c.html)
"""
function daffpa()
    found = Ref{SpiceBoolean}()
    ccall((:daffpa_c, libcspice), Cvoid, (Ref{SpiceBoolean},), found)
    handleerror()
    Bool(found[])
end

"""
    dafgda(handle, start, stop)

Read the double precision data bounded by two addresses within a DAF.

### Arguments ###

- `handle`: Handle of a DAF
- `start, stop`: Initial, final address within file

### Output ###

Returns the data contained between `start` and `stop`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafgda_c.html)
"""
function dafgda(handle, start, stop)
    data = Array{SpiceDouble}(undef, stop - start)
    ccall((:dafgda_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ptr{SpiceDouble}),
          handle, start, stop, data)
    handleerror()
    data
end

"""
    dafgh()

Return (get) the handle of the DAF currently being searched.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafgh_c.html)
"""
function dafgh()
    handle = Ref{SpiceInt}()
    ccall((:dafgh_c, libcspice), Cvoid, (Ref{SpiceInt},), handle)
    handleerror()
    handle[]
end

"""
    dafgn(lenout=128)

Return (get) the name for the current array in the current DAF.

### Arguments ###

- `lenout`: Length of array name string (default: 128)

### Output ###

Returns the name of the current array.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafgn_c.html)
"""
function dafgn(lenout=128)
    name = Array{SpiceChar}(undef, lenout)
    ccall((:dafgn_c, libcspice), Cvoid,
          (SpiceInt, Ptr{SpiceChar}),
          lenout, name)
    handleerror()
    name
end

"""
    dafgs!(sum)

Return (get) the summary for the current array in the current DAF and write it to `sum`.

### Arguments ###

- `sum`: An empty `Vector{Float64}` with the expected length

### Output ###

Returns the summary for the current array.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafgs_c.html)
"""
function dafgs!(array)
    ccall((:dafgs_c, libcspice), Cvoid, (Ptr{SpiceDouble},), array)
    handleerror()
    array
end

"""
    dafgs(lenout=128)

Return (get) the summary for the current array in the current DAF.

### Arguments ###

- `lenout`: Length of output array (default: 128)

### Output ###

Returns the summary for the current array.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafgs_c.html)
"""
dafgs(lenout=128) = dafgs!(zeros(lenout))

"""
    dafopr(fname)

Open a DAF for subsequent read requests.

### Arguments ###

- `fname`: Name of DAF to be opened

### Output ###

Returns the handle assigned to DAF.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafopr_c.html)
"""
function dafopr(fname)
    handle = Ref{SpiceInt}()
    ccall((:dafopr_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), fname, handle)
    handleerror()
    handle[]
end

"""
    dafopw(fname)

Open a DAF for subsequent write requests.

### Arguments ###

- `fname`: Name of DAF to be opened

### Output ###

Returns the handle assigned to DAF.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafopw_c.html)
"""
function dafopw(fname)
    handle = Ref{SpiceInt}()
    ccall((:dafopw_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), fname, handle)
    handleerror()
    handle[]
end

"""
    dtpool(name)

Return the data about a kernel pool variable.

### Arguments ###

- `name`: Name of the variable whose value is to be returned

### Output ###

Returns the tuple `(n ,vartype)`.

- `n`: Number of values returned for name
- `vartype`: Type of the variable
    - `:C` if the data is character data
    - `:N` if the data is numeric
    - `:X` if there is no variable name in the pool

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dtpool_c.html)
"""
function dtpool(name)
    found = Ref{SpiceBoolean}()
    n = Ref{SpiceInt}()
    vartype = Ref{Cchar}()
    ccall((:dtpool_c, libcspice), Cvoid, (Cstring, Ref{SpiceBoolean}, Ref{SpiceInt}, Ref{Cchar}),
          name, found, n, vartype)
    handleerror()
    n[], Symbol(Char(vartype[]))
end
