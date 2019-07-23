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
    dafgsr,
    dafopr,
    dafopw,
    dafps,
    dafrda,
    dafrfr,
    dafrs,
    dafus,
    dasac,
    dascls,
    dasdc,
    dasec,
    dashfn,
    dasopr,
    dasopw,
    dasrfr,
    dcyldr,
    deltet,
    dgeodr,
    diags2,
    diff,
    dlabbs,
    dlabfs,
    dlafns,
    dlafps,
    dlatdr,
    dp2hx,
    dpgrdr,
    dpmax,
    dpmin,
    dpr,
    drdcyl,
    drdgeo,
    drdlat,
    drdpgr,
    drdsph,
    dskb02,
    dskcls,
    dskd02,
    dskgd,
    dskgtl,
    dski02,
    dskmi2,
    dskn02,
    dskobj,
    dskobj!,
    dskopn,
    dskp02,
    dskrb2,
    dsksrf,
    dsksrf!,
    dskstl,
    dskv02,
    dskw02,
    dskx02,
    dskxsi,
    dskxv,
    dskz02,
    dsphdr,
    dtpool,
    ducrss,
    dvcrss,
    dvdot,
    dvhat,
    dvnorm,
    dvpool,
    dvsep

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
    buffer_, n, lenvals = chararray(buffer)
    ccall((:dafac_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceChar}),
          handle, n, lenvals, buffer_)
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
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
          handle, bufsiz, lenout, n, buffer, done)
    handleerror()
    output = chararray_to_string(buffer, n[])
    while !Bool(done[])
        buffer = Array{SpiceChar}(undef, lenout, bufsiz)
        ccall((:dafec_c, libcspice), Cvoid,
              (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
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
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}),
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
          (SpiceInt, Ref{SpiceChar}),
          lenout, name)
    handleerror()
    chararray_to_string(name)
end

"""
    dafgs(lenout=125)

Return (get) the summary for the current array in the current DAF.

### Arguments ###

- `lenout`: The maximum length of the summary array

### Output ###

Returns the summary for the current array.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafgs_c.html)
"""
function dafgs(lenout=125)
    array = zeros(125)
    ccall((:dafgs_c, libcspice), Cvoid, (Ref{SpiceDouble},), array)
    handleerror()
    array[1:lenout]
end

"""

Read a portion of the contents of a summary record in a DAF file.

### Arguments ###

- `handle`: Handle of DAF
- `recno`: Record number
- `start`: First word to read from record
- `stop`: Last word to read from record

### Output ###

Returns the contents of the record or `nothing` if none was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafgsr_c.html)
"""
function dafgsr(handle, recno, start, stop)
    data = Array{SpiceDouble}(undef, (stop - start) + 1)
    found = Ref{SpiceBoolean}()
    ccall((:dafgsr_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          handle, recno, start, stop, data, found)
    handleerror()
    Bool(found[]) || return nothing
    data
end

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
    dafps(dc, ic)

Pack (assemble) an array summary from its double precision and integer components.

### Arguments ###

- `dc`: Double precision components
- `ic`: Integer components

### Output ###

Returns the array summary.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafps_c.html)
"""
function dafps(dc, ic)
    nd = length(dc)
    ni = length(ic)
    len = nd + (ni - 1) ÷ 2 + 1
    ic_ = SpiceInt.(ic)
    sum = Array{SpiceDouble}(undef, len)
    ccall((:dafps_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceDouble}, Ref{SpiceInt}, Ref{SpiceDouble}),
          nd, ni, dc, ic_, sum)
    sum
end

@deprecate dafrda dafgda

"""
    dafrfr(handle, lenout=128)

Read the contents of the file record of a DAF.

### Arguments ###

- `handle`: Handle of an open DAF file
- `lenout`: Available room in the output string `ifname' (default: 128)

### Output ###

- `nd`: Number of double precision components in summaries
- `ni`: Number of integer components in summaries
- `ifname`: Internal file name
- `fward`: Forward list pointer
- `bward`: Backward list pointer
- `free`: Free address pointer

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafrfr_c.html)
"""
function dafrfr(handle, lenout=128)
    nd = Ref{SpiceInt}()
    ni = Ref{SpiceInt}()
    ifname = Array{SpiceChar}(undef, lenout)
    fward = Ref{SpiceInt}()
    bward = Ref{SpiceInt}()
    free = Ref{SpiceInt}()
    ccall((:dafrfr_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceChar},
           Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceInt}),
          handle, lenout, nd, ni, ifname, fward, bward, free)
    handleerror()
    Int(nd[]), Int(ni[]), chararray_to_string(ifname), Int(fward[]), Int(bward[]), Int(free[])
end

"""
    dafrs(sum)

Change the summary for the current array in the current DAF.

### Arguments ###

- `sum`: New summary for current array

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafrs_c.html)
"""
function dafrs(sum)
    ccall((:dafrs_c, libcspice), Cvoid, (Ref{SpiceDouble},), sum)
    handleerror()
end

"""
    dafus(sum, nd, ni)

Unpack an array summary into its double precision and integer components.

### Arguments ###

- `sum`: Array summary
- `nd`: Number of double precision components
- `ni`: Number of integer components

### Output ###

- `dc`: Double precision components
- `ic`: Integer components

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dafus_c.html)
"""
function dafus(sum, nd, ni)
    dc = Array{SpiceDouble}(undef, nd)
    ic = Array{SpiceInt}(undef, ni)
    ccall((:dafus_c, libcspice), Cvoid,
         (Ref{SpiceDouble}, SpiceInt, SpiceInt, Ref{SpiceDouble}, Ref{SpiceInt}),
         sum, nd, ni, dc, ic)
    dc, Int.(ic)
end

"""
    dasac(handle, buffer)

Add comments from a buffer of character strings to the comment area of a binary DAS file, appending
them to any comments which are already present in the file's comment area.

### Arguments ###

- `handle`: Handle of a DAS opened with write access
- `buffer`: Buffer of comments to put into the comment area

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dasac_c.html)
"""
function dasac(handle, buffer)
    buffer_, n, lenvals = chararray(buffer)
    ccall((:dasac_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceChar}),
          handle, n, lenvals, buffer_)
    handleerror()
end

"""
    dascls(handle)

Close the DAS associated with a given handle.

### Arguments ###

- `handle`: Handle of DAS to be closed

### Output ###

Returns the handle of the closed file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dascls_c.html)
"""
function dascls(handle)
    ccall((:dascls_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
    handle
end

"""
    dasdc(handle)

Delete the entire comment area of a specified DAS file.

### Arguments ###

- `handle`: The handle of a binary DAS opened for writing

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dasdc_c.html)
"""
function dasdc(handle)
    ccall((:dasdc_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    dasec(handle; bufsiz=256, lenout=1024)

Extract comments from the comment area of a binary DAS.

### Arguments ###

- `handle`: Handle of binary DAS opened with read access
- `bufsiz`: Maximum size, in lines, of buffer (default: 256)
- `lenout`: Length of strings in output buffer (default: 1024)

### Output ###

Returns a buffer where extracted comment lines are placed.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dasec_c.html)
"""
function dasec(handle; bufsiz=256, lenout=1024)
    n = Ref{SpiceInt}()
    buffer = Array{SpiceChar}(undef, lenout, bufsiz)
    done = Ref{SpiceBoolean}()
    ccall((:dasec_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
          handle, bufsiz, lenout, n, buffer, done)
    handleerror()
    output = chararray_to_string(buffer, n[])
    while !Bool(done[])
        buffer = Array{SpiceChar}(undef, lenout, bufsiz)
        ccall((:dasec_c, libcspice), Cvoid,
              (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
              handle, bufsiz, lenout, n, buffer, done)
        handleerror()
        append!(output, chararray_to_string(buffer, n[]))
    end
    output
end

"""
    dashfn(handle, namelen=256)

Return the name of the DAS file associated with a handle.

### Arguments ###

- `handle`: Handle of a DAS file
- `namlen`: Length of output file name string (default: 256)

### Output ###

Returns the corresponding file name.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dashfn_c.html)
"""
function dashfn(handle, namelen=256)
    name = Array{SpiceChar}(undef, namelen)
    ccall((:dashfn_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceChar}),
          handle, namelen, name)
    handleerror()
    chararray_to_string(name)
end

"""
    dasopr(fname)

Open a DAS for subsequent read requests.

### Arguments ###

- `fname`: Name of DAS to be opened

### Output ###

Returns the handle assigned to DAS.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dasopr_c.html)
"""
function dasopr(fname)
    handle = Ref{SpiceInt}()
    ccall((:dasopr_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), fname, handle)
    handleerror()
    handle[]
end

"""
    dasopw(fname)

Open a DAS for subsequent write requests.

### Arguments ###

- `fname`: Name of DAS to be opened

### Output ###

Returns the handle assigned to DAS.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dasopw_c.html)
"""
function dasopw(fname)
    handle = Ref{SpiceInt}()
    ccall((:dasopw_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), fname, handle)
    handleerror()
    handle[]
end

"""
    dasrfr(handle, idwlen=128, ifnlen=256)

Read the contents of the file record of a DAS.

### Arguments ###

- `handle`: DAS file handle
- `idwlen`: Length of ID word string (default: 128)
- `ifnlen`: Length of internal file name string (default: 256)

### Output ###

- `idword`: ID word
- `ifname`: DAS internal file name
- `nresvr`: Number of reserved records in file
- `nresvc`: Number of characters in use in reserved records area
- `ncomr`: Number of comment records in file
- `ncomc`: Number of characters in use in comment area

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dasrfr_c.html)
"""
function dasrfr(handle, idwlen=128, ifnlen=256)
    idword = Array{SpiceChar}(undef, idwlen)
    ifname = Array{SpiceChar}(undef, ifnlen)
    nresvr = Ref{SpiceInt}()
    nresvc = Ref{SpiceInt}()
    ncomr = Ref{SpiceInt}()
    ncomc = Ref{SpiceInt}()
    ccall((:dasrfr_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceChar}, Ref{SpiceChar}, Ref{SpiceInt}, Ref{SpiceInt},
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, idwlen, ifnlen, idword, ifname, nresvr, nresvc, ncomr, ncomc)
    handleerror()
    chararray_to_string(idword), chararray_to_string(ifname),
    Int(nresvr[]), Int(nresvc[]), Int(ncomr[]), Int(ncomc[])
end

"""
    dcyldr(x, y, z)

Compute the Jacobian of the transformation from rectangular to cylindrical coordinates.

### Arguments ###

- `x`: X-coordinate of point
- `y`: Y-coordinate of point
- `z`: Z-coordinate of point

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dcyldr_c.html)
"""
function dcyldr(x, y, z)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:dcyldr_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          x, y, z, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    deltet(epoch, eptype)

Return the value of ΔET (ET-UTC) for an input epoch.

### Arguments ###

- `epoch`: Input epoch (seconds past J2000)
- `eptype`: Type of input epoch ("UTC" or "ET")

### Output ###

Returns ΔET (ET-UTC) at input epoch.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/deltet_c.html)
"""
function deltet(epoch, eptype)
    delta = Ref{SpiceDouble}()
    ccall((:deltet_c, libcspice), Cvoid,
          (SpiceDouble, Cstring, Ref{SpiceDouble}),
          epoch, eptype, delta)
    handleerror()
    delta[]
end

"""
    dgeodr(x, y, z, re, f)

Compute the Jacobian of the transformation from rectangular to geodetic coordinates.

### Arguments ###

- `x`: X-coordinate of point
- `y`: Y-coordinate of point
- `z`: Z-coordinate of point
- `re`: Equatorial radius of the reference spheroid
- `f`: Flattening coefficient

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dgeodr_c.html)
"""
function dgeodr(x, y, z, re, f)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:dgeodr_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          x, y, z, re, f, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    diags2(symmat)

Diagonalize a symmetric 2x2 matrix.

### Arguments ###

- `symmat`: A symmetric 2x2 matrix

### Output ###

- `diag`: A diagonal matrix similar to `symmat`
- `rotate`: A rotation used as the similarity transformation

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/diags2_c.html)
"""
function diags2(symmat)
    @checkdims 2 2 symmat
    diag = Array{SpiceDouble}(undef, 2, 2)
    rotate = Array{SpiceDouble}(undef, 2, 2)
    ccall((:diags2_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          symmat, diag, rotate)
    permutedims(diag), permutedims(rotate)
end

"""
    diff(a::T, b::T) where T <: SpiceCell

Compute the difference of two sets of any data type to form a third set.

### Arguments ###

- `a`: First input set
- `b`: Second input set

### Output ###

Returns a cell containing the difference of `a` and `b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/diff_c.html)
"""
function Base.diff(a::SpiceCell{T}, b::SpiceCell{T}) where T
    size = max(a.cell.size, b.cell.size)
    if T <: SpiceChar
        length = max(a.cell.length, b.cell.length)
        out = SpiceCell{T}(size, length)
    else
        out = SpiceCell{T}(size)
    end
    ccall((:diff_c, libcspice), Cvoid, (Ref{Cell{T}}, Ref{Cell{T}}, Ref{Cell{T}}),
          a.cell, b.cell, out.cell)
    handleerror()
    out
end

"""
    dlabbs(handle)

Begin a backward segment search in a DLA file.

### Arguments ###

- `handle`: Handle of open DLA file

### Output ###

Returns the descriptor of the last segment in the DLA file or `nothing` if none was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dlabbs_c.html)
"""
function dlabbs(handle)
    descr = Ref{DLADescr}()
    found = Ref{SpiceBoolean}()
    ccall((:dlabbs_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{SpiceBoolean}),
          handle, descr, found)
    handleerror()
    Bool(found[]) || return nothing
    descr[]
end

"""
    dlabfs(handle)

Begin a forward segment search in a DLA file.

### Arguments ###

- `handle`: Handle of open DLA file

### Output ###

Returns the descriptor of the first segment in the DLA file or `nothing` if none was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dlabfs_c.html)
"""
function dlabfs(handle)
    descr = Ref{DLADescr}()
    found = Ref{SpiceBoolean}()
    ccall((:dlabfs_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{SpiceBoolean}),
          handle, descr, found)
    handleerror()
    Bool(found[]) || return nothing
    descr[]
end

"""
    dlafns(handle, descr)

Find the segment following a specified segment in a DLA file.

### Arguments ###

- `handle`: Handle of open DLA file
- `descr`: Descriptor of a DLA segment

### Output ###

Returns the descriptor of the next segment in the DLA file or `nothing` if none was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dlafns_c.html)
"""
function dlafns(handle, descr)
    nxtdsc = Ref{DLADescr}()
    found = Ref{SpiceBoolean}()
    ccall((:dlafns_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{DLADescr}, Ref{SpiceBoolean}),
          handle, descr, nxtdsc, found)
    handleerror()
    Bool(found[]) || return nothing
    nxtdsc[]
end

"""
    dlafps(handle, descr)

Find the segment preceding a specified segment in a DLA file.

### Arguments ###

- `handle`: Handle of open DLA file
- `descr`: Descriptor of a DLA segment

### Output ###

Returns the descriptor of the previous segment in the DLA file or `nothing` if none was found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dlafps_c.html)
"""
function dlafps(handle, descr)
    nxtdsc = Ref{DLADescr}()
    found = Ref{SpiceBoolean}()
    ccall((:dlafps_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{DLADescr}, Ref{SpiceBoolean}),
          handle, descr, nxtdsc, found)
    handleerror()
    Bool(found[]) || return nothing
    nxtdsc[]
end

"""
    dlatdr(x, y, z)

Compute the Jacobian of the transformation from rectangular to latitudinal coordinates.

### Arguments ###

- `x`: X-coordinate of point
- `y`: Y-coordinate of point
- `z`: Z-coordinate of point

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dlatdr_c.html)
"""
function dlatdr(x, y, z)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:dlatdr_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          x, y, z, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    dp2hx(number, lenout=128)

Convert a double precision number to an equivalent character string using base 16 "scientific notation."

### Arguments ###

- `number`: Number to be converted
- `lenout`: Available space for output string

### Output ###

Returns the equivalent character string, left justified.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dp2hx_c.html)
"""
function dp2hx(number, lenout=128)
    string = Array{SpiceChar}(undef, lenout)
    n = Ref{SpiceInt}()
    ccall((:dp2hx_c, libcspice), Cvoid,
          (SpiceDouble, SpiceInt, Ref{SpiceChar}, Ref{SpiceInt}),
          number, lenout, string, n)
    chararray_to_string(string)
end

"""
    dpgrdr(x, y, z, re, f)

Compute the Jacobian of the transformation from rectangular to planetographic coordinates.

### Arguments ###

- `body`: Body with which coordinate system is associated
- `x`: X-coordinate of point
- `y`: Y-coordinate of point
- `z`: Z-coordinate of point
- `re`: Equatorial radius of the reference spheroid
- `f`: Flattening coefficient

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dpgrdr_c.html)
"""
function dpgrdr(body, x, y, z, re, f)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:dpgrdr_c, libcspice), Cvoid,
          (Cstring, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          body, x, y, z, re, f, jacobi)
    handleerror()
    permutedims(jacobi)
end

function _dpmax()
    ccall((:dpmax_c, libcspice), SpiceDouble, ())
end

@deprecate dpmax() prevfloat(typemax(Float64))

"""
    dpmax()

!!! warning "Deprecated"
    Use `prevfloat(typemax(Float64))` instead.
"""
dpmax

function _dpmin()
    ccall((:dpmin_c, libcspice), SpiceDouble, ())
end

@deprecate dpmin() nextfloat(typemin(Float64))

"""
    dpmin()

!!! warning "Deprecated"
    Use `nextfloat(typemin(Float64))` instead.
"""
dpmin

function _dpr()
    ccall((:dpr_c, libcspice), SpiceDouble, ())
end

@deprecate dpr() rad2deg(1.0)

"""
    dpr()

!!! warning "Deprecated"
    Use `rad2deg(1.0)` instead.
"""
dpr

"""
    drdcyl(r, lon, z)

Compute the Jacobian of the transformation from cylindrical to rectangular coordinates.

### Arguments ###

- `r`: Distance of a point from the origin
- `lon`: Angle of the point from the xz plane in radians
- `z`: Height of the point above the xy plane

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/drdcyl_c.html)
"""
function drdcyl(r, lon, z)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:drdcyl_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          r, lon, z, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    drdgeo(lon, lat, alt, re, f)

Compute the Jacobian of the transformation from geodetic to rectangular coordinates.

### Arguments ###

- `lon`: Geodetic longitude of point (radians)
- `lat`: Geodetic latitude of point (radians)
- `alt`: Altitude of point above the reference spheroid
- `re`: Equatorial radius of the reference spheroid
- `f`: Flattening coefficient

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/drdgeo_c.html)
"""
function drdgeo(lon, lat, alt, re, f)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:drdgeo_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          lon, lat, alt, re, f, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    drdlat(radius, lon, lat)

Compute the Jacobian of the transformation from latitudinal to rectangular coordinates.

### Arguments ###

- `radius`: Distance of a point from the origin
- `lon`: Angle of the point from the XZ plane in radians
- `lat`: Angle of the point from the XY plane in radians

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/drdlat_c.html)
"""
function drdlat(radius, lon, lat)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:drdlat_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          radius, lon, lat, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    drdpgr(body, lon, lat, alt, re, f)

Compute the Jacobian matrix of the transformation from planetographic to rectangular coordinates.

### Arguments ###

- `body`: Name of body with which coordinates are associated
- `lon`: Planetographic longitude of a point (radians)
- `lat`: Planetographic latitude of a point (radians)
- `alt`: Altitude of a point above reference spheroid
- `re`: Equatorial radius of the reference spheroid
- `f`: Flattening coefficient

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/drdpgr_c.html)
"""
function drdpgr(body, lon, lat, alt, re, f)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:drdpgr_c, libcspice), Cvoid,
          (Cstring, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble,
           Ref{SpiceDouble}),
          body, lon, lat, alt, re, f, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    drdsph(r, colat, lon)

Compute the Jacobian of the transformation from latitudinal to rectangular coordinates.

### Arguments ###

- `r`: Distance of a point from the origin
- `colat`: Angle of the point from the positive z-axis
- `lon`: Angle of the point from the xy plane

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/drdsph_c.html)
"""
function drdsph(r, colat, lon)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:drdsph_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          r, colat, lon, jacobi)
    handleerror()
    permutedims(jacobi)
end

"""
    dskb02(handle, dladsc)

Return bookkeeping data from a DSK type 2 segment.

### Arguments ###

- `handle`: DSK file handle
- `dladsc`: DLA descriptor

### Output ###

- `nv`: Number of vertices in model
- `np`: Number of plates in model
- `nvxtot`: Number of voxels in fine grid
- `vtxbds`: Vertex bounds
- `voxsiz`: Fine voxel edge length
- `voxori`: Fine voxel grid origin
- `vgrext`: Fine voxel grid exent
- `cgscal`: Coarse voxel grid scale
- `vtxnpl`: Size of vertex-plate correspondence list
- `voxnpt`: Size of voxel-plate pointer list
- `voxnpl`: Size of voxel-plate correspondence list

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskb02_c.html)
"""
function dskb02(handle, dladsc)
    nv = Ref{SpiceInt}()
    np = Ref{SpiceInt}()
    nvxtot = Ref{SpiceInt}()
    vtxbds = Array{SpiceDouble}(undef, 2, 3)
    voxsiz = Ref{SpiceDouble}()
    voxori = Array{SpiceDouble}(undef, 3)
    vgrext = Array{SpiceDouble}(undef, 3)
    cgscal = Ref{SpiceInt}()
    vtxnpl = Ref{SpiceInt}()
    voxnpt = Ref{SpiceInt}()
    voxnpl = Ref{SpiceInt}()
    ccall((:dskb02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceInt}, Ref{SpiceInt},
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, dladsc, nv, np, nvxtot, vtxbds, voxsiz, voxori, vgrext, cgscal, vtxnpl,
          voxnpt, voxnpl)
    handleerror()
    Int(nv[]), Int(np[]), Int(nvxtot[]), vtxbds, voxsiz[], voxori, vgrext, Int(cgscal[]),
    Int(vtxnpl[]), Int(voxnpt[]), Int(voxnpl[])
end

"""
    dskcls(handle, optmiz=true)

Close a DSK file.

### Arguments ###

- `handle`: Handle assigned to the opened DSK file
- `optmiz`: Flag indicating whether to segregate the DSK (default: `true`)

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskcls_c.html)
"""
function dskcls(handle, optmiz=true)
    ccall((:dskcls_c, libcspice), Cvoid, (SpiceInt, SpiceBoolean), handle, optmiz)
    handleerror()
end

"""
    dskd02(handle, dladsc, item, start, room)

Fetch double precision data from a type 2 DSK segment.

### Arguments ###

- `handle`: DSK file handle
- `dladsc`: DLA descriptor
- `item`: Keyword identifying item to fetch
- `start`: Start index
- `room`: Amount of room in output array

### Output ###

Returns an array containing the requested item.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskd02_c.html)
"""
function dskd02(handle, dladsc, item, start, room)
    n = Ref{SpiceInt}()
    values = Array{SpiceDouble}(undef, room)
    ccall((:dskd02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceDouble}),
          handle, dladsc, item, start - 1, room, n, values)
    handleerror()
    values[1:n[]]
end

"""
    dskgd(handle, dladsc)

Return the DSK descriptor from a DSK segment identified by a DAS handle and DLA descriptor.

### Arguments ###

- `handle`: Handle of a DSK file
- `dladsc`: DLA segment descriptor

### Output ###

Returns the DSK segment descriptor.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskgd_c.html)
"""
function dskgd(handle, dladsc)
    dskdsc = Ref{DSKDescr}()
    ccall((:dskgd_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{DSKDescr}),
          handle, dladsc, dskdsc)
    handleerror()
    dskdsc[]
end

"""
    dskgtl(keywrd)

Retrieve the value of a specified DSK tolerance or margin parameter.

### Arguments ###

- `keywrd`: Code specifying parameter to retrieve

### Output ###

Returns the value of the parameter.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskgtl_c.html)
"""
function dskgtl(keywrd)
    dpval = Ref{SpiceDouble}()
    ccall((:dskgtl_c, libcspice), Cvoid,
          (SpiceInt, Ref{SpiceDouble}),
          keywrd, dpval)
    handleerror()
    dpval[]
end

"""
    dski02(handle, dladsc, item, start, room)

Fetch integer data from a type 2 DSK segment.

### Arguments ###

- `handle`: DSK file handle
- `dladsc`: DLA descriptor
- `item`: Keyword identifying item to fetch
- `start`: Start index
- `room`: Amount of room in output array

### Output ###

Returns an array containing the requested item.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dski02_c.html)
"""
function dski02(handle, dladsc, item, start, room)
    n = Ref{SpiceInt}()
    values = Array{SpiceInt}(undef, room)
    ccall((:dski02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, dladsc, item, start - 1, room, n, values)
    handleerror()
    values[1:n[]]
end

"""
    dskmi2(vrtces, plates, finscl, corscl, worksz, voxpsz, voxlsz, makvtl, spaisz)

Make spatial index for a DSK type 2 segment.

### Arguments ###

- `vrtces`: Vertices
- `plates`: Plates
- `finscl`: Fine voxel scale
- `corscl`: Coarse voxel scale
- `worksz`: Workspace size
- `voxpsz`: Voxel-plate pointer array size
- `voxlsz`: Voxel-plate list array size
- `makvtl`: Vertex-plate list flag
- `spxisz`: Spatial index integer component size

### Output ###

- `spaixd`: Double precision component of spatial index.
- `spaixi`: Integer component of spatial index.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskmi2_c.html)
"""
function dskmi2(vrtces, plates, finscl, corscl, worksz, voxpsz, voxlsz, makvtl, spxisz)
    vrtces_ = array_to_cmatrix(vrtces, n=3)
    plates_ = array_to_cmatrix(plates, n=3)
    nv = length(vrtces)
    np = length(plates)
    work = Array{SpiceInt}(undef, worksz, 2)
    spaixd = Array{SpiceDouble}(undef, 10)
    spaixi = Array{SpiceInt}(undef, spxisz)
    ccall((:dskmi2_c, libcspice), Cvoid,
          (SpiceInt, Ref{SpiceDouble}, SpiceInt, Ref{SpiceInt}, SpiceDouble,
           SpiceInt, SpiceInt, SpiceInt, SpiceInt, SpiceBoolean, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceDouble}, Ref{SpiceInt}),
          nv, vrtces_, np, plates_, finscl, corscl, worksz, voxpsz, voxlsz, makvtl, spxisz,
          work, spaixd, spaixi)
    handleerror()
    spaixd, Int.(spaixi)
end

"""
    dskn02(handle, dladsc, plid)

Compute the unit normal vector for a specified plate from a type 2 DSK segment.

### Arguments ###

- `handle`: DSK file handle
- `dladsc`: DLA descriptor
- `plid`: Plate ID

### Output ###

Return the plate's unit normal vector.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskn02_c.html)
"""
function dskn02(handle, dladsc, plid)
    normal = Array{SpiceDouble}(undef, 3)
    ccall((:dskn02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, SpiceInt, Ref{SpiceDouble}),
          handle, dladsc, plid, normal)
    handleerror()
    normal
end

"""
    dskobj!(set, dsk)

Find the set of body ID codes of all objects for which topographic data are provided in a specified
DSK file.

### Arguments ###

- `dsk`: Name of DSK file
- `set` or `len`: Either a preallocated `SpiceIntCell` or the `size` of the output set.

### Output ###

Returns the set of ID codes of objects in the DSK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskobj_c.html)
"""
function dskobj!(set, dsk)
    ccall((:dskobj_c, libcspice), Cvoid,
          (Cstring, Ref{Cell{SpiceInt}}),
          dsk, set.cell)
    handleerror()
    set
end

@deprecate dskobj dskobj!

"""
    dskopn(fname, ifname, ncomch)

Open a new DSK file for subsequent write operations.

### Arguments ###

- `fname`: Name of a DSK file to be opened
- `ifname`: Internal file name
- `ncomch`: Number of comment characters to allocate

### Output ###

Returns the handle assigned to the opened DSK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskopn_c.html)
"""
function dskopn(fname, ifname, ncomch)
    handle = Ref{SpiceInt}()
    ccall((:dskopn_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceInt, Ref{SpiceInt}),
          fname, ifname, ncomch, handle)
    handleerror()
    handle[]
end

"""
    dskp02(handle, dladsc, start, room)

Fetch triangular plates from a type 2 DSK segment.

### Arguments ###

- `handle`: DSK file handle
- `dladsc`: DLA descriptor
- `start`: Start index
- `room`: Amount of room in output array

### Output ###

Returns an array of plates.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskp02_c.html)
"""
function dskp02(handle, dladsc, start, room)
    n = Ref{SpiceInt}()
    plates = Array{SpiceInt}(undef, 3, room)
    ccall((:dskp02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, SpiceInt, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, dladsc, start - 1, room, n, plates)
    handleerror()
    cmatrix_to_array(plates)
end

"""
    dskrb2(vrtces, plates, corsys, corpar)

Determine range bounds for a set of triangular plates to be stored in a type 2 DSK segment.

### Arguments ###

- `vrtces`: Vertices
- `plates`: Plates
- `corsys`: DSK coordinate system code
- `corpar`: DSK coordinate system parameters

### Output ###

- `mncor3`: Lower bound on range of third coordinate
- `mxcor3`: Upper bound on range of third coordinate

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskrb2_c.html)
"""
function dskrb2(vrtces, plates, corsys, corpar)
    vrtces_ = array_to_cmatrix(vrtces, n=3)
    plates_ = array_to_cmatrix(plates, n=3)
    nv = length(vrtces)
    np = length(plates)
    mncor3 = Ref{SpiceDouble}()
    mxcor3 = Ref{SpiceDouble}()
    ccall((:dskrb2_c, libcspice), Cvoid,
          (SpiceInt, Ref{SpiceDouble}, SpiceInt, Ref{SpiceInt}, SpiceInt, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}),
          nv, vrtces_, np, plates_, corsys, corpar, mncor3, mxcor3)
    handleerror()
    mncor3[], mxcor3[]
end

"""
    dsksrf!(set, dsk)

Find the set of surface ID codes of all objects for which topographic data are provided in a
specified DSK file.

### Arguments ###

- `dsk`: Name of DSK file
- `set` or `len`: Either a preallocated `SpiceIntCell` or the `size` of the output set.

### Output ###

Returns the set of ID codes of surfaces in the DSK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dsksrf_c.html)
"""
function dsksrf!(set, dsk, bodyid)
    ccall((:dsksrf_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{Cell{SpiceInt}}),
          dsk, bodyid, set.cell)
    handleerror()
    set
end

@deprecate dsksrf dsksrf!

"""
    dskstl(keywrd)

Set the value of a specified DSK tolerance or margin parameter.

### Arguments ###

- `keywrd`: Code specifying parameter to retrieve
- `dpval`: Value of parameter

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskstl_c.html)
"""
function dskstl(keywrd, dpval)
    ccall((:dskstl_c, libcspice), Cvoid,
          (SpiceInt, SpiceDouble),
          keywrd, dpval)
    handleerror()
end

"""
    dskv02(handle, dladsc, start, room)

Fetch vertices from a type 2 DSK segment.

### Arguments ###

- `handle`: DSK file handle
- `dladsc`: DLA descriptor
- `start`: Start index
- `room`: Amount of room in output array

### Output ###

Returns an array of vertices.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskv02_c.html)
"""
function dskv02(handle, dladsc, start, room)
    n = Ref{SpiceInt}()
    vrtces = Array{SpiceDouble}(undef, 3, room)
    ccall((:dskv02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, SpiceInt, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceDouble}),
          handle, dladsc, start - 1, room, n, vrtces)
    handleerror()
    cmatrix_to_array(vrtces)
end

"""
    dskw02(handle, center, surfid, dclass, frame, corsys, corpar, mncor1, mxcor1,
           mncor2, mxcor2, mncor3, mxcor3, first, last, vrtces, plates, spaixd, spaixi)

Write a type 2 segment to a DSK file.

### Arguments ###

- `handle`: Handle assigned to the opened DSK file
- `center`: Central body ID code
- `surfid`: Surface ID code
- `dclass`: Data class
- `frame `: Reference frame
- `corsys`: Coordinate system code
- `corpar`: Coordinate system parameters
- `mncor1`: Minimum value of first coordinate
- `mxcor1`: Maximum value of first coordinate
- `mncor2`: Minimum value of second coordinate
- `mxcor2`: Maximum value of second coordinate
- `mncor3`: Minimum value of third coordinate
- `mxcor3`: Maximum value of third coordinate
- `first`: Coverage start time
- `last`: Coverage stop time
- `nv`: Number of vertices
- `vrtces`: Vertices
- `np`: Number of plates
- `plates`: Plates
- `spaixd`: Double precision component of spatial index
- `spaixi`: Integer component of spatial index

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskw02_c.html)
"""
function dskw02(handle, center, surfid, dclass, frame, corsys, corpar, mncor1, mxcor1,
                mncor2, mxcor2, mncor3, mxcor3, first, last, vrtces, plates, spaixd, spaixi)
    vrtces_ = array_to_cmatrix(vrtces, n=3)
    plates_ = array_to_cmatrix(plates, n=3)
    spaixi_ = SpiceInt.(spaixi)
    nv = length(vrtces)
    np = length(plates)
    ccall((:dskw02_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt, Ref{SpiceDouble},
           SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble,
           SpiceDouble, SpiceDouble, SpiceInt, Ref{SpiceDouble}, SpiceInt, Ref{SpiceInt},
           Ref{SpiceDouble}, Ref{SpiceInt}),
          handle, center, surfid, dclass, frame, corsys, corpar, mncor1, mxcor1, mncor2,
          mxcor2, mncor3, mxcor3, first, last, nv, vrtces_, np, plates_, spaixd, spaixi_)
    handleerror()
end

"""
    dskx02(handle, dladsc, vertex, raydir)

Determine the plate ID and body-fixed coordinates of the intersection of a specified ray with the
surface defined by a type 2 DSK plate model.

### Arguments ###

- `handle`: Handle of DSK kernel containing plate model
- `dladsc`: DLA descriptor of plate model segment
- `vertex`: Ray vertex in the body fixed frame
- `raydir`: Ray direction in the body fixed frame

### Output ###

Returns `nothing` if no intercept exists or

- `plid`: ID code of the plate intersected by the ray
- `xpt`: Intercept

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskx02_c.html)
"""
function dskx02(handle, dladsc, vertex, raydir)
    @checkdims 3 vertex raydir
    plid = Ref{SpiceInt}()
    xpt = Array{SpiceDouble}(undef, 3)
    found = Ref{SpiceBoolean}()
    ccall((:dskx02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{SpiceDouble}, Ref{SpiceDouble},
           Ref{SpiceInt}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          handle, dladsc, vertex, raydir, plid, xpt, found)
    handleerror()
    Bool(found[]) || return nothing
    Int(plid[]), xpt
end

"""
    dskxsi(pri, target, nsurf, srflst, et, fixref, vertex, raydir, maxd=1, maxi=1)

Compute a ray-surface intercept using data provided by multiple loaded DSK segments.
Return information about the source of the data defining the surface on which the intercept
was found: DSK handle, DLA and DSK descriptors, and DSK data type-dependent parameters.

### Arguments ###

- `pri`: Data prioritization flag
- `target`: Target body name
- `srflst`: Surface ID list
- `et`: Epoch, expressed as seconds past J2000 TDB
- `fixref`: Name of target body-fixed reference frame
- `vertex`: Vertex of ray
- `raydir`: Direction vector of ray
- `maxd`: Size of DC array (default: 1)
- `maxi`: Size of IC array (default: 1)

### Output ###

Returns `nothing` if no intercept exists or

- `xpt`: Intercept point
- `handle`: Handle of segment contributing surface data
- `dladsc`: DLA descriptor of segment
- `dskdsc`: DSK descriptor of segment
- `dc`: Double precision component of source info
- `ic`: Integer component of source info

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskxsi_c.html)
"""
function dskxsi(pri, target, srflst, et, fixref, vertex, raydir, maxd=1, maxi=1)
    @checkdims 3 vertex raydir
    nsurf = length(srflst)
    srflst_ = SpiceInt.(srflst)
    xpt = Array{SpiceDouble}(undef, 3)
    handle = Ref{SpiceInt}()
    dladsc = Ref{DLADescr}()
    dskdsc = Ref{DSKDescr}()
    dc = zeros(maxd)
    ic = Array{SpiceInt}(undef, maxi)
    found = Ref{SpiceBoolean}()
    ccall((:dskxsi_c, libcspice), Cvoid,
          (SpiceBoolean, Cstring, SpiceInt, Ref{SpiceInt}, SpiceDouble, Cstring, Ref{SpiceDouble},
           Ref{SpiceDouble}, SpiceInt, SpiceInt, Ref{SpiceDouble}, Ref{SpiceInt},
           Ref{DLADescr}, Ref{DSKDescr}, Ref{SpiceDouble}, Ref{SpiceInt}, Ref{SpiceBoolean}),
          pri, target, nsurf, srflst_, et, fixref, vertex, raydir, maxd, maxi,
          xpt, handle, dladsc, dskdsc, dc, ic, found)
    handleerror()
    Bool(found[]) || return nothing
    xpt, handle[], dladsc[], dskdsc[], dc, Int.(ic)
end

"""
    dskxv(pri, target, srflst, et, fixref, nrays, vtxarr, dirarr)

Compute ray-surface intercepts for a set of rays, using data provided by multiple loaded DSK
segments.

### Arguments ###

- `pri`: Data prioritization flag
- `target`: Target body name
- `srflst`: Surface ID list
- `et`: Epoch, expressed as seconds past J2000 TDB
- `fixref`: Name of target body-fixed reference frame
- `nrays `: Number of rays
- `vtxarr`: Array of vertices of rays
- `dirarr`: Array of direction vectors of rays

### Output ###

- `xptarr`: Intercept point array
- `fndarr`: Found flag array

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskxv_c.html)
"""
function dskxv(pri, target, srflst, et, fixref, vtxarr, dirarr)
    srflst_ = SpiceInt.(srflst)
    nrays = length(vtxarr)
    nsurf = length(srflst)
    @checkdims nrays dirarr
    vtxarr_ = array_to_cmatrix(vtxarr, n=3)
    dirarr_ = array_to_cmatrix(dirarr, n=3)
    xptarr = Array{SpiceDouble}(undef, 3, nrays)
    fndarr = Array{SpiceBoolean}(undef, nrays)
    ccall((:dskxv_c, libcspice), Cvoid,
          (SpiceBoolean, Cstring, SpiceInt, Ref{SpiceInt}, SpiceDouble, Cstring, SpiceInt,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          pri, target, nsurf, srflst_, et, fixref, nrays, vtxarr_, dirarr_, xptarr, fndarr)
    handleerror()
    cmatrix_to_array(xptarr), Bool.(fndarr)
end

"""
    dskz02(handle, dladsc)

Return plate model size parameters - plate count and vertex count - for a type 2 DSK segment.

### Arguments ###

- `handle`: DSK file handle
- `dladsc`: DLA descriptor

### Output ###

- `nv`: Number of vertices
- `np`: Number of plates

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dskz02_c.html)
"""
function dskz02(handle, dladsc)
    nv = Ref{SpiceInt}()
    np = Ref{SpiceInt}()
    ccall((:dskz02_c, libcspice), Cvoid,
          (SpiceInt, Ref{DLADescr}, Ref{SpiceInt}, Ref{SpiceInt}),
          handle, dladsc, nv, np)
    handleerror()
    Int(nv[]), Int(np[])
end

"""
    dsphdr(x, y, z)

Compute the Jacobian of the transformation from rectangular to spherical coordinates.

### Arguments ###

- `x`: X-coordinate of point
- `y`: Y-coordinate of point
- `z`: Z-coordinate of point

### Output ###

Returns the matrix of partial derivatives.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dsphdr_c.html)
"""
function dsphdr(x, y, z)
    jacobi = Array{SpiceDouble}(undef, 3, 3)
    ccall((:dsphdr_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          x, y, z, jacobi)
    jacobi
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
    Int(n[]), Symbol(Char(vartype[]))
end

"""
    ducrss(s1, s2)

Compute the unit vector parallel to the cross product of two 3-dimensional vectors and the
derivative of this unit vector.

### Arguments ###

- `s1`: Left hand state for cross product and derivative
- `s2`: Right hand state for cross product and derivative

### Output ###

Returns the unit vector and derivative of the cross product.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ducrss_c.html)
"""
function ducrss(s1, s2)
    @checkdims 6 s1 s2
    sout = Array{SpiceDouble}(undef, 6)
    ccall((:ducrss_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          s1, s2, sout)
    sout
end

"""
    dvcrss(s1, s2)

Compute the cross product of two 3-dimensional vectors and the derivative of this cross product.

### Arguments ###

- `s1`: Left hand state for cross product and derivative
- `s2`: Right hand state for cross product and derivative

### Output ###

Returns the cross product and its derivative.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dvcrss_c.html)
"""
function dvcrss(s1, s2)
    @checkdims 6 s1 s2
    sout = Array{SpiceDouble}(undef, 6)
    ccall((:dvcrss_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          s1, s2, sout)
    sout
end

"""
    dvdot(s1, s2)

Compute the derivative of the dot product of two double precision position vectors.

### Arguments ###

- `s1`: First state vector in the dot product
- `s2`: Second state vector in the dot product

### Output ###

Returns the derivative of the dot product `s1 ⋅ s2`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dvdot_c.html)
"""
function dvdot(s1, s2)
    @checkdims 6 s1 s2
    ccall((:dvdot_c, libcspice), SpiceDouble, (Ref{SpiceDouble}, Ref{SpiceDouble}), s1, s2)
end

"""
    dvhat(s1)

Find the unit vector corresponding to a state vector and the derivative of the unit vector.

### Arguments ###

- `s1`: State to be normalized

### Output ###

Returns the unit vector `s1 / |s1|`, and its time derivative.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dvhat_c.html)
"""
function dvhat(s1)
    @checkdims 6 s1
    sout = Array{SpiceDouble}(undef, 6)
    ccall((:dvhat_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}),
          s1, sout)
    sout
end

"""
    dvnorm(state)

Function to calculate the derivative of the norm of a 3-vector.

### Arguments ###

- `state`: A 6-vector composed of three coordinates and their derivatives.

### Output ###

Returns the derivative of the norm of `state`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dvnorm_c.html)
"""
function dvnorm(state)
    @checkdims 6 state
    ccall((:dvnorm_c, libcspice), SpiceDouble, (Ref{SpiceDouble},), state)
end

"""
    dvpool(name)

Delete a variable from the kernel pool.

### Arguments ###

- `name`: Name of the kernel variable to be deleted

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dvpool_c.html)
"""
function dvpool(name)
    ccall((:dvpool_c, libcspice), Cvoid, (Cstring,), name)
    handleerror()
end

"""
    dvsep(s1, s2)

Calculate the time derivative of the separation angle between two input states, `s1` and `s2`.

### Arguments ###

- `s1`: State vector of the first body
- `s2`: State vector of the second  body

### Output ###

Returns the value of the time derivative of the angular separation between `s1` and `s2`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/dvsep_c.html)
"""
function dvsep(s1, s2)
    @checkdims 6 s1 s2
    res = ccall((:dvsep_c, libcspice), SpiceDouble, (Ref{SpiceDouble}, Ref{SpiceDouble}), s1, s2)
    handleerror()
    res
end

