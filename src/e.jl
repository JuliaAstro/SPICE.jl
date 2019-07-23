export
    edlimb,
    edterm,
    ekacec,
    ekaced,
    ekacei,
    ekaclc,
    ekacld,
    ekacli,
    ekappr,
    ekbseg,
    ekccnt,
    ekcii,
    ekcls,
    ekdelr,
    ekffld,
    ekfind,
    ekgc,
    ekgd,
    ekgi,
    ekinsr,
    ekifld,
    eklef,
    eknelt,
    eknseg,
    ekntab,
    ekopn,
    ekopr,
    ekops,
    ekopw,
    ekpsel,
    ekrcec,
    ekrced,
    ekrcei,
    ekssum,
    ektnam,
    ekucec,
    ekuced,
    ekucei,
    ekuef,
    el2cgv,
    elemc,
    elemd,
    elemi,
    eqncpv,
    eqstr,
    esrchc,
    et2lst,
    et2utc,
    etcal,
    eul2m,
    eul2xf,
    expool

"""
    edlimb(a, b, c, viewpt)

Find the limb of a triaxial ellipsoid, viewed from a specified point.

### Arguments ###

- `a`: Length of ellipsoid semi-axis lying on the x-axis
- `b`: Length of ellipsoid semi-axis lying on the y-axis
- `c`: Length of ellipsoid semi-axis lying on the z-axis
- `viewpt`: Location of viewing point

### Output ###

Returns the limb of the ellipsoid as seen from the viewing point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/edlimb_c.html)
"""
function edlimb(a, b, c, viewpt)
    @checkdims 3 viewpt
    limb = Ref{Ellipse}()
    ccall((:edlimb_c, libcspice), Cvoid,
           (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble}, Ref{Ellipse}),
           a, b, c, viewpt, limb)
    handleerror()
    limb[]
end

"""
    edterm(trmtyp, source, target, et, fixref, abcorr, obsrvr, npts)

Compute a set of points on the umbral or penumbral terminator of a specified
target body, where the target shape is modeled as an ellipsoid.

### Arguments ###

- `trmtyp`: Terminator type
- `source`: Light source
- `target`: Target body
- `et`: Observation epoch
- `fixref`: Body-fixed frame associated with target
- `abcorr`: Aberration correction
- `obsrvr`: Observer
- `npts`: Number of points in terminator set

### Output ###

- `trgepc`: Epoch associated with target center
- `obspos`: Position of observer in body-fixed frame
- `trmpts`: Terminator point set

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/edterm_c.html)
"""
function edterm(trmtyp, source, target, et, fixref, abcorr, obsrvr, npts)
    trgepc = Ref{SpiceDouble}()
    obspos = Array{SpiceDouble}(undef, 3)
    trmpts = Array{SpiceDouble}(undef, 3, npts)
    ccall((:edterm_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, SpiceInt,
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          trmtyp, source, target, et, fixref, abcorr, obsrvr, npts, trgepc, obspos, trmpts)
    handleerror()
    trgepc[], obspos, trmpts
end

"""
    ekacec(handle, segno, recno, column, cvals, isnull)

Add data to a character column in a specified EK record.

### Arguments ###

- `handle`: EK file handle
- `segno`: Index of segment containing record
- `recno`: Record to which data is to be added
- `column`: Column name
- `cvals`: Character values to add to column
- `isnull`: Flag indicating whether column entry is null

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekacec_c.html)
"""
function ekacec(handle, segno, recno, column, cvals, isnull)
    cvals_, nvals, vallen = chararray(cvals)
    ccall((:ekacec_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}, SpiceBoolean),
          handle, segno - 1, recno - 1, column, nvals, vallen, cvals_, isnull)
    handleerror()
end

"""
    ekaced(handle, segno, recno, column, dvals, isnull)

Add data to an double precision column in a specified EK record.

### Arguments ###

- `handle`: EK file handle
- `segno`: Index of segment containing record
- `recno`: Record to which data is to be added
- `column`: Column name
- `dvals`: Double precision values to add to column
- `isnull`: Flag indicating whether column entry is null

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekaced_c.html)
"""
function ekaced(handle, segno, recno, column, dvals, isnull)
    nvals = length(dvals)
    ccall((:ekaced_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt, Ref{SpiceDouble}, SpiceBoolean),
          handle, segno - 1, recno - 1, column, nvals, dvals, isnull)
    handleerror()
end

"""
    ekacei(handle, segno, recno, column, ivals, isnull)

Add data to an integer column in a specified EK record.

### Arguments ###

- `handle`: EK file handle
- `segno`: Index of segment containing record
- `recno`: Record to which data is to be added
- `column`: Column name
- `ivals`: Integer values to add to column
- `isnull`: Flag indicating whether column entry is null

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekacei_c.html)
"""
function ekacei(handle, segno, recno, column, ivals, isnull)
    nvals = length(ivals)
    ivals_ = SpiceInt.(ivals)
    ccall((:ekacei_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt, Ref{SpiceInt}, SpiceBoolean),
          handle, segno - 1, recno - 1, column, nvals, ivals_, isnull)
    handleerror()
end

"""
    ekaclc(handle, segno, column, cvals, nlflgs, rcptrs)

Add an entire character column to an EK segment.

### Arguments ###

- `handle`: EK file handle.
- `segno`: Number of segment to add column to.
- `column`: Column name.
- `cvals`: Character values to add to column.
- `nlflgs`: Array of null flags for column entries.
- `rcptrs`: Record pointers for segment.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekaclc_c.html)
"""
function ekaclc(handle, segno, column, cvals, nlflgs, rcptrs)
    cvals_, nrows, vallen = chararray(cvals)
    nlflgs_ = SpiceBoolean.(nlflgs)
    @checkdims nrows nlflgs rcptrs
    entszs = SpiceInt.(length.(cvals))
    entszs[nlflgs] .= 0
    wkindx = Array{SpiceInt}(undef, nrows)
    ccall((:ekaclc_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Cstring, SpiceInt, Ref{SpiceChar}, Ref{SpiceInt}, Ref{SpiceBoolean},
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, segno - 1, column, vallen, cvals_, entszs, nlflgs_, rcptrs, wkindx)
    handleerror()
end

"""
    ekacld(handle, segno, column, dvals, nlflgs, rcptrs)

Add an entire double precision column to an EK segment.

### Arguments ###

- `handle`: EK file handle
- `segno`: Number of segment to add column to
- `column`: Column name
- `dvals`: Double precision values to add to column
- `nlflgs`: Array of null flags for column entries
- `rcptrs`: Record pointers for segment

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekacld_c.html)
"""
function ekacld(handle, segno, column, dvals, nlflgs, rcptrs)
    nrows = length(dvals)
    entszs = SpiceInt.(length.(dvals))
    entszs[nlflgs] .= 0
    dvals_ = array_to_cmatrix(dvals)
    nlflgs_ = SpiceBoolean.(nlflgs)
    @checkdims nrows nlflgs rcptrs
    wkindx = Array{SpiceInt}(undef, nrows)
    ccall((:ekacld_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Cstring, Ref{SpiceDouble}, Ref{SpiceInt}, Ref{SpiceBoolean},
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, segno - 1, column, dvals_, entszs, nlflgs_, rcptrs, wkindx)
    handleerror()
end

"""
    ekacli(handle, segno, column, ivals, nlflgs, rcptrs)

Add an entire integer column to an EK segment.

### Arguments ###

- `handle`: EK file handle
- `segno`: Number of segment to add column to
- `column`: Column name
- `ivals`: Integer values to add to column
- `nlflgs`: Array of null flags for column entries
- `rcptrs`: Record pointers for segment

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekacli_c.html)
"""
function ekacli(handle, segno, column, ivals, nlflgs, rcptrs)
    nrows = length(ivals)
    entszs = SpiceInt.(length.(ivals))
    entszs[nlflgs] .= 0
    ivals_ = array_to_cmatrix(ivals)
    nlflgs_ = SpiceBoolean.(nlflgs)
    @checkdims nrows nlflgs rcptrs
    wkindx = Array{SpiceInt}(undef, nrows)
    ccall((:ekacli_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Cstring, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceBoolean},
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, segno - 1, column, ivals_, entszs, nlflgs_, rcptrs, wkindx)
    handleerror()
end

"""
    ekappr(handle, segno)

Append a new, empty record at the end of a specified E-kernel segment.

### Arguments ###

- `handle`: File handle
- `segno`: Segment number

### Output ###

Returns the number of appended record.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekappr_c.html)
"""
function ekappr(handle, segno)
    recno = Ref{SpiceInt}()
    ccall((:ekappr_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceInt}),
          handle, segno - 1, recno)
    handleerror()
    recno[] + 1
end

"""
    ekbseg(handle, tabnam, cnames, decls)

Start a new segment in an E-kernel.

### Arguments ###

- `handle`: File handle
- `tabnam`: Table name
- `cnames`: Names of columns
- `decls `: Declarations of columns

### Output ###

Returns the segment number.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekbseg_c.html)
"""
function ekbseg(handle, tabnam, cnames, decls)
    cnames_, ncols, cnmlen = chararray(cnames)
    @checkdims ncols decls
    decls_, _, declen = chararray(decls)
    segno = Ref{SpiceInt}()
    ccall((:ekbseg_c, libcspice), Cvoid,
          (SpiceInt, Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}, SpiceInt, Ref{SpiceChar},
           Ref{SpiceInt}),
          handle, tabnam, ncols, cnmlen, cnames_, declen, decls_, segno)
    handleerror()
    segno[] + 1
end

"""
    ekccnt(table)

Return the number of distinct columns in a specified, currently loaded table

### Arguments ###

- `table`: Name of table

### Output ###

Returns the count of distinct, currently loaded columns.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekccnt_c.html)
"""
function ekccnt(table)
    ccount = Ref{SpiceInt}()
    ccall((:ekccnt_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), table, ccount)
    handleerror()
    Int(ccount[])
end

"""
    ekcii(table, cindex, lenout=256)

Return attribute information about a column belonging to a loaded EK table, specifying the column
by table and index.

### Arguments ###

- `table`: Name of table containing column
- `cindex`: Index of column whose attributes are to be found
- `lenout`: Maximum allowed length of column name (default: 256)

### Output ###

- `column`: Name of column
- `attdsc`: Column attribute descriptor

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekcii_c.html)
"""
function ekcii(table, cindex, lenout=256)
    column = Array{SpiceChar}(undef, lenout)
    attdsc = Ref{EKAttDsc}()
    ccall((:ekcii_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}, Ref{EKAttDsc}),
          table, cindex - 1, lenout, column, attdsc)
    handleerror()
    chararray_to_string(column), attdsc[]
end

"""
    ekcls(handle)

Close an E-kernel.

### Arguments ###

- `handle`: EK file handle

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekcls_c.html)
"""
function ekcls(handle)
    ccall((:ekcls_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""
    ekdelr(handle, segno, recno)

Delete a specified record from a specified E-kernel segment.

### Arguments ###

- `handle`: File handle
- `segno`: Segment number
- `recno`: Record number

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekdelr_c.html)
"""
function ekdelr(handle, segno, recno)
    ccall((:ekdelr_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt),
          handle, segno - 1, recno - 1)
    handleerror()
end

"""
    ekffld(handle, segno, rcptrs)

Complete a fast write operation on a new E-kernel segment.

### Arguments ###

- `handle`: File handle
- `segno`: Segment number
- `rcptrs`: Record pointers

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekffld_c.html)
"""
function ekffld(handle, segno, rcptrs)
    ccall((:ekffld_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceInt}),
          handle, segno - 1, rcptrs)
    handleerror()
end

"""
    ekfind(query, lenout=256)

Find E-kernel data that satisfy a set of constraints.

### Arguments ###

- `query`: Query specifying data to be found.
- `lenout`: Declared length of output error message string (default: 256)

### Output ###

Returns the number of matching rows.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekfind_c.html)
"""
function ekfind(query, lenout=256)
    nmrows = Ref{SpiceInt}()
    error = Ref{SpiceBoolean}()
    errmsg = Array{SpiceChar}(undef, lenout)
    ccall((:ekfind_c, libcspice), Cvoid,
          (Cstring, SpiceInt, Ref{SpiceInt}, Ref{SpiceBoolean}, Ref{SpiceChar}),
          query, lenout, nmrows, error, errmsg)
    handleerror()
    if Bool(error[])
        throw(SpiceError(chararray_to_string(errmsg)))
    end
    Int(nmrows[])
end

"""
    ekgc(selidx, row, elment, lenout=256)

Return an element of an entry in a column of character type in a specified row.

### Arguments ###

- `selidx`: Index of parent column in SELECT clause
- `row`: Row to fetch from
- `elment`: Index of element, within column entry, to fetch
- `lenout`: Maximum length of column element (default: 256)

### Output ###

Returns the character string element of column entry or `missing` if it was null
or `nothing` if the column was not found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekgc_c.html)
"""
function ekgc(selidx, row, elment, lenout=256)
    cdata = Array{SpiceChar}(undef, lenout)
    null = Ref{SpiceBoolean}()
    found = Ref{SpiceBoolean}()
    ccall((:ekgc_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceChar}, Ref{SpiceBoolean}, Ref{SpiceBoolean}),
          selidx - 1, row - 1, elment - 1, lenout, cdata, null, found)
    handleerror()
    Bool(found[]) || return nothing
    Bool(null[]) && return missing
    chararray_to_string(cdata)
end

"""
    ekgd(selidx, row, element)

Return an element of an entry in a column of double precision type in a specified row.

### Arguments ###

- `selidx`: Index of parent column in SELECT clause
- `row`: Row to fetch from
- `elment`: Index of element, within column entry, to fetch

### Output ###

Returns the double precision element of column entry or `missing` if it was null
or `nothing` if the column was not found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekgd_c.html)
"""
function ekgd(selidx, row, elment)
    null = Ref{SpiceBoolean}()
    found = Ref{SpiceBoolean}()
    ddata = Ref{SpiceDouble}()
    ccall((:ekgd_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}, Ref{SpiceBoolean}, Ref{SpiceBoolean}),
          selidx - 1, row - 1, elment - 1, ddata, null, found)
    handleerror()
    Bool(found[]) || return nothing
    Bool(null[]) && return missing
    ddata[]
end

"""
    ekgi(selidx, row, element)

Return an element of an entry in a column of integer type in a specified row.

### Arguments ###

- `selidx`: Index of parent column in SELECT clause
- `row`: Row to fetch from
- `elment`: Index of element, within column entry, to fetch

### Output ###

Returns the integer element of column entry or `missing` if it was null
or `nothing` if the column was not found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekgi_c.html)
"""
function ekgi(selidx, row, elment)
    null = Ref{SpiceBoolean}()
    found = Ref{SpiceBoolean}()
    idata = Ref{SpiceInt}()
    ccall((:ekgi_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceBoolean}, Ref{SpiceBoolean}),
          selidx - 1, row - 1, elment - 1, idata, null, found)
    handleerror()
    Bool(found[]) || return nothing
    Bool(null[]) && return missing
    Int(idata[])
end

"""
    ekinsr(handle, segno, recno)

Add a new, empty record to a specified E-kernel segment at a specified index.

### Arguments ###

- `handle`: File handle
- `segno`: Segment number
- `recno`: Record number

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekinsr_c.html)
"""
function ekinsr(handle, segno, recno)
    ccall((:ekinsr_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt),
          handle, segno - 1, recno - 1)
    handleerror()
end

"""
    ekifld(handle, tabnam, nrows, cnames, decls)

Initialize a new E-kernel segment to allow fast writing.

### Arguments ###

- `handle`: File handle
- `tabnam`: Table name
- `nrows`: Number of rows in the segment
- `cnames`: Names of columns
- `decls`: Declarations of columns

### Output ###

- `segno`: Segment number
- `rcptrs`: Array of record pointers

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekifld_c.html)
"""
function ekifld(handle, tabnam, nrows, cnames, decls)
    cnames_, ncols, cnmlen = chararray(cnames)
    @checkdims ncols decls
    decls_, _, declen = chararray(decls)
    segno = Ref{SpiceInt}()
    rcptrs = Array{SpiceInt}(undef, nrows)
    ccall((:ekifld_c, libcspice), Cvoid,
          (SpiceInt, Cstring, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceChar}, SpiceInt,
           Ref{SpiceChar}, Ref{SpiceInt}, Ref{SpiceInt}),
          handle, tabnam, ncols, nrows, cnmlen, cnames_, declen, decls_, segno, rcptrs)
    handleerror()
    segno[] + 1, rcptrs
end

"""
    eklef(fname)

Load an EK file, making it accessible to the EK readers.

### Arguments ###

- `fname`: Name of EK file to load

### Output ###

Returns the file handle of loaded EK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eklef_c.html)
"""
function eklef(fname)
    handle = Ref{SpiceInt}()
    ccall((:eklef_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceInt}),
          fname, handle)
    handleerror()
    handle[]
end

"""
    eknelt(selidx, row)

Return the number of elements in a specified column entry in the current row.

### Arguments ###

- `selidx`: Index of parent column in SELECT clause
- `row`: Row containing element

### Output ###

Returns the number of elements in entry in current row.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eknelt_c.html)
"""
function eknelt(selidx, row)
    res = ccall((:eknelt_c, libcspice), SpiceInt,
                (SpiceInt, SpiceInt),
                selidx - 1, row - 1)
    handleerror()
    Int(res)
end

"""
    eknseg(handle)

Return the number of segments in a specified EK.

### Arguments ###

- `handle`: EK file handle

### Output ###

Returns the number of segments in the specified E-kernel.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eknseg_c.html)
"""
function eknseg(handle)
    res = ccall((:eknseg_c, libcspice), SpiceInt, (SpiceInt,), handle)
    handleerror()
    Int(res)
end

"""
    ekntab()

Return the number of loaded EK tables.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekntab_c.html)
"""
function ekntab()
    n = Ref{SpiceInt}()
    ccall((:ekntab_c, libcspice), Cvoid, (Ref{SpiceInt},), n)
    Int(n[])
end

"""
    ekopn(fname, ifname, ncomch)

Open a new E-kernel file and prepare the file for writing.

### Arguments ###

- `fname`: Name of EK file
- `ifname`: Internal file name
- `ncomch`: The number of characters to reserve for comments

### Output ###

Return the handle attached to the new EK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekopn_c.html)
"""
function ekopn(fname, ifname, ncomch)
    handle = Ref{SpiceInt}()
    ccall((:ekopn_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceInt, Ref{SpiceInt}),
          fname, ifname, ncomch, handle)
    handleerror()
    handle[]
end

"""
    ekopr(fname)

Open an existing E-kernel file for reading.

### Arguments ###

- `fname`: Name of EK file

### Output ###

Returns the handle attached to the EK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekopr_c.html)
"""
function ekopr(fname)
    handle = Ref{SpiceInt}()
    ccall((:ekopr_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceInt}),
          fname, handle)
    handleerror()
    handle[]
end

"""
    ekops()

Open a scratch (temporary) E-kernel file and prepare the file for writing.

### Output ###

Returns the handle attached to the EK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekops_c.html)
"""
function ekops()
    handle = Ref{SpiceInt}()
    ccall((:ekops_c, libcspice), Cvoid, (Ref{SpiceInt},), handle)
    handleerror()
    handle[]
end

"""
    ekopw(fname)

Open an existing E-kernel file for writing.

### Arguments ###

- `fname`: Name of EK file

### Output ###

Returns the handle attached to the EK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekopw_c.html)
"""
function ekopw(fname)
    handle = Ref{SpiceInt}()
    ccall((:ekopw_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceInt}),
          fname, handle)
    handleerror()
    handle[]
end

"""
    ekpsel(query, msglen=256, tablen=256, collen=256)

Parse the SELECT clause of an EK query, returning full particulars concerning each selected item.

### Arguments ###

- `query`: EK query
- `msglen`: Available space in the output error message string (default: 256)
- `tablen`: Length of strings in `tabs' output array (default: 256)
- `collen`: Length of strings in `cols' output array (default: 256)

### Output ###

- `xbegs`: Begin positions of expressions in SELECT clause
- `xends`: End positions of expressions in SELECT clause
- `xtypes`: Data types of expressions
- `xclass`: Classes of expressions
- `tabs`: Names of tables qualifying SELECT columns
- `cols`: Names of columns in SELECT clause of query

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekpsel_c.html)
"""
function ekpsel(query, msglen=256, tablen=256, collen=256)
    maxqsel = 100
    n = Ref{SpiceInt}()
    xbegs = Array{SpiceInt}(undef, maxqsel)
    xends = Array{SpiceInt}(undef, maxqsel)
    xtypes = Array{SpiceInt}(undef, maxqsel)
    xclass = Array{SpiceInt}(undef, maxqsel)
    tabs = Array{SpiceChar}(undef, tablen, maxqsel)
    cols = Array{SpiceChar}(undef, collen, maxqsel)
    error = Ref{SpiceBoolean}()
    errmsg = Array{SpiceChar}(undef, msglen)
    ccall((:ekpsel_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceInt},
           Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceChar}, Ref{SpiceBoolean},
           Ref{SpiceChar}),
          query, msglen, tablen, collen, n, xbegs, xends, xtypes, xclass, tabs, cols, error, errmsg)
    handleerror()
    if Bool(error[])
        throw(SpiceError(chararray_to_string(errmsg)))
    end
    Int.(xbegs[1:n[]]), Int.(xends[1:n[]]), Int.(xtypes[1:n[]]), Int.(xclass[1:n[]]),
    chararray_to_string(tabs)[1:n[]], chararray_to_string(cols)[1:n[]]
end

"""
    ekrcec(handle, segno, recno, column, lenout=256, nelts=100)

Read data from a character column in a specified EK record.

### Arguments ###

- `handle`: Handle attached to EK file
- `segno`: Index of segment containing record
- `recno`: Record from which data is to be read
- `column`: Column name
- `lenout`: Maximum length of output strings
- `nelts`: Maximum number of elements to return (default: 100)

### Output ###

Returns the character values in column entry or `missing` if they are null.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekrcec_c.html)
"""
function ekrcec(handle, segno, recno, column, lenout=256, nelts=100)
    nvals = Ref{SpiceInt}()
    cvals = Array{SpiceChar}(undef, lenout, nelts)
    isnull = Ref{SpiceBoolean}()
    ccall((:ekrcec_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
          handle, segno - 1, recno - 1, column, lenout, nvals, cvals, isnull)
    handleerror()
    Bool(isnull[]) && return missing
    strip.(chararray_to_string(cvals)[1:nvals[]])
end

"""
    ekrced(handle, segno, recno, column, nelts=100)

Read data from a double precision column in a specified EK record.

### Arguments ###

- `handle`: Handle attached to EK file
- `segno`: Index of segment containing record
- `recno`: Record from which data is to be read
- `column`: Column name
- `nelts`: Maximum number of elements to return (default: 100)

### Output ###

Returns the values in column entry.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekrced_c.html)
"""
function ekrced(handle, segno, recno, column, nelts=100)
    nvals = Ref{SpiceInt}()
    dvals = Array{SpiceDouble}(undef, nelts)
    isnull = Ref{SpiceBoolean}()
    ccall((:ekrced_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring,
           Ref{SpiceInt}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          handle, segno - 1, recno - 1, column, nvals, dvals, isnull)
    handleerror()
    Bool(isnull[]) && return missing
    dvals[1:nvals[]]
end

"""
    ekrcei(handle, segno, recno, column, nelts=100)

Read data from an integer column in a specified EK record.

### Arguments ###

- `handle`: Handle attached to EK file
- `segno`: Index of segment containing record
- `recno`: Record from which data is to be read
- `column`: Column name
- `nelts`: Maximum number of elements to return (default: 100)

### Output ###

Returns the values in column entry.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekrcei_c.html)
"""
function ekrcei(handle, segno, recno, column, nelts=100)
    nvals = Ref{SpiceInt}()
    ivals = Array{SpiceInt}(undef, nelts)
    isnull = Ref{SpiceBoolean}()
    ccall((:ekrcei_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring,
           Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceBoolean}),
          handle, segno - 1, recno - 1, column, nvals, ivals, isnull)
    handleerror()
    Bool(isnull[]) && return missing
    Int.(ivals[1:nvals[]])
end

"""
    ekssum(handle, segno)

Return summary information for a specified segment in a specified EK.

### Arguments ###

- `handle`: Handle of EK
- `segno`: Number of segment to be summarized

### Output ###

Returns the EK segment summary.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekssum_c.html)
"""
function ekssum(handle, segno)
    sum = Ref{EKSegSum}()
    ccall((:ekssum_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{EKSegSum}),
          handle, segno - 1, sum)
    handleerror()
    sum[]
end

"""
    ektnam(n, lenout=256)

Return the name of a specified, loaded table.

### Arguments ###

- `n`: Index of table
- `lenout`: Maximum table name length (default: 256)

### Output ###

Returns the name of table.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ektnam_c.html)
"""
function ektnam(n, lenout=256)
    table = Array{SpiceChar}(undef, lenout)
    ccall((:ektnam_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceChar}),
          n - 1, lenout, table)
    handleerror()
    chararray_to_string(table)
end

"""
    ekucec(handle, segno, recno, column, cvals, isnull)

Update a character column entry in a specified EK record.

### Arguments ###

- `handle`: EK file handle
- `segno`: Index of segment containing record
- `recno`: Record to which data is to be updated
- `column`: Column name
- `cvals`: Character values comprising new column entry
- `isnull`: Flag indicating whether column entry is null

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekucec_c.html)
"""
function ekucec(handle, segno, recno, column, cvals, isnull)
    cvals_, nvals, vallen = chararray(cvals)
    ccall((:ekucec_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt, SpiceInt,
           Ref{SpiceChar}, SpiceBoolean),
          handle, segno - 1, recno - 1, column, nvals, vallen, cvals_, isnull)
    handleerror()
end

"""
    ekuced(handle, segno, recno, column, dvals, isnull)

Update a double precision column entry in a specified EK record.

### Arguments ###

- `handle`: Handle attached to EK file
- `segno`: Index of segment containing record
- `recno`: Record in which entry is to be updated
- `column`: Column name
- `dvals`: Double precision values comprising new column entry
- `isnull`: Flag indicating whether column entry is null

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekuced_c.html)
"""
function ekuced(handle, segno, recno, column, dvals, isnull)
    nvals = length(dvals)
    ccall((:ekuced_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt,
           Ref{SpiceDouble}, SpiceBoolean),
          handle, segno - 1, recno - 1, column, nvals, dvals, isnull)
    handleerror()
end

"""
    ekucei(handle, segno, recno, column, dvals, isnull)

Update an integer column entry in a specified EK record.

### Arguments ###

- `handle`: Handle attached to EK file
- `segno`: Index of segment containing record
- `recno`: Record in which entry is to be updated
- `column`: Column name
- `ivals`: Integer values comprising new column entry
- `isnull`: Flag indicating whether column entry is null

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekucei_c.html)
"""
function ekucei(handle, segno, recno, column, ivals, isnull)
    nvals = length(ivals)
    ivals_ = SpiceInt.(ivals)
    ccall((:ekucei_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, Cstring, SpiceInt,
           Ref{SpiceInt}, SpiceBoolean),
          handle, segno - 1, recno - 1, column, nvals, ivals_, isnull)
    handleerror()
end

"""
    ekuef(handle)

Unload an EK file, making its contents inaccessible to the EK reader routines, and clearing space
in order to allow other EK files to be loaded.

### Arguments ###

- `handle`: Handle of EK file

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekuef_c.html)
"""
function ekuef(handle)
    ccall((:ekuef_c, libcspice), Cvoid, (SpiceInt,), handle)
    handleerror()
end

"""

Convert an ellipse to a center vector and two generating vectors.
The selected generating vectors are semi-axes of the ellipse.

### Arguments ###

- `ellipse`: An ellipse

### Output ###

Returns the center and semi-axes of ellipse.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/el2cgv_c.html)
"""
function el2cgv(ellipse)
    center = Array{SpiceDouble}(undef, 3)
    smajor = Array{SpiceDouble}(undef, 3)
    sminor = Array{SpiceDouble}(undef, 3)
    ccall((:el2cgv_c, libcspice), Cvoid,
          (Ref{Ellipse}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          ellipse, center, smajor, sminor)
    center, smajor, sminor
end

@deprecate elemc(item, cell) item in cell
@deprecate elemd(item, cell) item in cell
@deprecate elemi(item, cell) item in cell

"""
    elem[c/d/i](item, cell)

!!! warning "Deprecated"
    Use `item in cell` instead.
"""
elemc
elemd
elemi

"""
    eqstr(a, b)

Determine whether two strings are equivalent.

### Arguments ###

- `a`, `b`: Arbitrary character strings

### Output ###

Returns `true` if `a` and `b` are equivalent.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eqstr_c.html)
"""
function eqstr(a, b)
    res = ccall((:eqstr_c, libcspice), SpiceBoolean,
                (Cstring, Cstring), a, b)
    handleerror()
    Bool(res)
end

"""
    eqncpv(et, epoch, eqel, rapol, decpol)

Compute the state (position and velocity of an object whose trajectory is described via equinoctial
elements relative to some fixed plane (usually the equatorial plane of some planet).

### Arguments ###

- `et`: Epoch in seconds past J2000 to find state
- `epoch`: Epoch of elements in seconds past J2000
- `eqel`: Array of equinoctial elements
- `rapol`: Right Ascension of the pole of the reference plane
- `decpol`: Declination of the pole of the reference plane

### Output ###

Returns the state of the object described by `eqel`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eqncpv_c.html)
"""
function eqncpv(et, epoch, eqel, rapol, decpol)
    @checkdims 9 eqel
    state = Array{SpiceDouble}(undef, 6)
    ccall((:eqncpv_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, Ref{SpiceDouble}, SpiceDouble, SpiceDouble, Ref{SpiceDouble}),
          et, epoch, eqel, rapol, decpol, state)
    handleerror()
    state
end

"""
    esrchc(value, array)

Search for a given value within a character string array.

### Arguments ###

- `value`: Key value to be found in array
- `array`: Character string array to search

### Output ###

Returns the index of the first equivalent array entry, or -1 if no equivalent element is found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/esrchc_c.html)
"""
function esrchc(value, array)
    array_, ndim, lenvals = chararray(array)
    res = Int(ccall((:esrchc_c, libcspice), SpiceInt,
                    (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}),
                    value, ndim, lenvals, array_))
    handleerror()
    res == -1 ? res : res + 1
end

"""
    et2lst(et, body, lon, typ, timlen=128, ampmlen=128)

Given an ephemeris epoch, compute the local solar time for an object on the surface of a body at a
specified longitude.

### Arguments ###

- `et`: Epoch in seconds past J2000 epoch
- `body`: ID-code of the body of interest
- `lon`: Longitude of surface point (radians)
- `typ`: Type of longitude "PLANETOCENTRIC", etc
- `timlen`: Available room in output time string (default: 128)
- `ampmlen`: Available room in output `ampm' string (default: 128)

### Output ###

- `hr`: Local hour on a "24 hour" clock
- `mn`: Minutes past the hour
- `sc`: Seconds past the minute
- `time`: String giving local time on 24 hour clock
- `ampm`: String giving time on A.M./ P.M. scale

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/et2lst_c.html)
"""
function et2lst(et, body, lon, typ, timlen=128, ampmlen=128)
    hr = Ref{SpiceInt}()
    mn = Ref{SpiceInt}()
    sc = Ref{SpiceInt}()
    time = Array{SpiceChar}(undef, timlen)
    ampm = Array{SpiceChar}(undef, ampmlen)
    ccall((:et2lst_c, libcspice), Cvoid,
          (SpiceDouble, SpiceInt, SpiceDouble, Cstring, SpiceInt, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceChar}),
          et, body, lon, typ, timlen, ampmlen, hr, mn, sc, time, ampm)
    handleerror()
    Int(hr[]), Int(mn[]), Int(sc[]), chararray_to_string(time), chararray_to_string(ampm)
end

"""
    et2utc(et, format, prec)

Convert an input time from ephemeris seconds past J2000
to Calendar, Day-of-Year, or Julian Date format, UTC.

### Arguments ###

- `et`: Input epoch, given in ephemeris seconds past J2000
- `format`: Format of output epoch. It may be any of the following:
    - `:C`: Calendar format, UTC
    - `:D`: Day-of-Year format, UTC
    - `:J`: Julian Date format, UTC
    - `:ISOC`: ISO Calendar format, UTC
    - `:ISOD`: ISO Day-of-Year format, UTC
- `prec`: Digits of precision in fractional seconds or days

### Output ###

Returns an output time string equivalent to the input epoch, in the specified format.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/et2utc_c.html)
"""
function et2utc(et, format, prec)
    lenout = 32
    utcstr = Array{SpiceChar}(undef, lenout)
    ccall((:et2utc_c, libcspice), Cvoid,
          (SpiceDouble, Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}),
          et, string(format), prec, lenout, utcstr)
    handleerror()
    chararray_to_string(utcstr)
end

"""
    etcal(et, lenout=128)

Convert from an ephemeris epoch measured in seconds past the epoch of J2000 to
a calendar string format using a formal calendar free of leapseconds.

### Arguments ###

- `et`: Ephemeris time measured in seconds past J2000
- `lenout`: Length of output string (default: 128)

### Output ###

Returns a standard calendar representation of `et`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/etcal_c.html)
"""
function etcal(et, lenout=128)
    string = Array{SpiceChar}(undef, lenout)
    ccall((:etcal_c, libcspice), Cvoid, (SpiceDouble, SpiceInt, Ref{SpiceChar}),
          et, lenout, string)
    chararray_to_string(string)
end

"""
    eul2m(angle3, angle2, angle1, axis3, axis2, axis1)

Construct a rotation matrix from a set of Euler angles.

### Arguments ###

- `angle3`, `angle2`, `angle1`: Rotation angles about third, second, and first rotation axes (radians)
- `axis3`, `axis2`, `axis1`: Axis numbers of third, second, and first rotation axes

### Output ###

A rotation matrix corresponding to the product of the 3 rotations.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eul2m_c.html)
"""
function eul2m(angle3, angle2, angle1, axis3, axis2, axis1)
    r = Matrix{SpiceDouble}(undef, 3, 3)
    ccall((:eul2m_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          angle3, angle2, angle1, axis3, axis2, axis1, r)
    handleerror()
    permutedims(r)
end

"""
    eul2xf(eulang, axisa, axisb, axisc)

Compute a state transformation from an Euler angle factorization of a rotation and the derivatives
of those Euler angles.

### Arguments ###

- `eulang`: An array of Euler angles and their derivatives
- `axisa`: Axis A of the Euler angle factorization
- `axisb`: Axis B of the Euler angle factorization
- `axisc`: Axis C of the Euler angle factorization

### Output ###

Returns a state transformation matrix.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/eul2xf_c.html)
"""
function eul2xf(eulang, axisa, axisb, axisc)
    @checkdims 6 eulang
    xform = Array{SpiceDouble}(undef, 6, 6)
    ccall((:eul2xf_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceDouble}),
          eulang, axisa, axisb, axisc, xform)
    handleerror()
    permutedims(xform)
end

"""
    expool(name)

Confirm the existence of a kernel variable in the kernel pool.

### Arguments ###

- `name`: Name of the variable whose value is to be returned

### Output ###

Returns `true` when the variable is in the pool.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/expool_c.html)
"""
function expool(name)
    found = Ref{SpiceBoolean}()
    ccall((:expool_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceBoolean}),
          name, found)
    handleerror()
    Bool(found[])
end

