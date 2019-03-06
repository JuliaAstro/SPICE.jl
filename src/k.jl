export
    kclear,
    kdata,
    kinfo,
    kplfrm,
    ktotal,
    kxtrct

"""
    kclear()

Clear the KEEPER subsystem: unload all kernels, clear the kernel
pool, and re-initialize the subsystem. Existing watches on kernel
variables are retained.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kclear_c.html)
"""
function kclear()
    ccall((:kclear_c, libcspice), Cvoid, ())
    handleerror()
end

"""
    kdata(which, kind, fillen=1024, srclen=256)

Return data for the n-th kernel that is among a list of specified kernel types.

### Arguments ###

- `which`: Index of kernel to fetch from the list of kernels
- `kind`: The kind of kernel to which fetches are limited
- `fillen`: Available space in output file string
- `srclen`: Available space in output source string

### Output ###

Returns `nothing` if no kernel was found or a tuple consisting of

- `file`: The name of the kernel file
- `filtyp`: The type of the kernel
- `source`: Name of the source file used to load file
- `handle`: The handle attached to file

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kdata_c.html)
"""
function kdata(which, kind, fillen=1024, srclen=256)
    typlen = 5
    file = Array{SpiceChar}(undef, fillen)
    filtyp = Array{SpiceChar}(undef, typlen)
    source = Array{SpiceChar}(undef, srclen)
    handle = Ref{SpiceInt}()
    found = Ref{SpiceBoolean}()
    ccall((:kdata_c, libcspice), Cvoid,
          (SpiceInt, Cstring, SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceChar}, Ref{SpiceChar}, Ref{SpiceChar}, Ref{SpiceInt}, Ref{SpiceBoolean}),
          which - 1, kind, fillen, typlen, srclen, file, filtyp, source, handle, found)
    handleerror()
    Bool(found[]) || return nothing
    chararray_to_string(file), chararray_to_string(filtyp), chararray_to_string(source), handle[]
end

"""
    kinfo(file, srclen=256)

### Arguments ###

- `file`: Name of a kernel to fetch information for
- `srclen`: Available space in output source string

### Output ###

Returns `nothing` if no kernel was found or a tuple consisting of

- `filtyp`: The type of the kernel
- `source`: Name of the source file used to load file
- `handle`: The handle attached to file

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kinfo_c.html)
"""
function kinfo(file, srclen=256)
    typlen = 5
    filtyp = Array{SpiceChar}(undef, typlen)
    source = Array{SpiceChar}(undef, srclen)
    handle = Ref{SpiceInt}()
    found = Ref{SpiceBoolean}()
    ccall((:kinfo_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt,
           Ref{SpiceChar}, Ref{SpiceChar}, Ref{SpiceInt}, Ref{SpiceBoolean}),
          file, typlen, srclen, filtyp, source, handle, found)
    handleerror()
    Bool(found[]) || return nothing
    chararray_to_string(filtyp), chararray_to_string(source), handle[]
end

"""
    kplfrm(frmcls)

Return a SPICE set containing the frame IDs of all reference frames of a given class having
specifications in the kernel pool.

### Arguments ###

- `frmcls`: Frame class
- `size`: Size of the output set

### Output ###

Returns the set of ID codes of frames of the specified class.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kplfrm_c.html)
"""
function kplfrm(frmcls, size=128)
    cell = SpiceIntCell(size)
    ccall((:kplfrm_c, libcspice), Cvoid, (SpiceInt, Ref{Cell{SpiceInt}}), frmcls, cell.cell)
    handleerror()
    cell
end

"""
    ktotal(kind)

Return the current number of kernels that have been loaded via the KEEPER interface that are of a
specified type.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ktotal_c.html)
"""
function ktotal(kind)
    count = Ref{SpiceInt}()
    ccall((:ktotal_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), string(kind), count)
    handleerror()
    Int(count[])
end

"""
    kxtrct(keywd, terms, string)

Locate a keyword in a string and extract the substring from the beginning of the first word
following the keyword to the beginning of the first subsequent recognized terminator of a list.

### Arguments ###

- `keywd`: Word that marks the beginning of text of interest
- `terms`: Set of words, any of which marks the end of text
- `string`: String containing a sequence of words

### Output ###

Returns `nothing` if `keywd` was found or a tuple consisting of

- `string`: The input `string` with the text of interest removed
- `substr`: String from end of `keywd` to beginning of first `terms` item found

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kxtrct_c.html)
"""
function kxtrct(keywd, terms, string, substrlen=256)
    terms_, nterms, termlen = chararray(terms)
    stringlen = length(string) + 1
    str = fill(0x00, stringlen)
    str[1:end-1] .= Array{SpiceChar}(string)
    found = Ref{SpiceBoolean}()
    substr = Array{SpiceChar}(undef, substrlen)
    ccall((:kxtrct_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceChar}, SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceChar}, Ref{SpiceBoolean}, Ref{SpiceChar}),
          keywd, termlen, terms_, nterms, stringlen, substrlen, str, found, substr)
    Bool(found[]) || return nothing
    chararray_to_string(str), chararray_to_string(substr)
end

