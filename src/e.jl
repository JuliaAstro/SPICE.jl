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
    ekifld,
    ekntab,
    ekopn,
    ekopr,
    ekops,
    ekopw,
    ektnam,
    et2utc,
    etcal,
    eul2m,
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
          handle, segno, recno, column, nvals, vallen, cvals_, isnull)
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
          handle, segno, recno, column, nvals, dvals, isnull)
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
          handle, segno, recno, column, nvals, ivals_, isnull)
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
          handle, segno, column, vallen, cvals_, entszs, nlflgs_, rcptrs, wkindx)
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
          handle, segno, column, dvals_, entszs, nlflgs_, rcptrs, wkindx)
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
    ivals_ = SpiceInt.(array_to_cmatrix(ivals))
    nlflgs_ = SpiceBoolean.(nlflgs)
    @checkdims nrows nlflgs rcptrs
    wkindx = Array{SpiceInt}(undef, nrows)
    ccall((:ekacli_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Cstring, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceBoolean},
           Ref{SpiceInt}, Ref{SpiceInt}),
          handle, segno, column, ivals_, entszs, nlflgs_, rcptrs, wkindx)
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
          handle, segno, recno)
    handleerror()
    Int(recno[])
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
    Int(segno[])
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
          handle, segno, recno)
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
          handle, segno, rcptrs)
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
    Int(segno[]), rcptrs
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
    ekops(fname)

Open a scratch (temporary) E-kernel file and prepare the file for writing.

### Arguments ###

- `fname`: Name of EK file

### Output ###

Returns the handle attached to the EK file.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ekops_c.html)
"""
function ekops(fname)
    handle = Ref{SpiceInt}()
    ccall((:ekops_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceInt}),
          fname, handle)
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
    utcstr = Array{UInt8}(undef, lenout)
    ccall((:et2utc_c, libcspice), Cvoid,
          (SpiceDouble, Cstring, SpiceInt, SpiceInt, Ref{UInt8}),
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
    string = Array{UInt8}(undef, lenout)
    ccall((:etcal_c, libcspice), Cvoid, (SpiceDouble, SpiceInt, Ref{UInt8}),
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

