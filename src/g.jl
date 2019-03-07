export
    gcpool,
    gdpool,
    georec,
    getelm,
    getfat,
    getfov,
    gfdist,
    gfilum,
    gfoclt,
    gfpa,
    gfposc,
    gfrfov,
    gfrr,
    gfsep,
    gfsntc,
    gfsstp,
    gfstol,
    gfsubc,
    gftfov,
    gipool,
    gnpool

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
    values = Array{SpiceChar}(undef, lenout, room)
    found = Ref{SpiceInt}()
    ccall((:gcpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
          name, start - 1, room, lenout, n, values, found)
    handleerror()
    if Bool(found[])
        return chararray_to_string(values, n[])
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
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          name, start - 1, room, n, values, found)
    handleerror()
    Bool(found[]) ? values[1:n[]] : nothing
end

"""
    georec(lon, lat, alt, re, f)

Convert geodetic coordinates to rectangular coordinates.

### Arguments ###

- `lon`: Geodetic longitude of point (radians)
- `lat`: Geodetic latitude  of point (radians)
- `alt`: Altitude of point above the reference spheroid
- `re`: Equatorial radius of the reference spheroid
- `f`: Flattening coefficient

### Output ###

Returns the rectangular coordinates of point.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/georec_c.html)
"""
function georec(lon, lat, alt, re, f)
    rectan = Array{SpiceDouble}(undef, 3)
    ccall((:georec_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble, SpiceDouble,
           Ref{SpiceDouble}),
          lon, lat, alt, re, f, rectan)
    handleerror()
    rectan
end

"""
    getelm(frstyr, lines)

Given the "lines" of a two-line element set, parse the lines and return the elements in units
suitable for use in SPICE software.

### Arguments ###

- `frstyr`: Year of earliest representable two-line elements
- `lines`: A pair of "lines" containing two-line elements

### Output ###

- `epoch`: The epoch of the elements in seconds past J2000
- `elems`: The elements converted to SPICE units

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/getelm_c.html)
"""
function getelm(frstyr, lines)
    lines_, _, lineln = chararray(lines)
    epoch = Ref{SpiceDouble}()
    elems = Array{SpiceDouble}(undef, 10)
    ccall((:getelm_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{SpiceChar}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          frstyr, lineln, lines_, epoch, elems)
    handleerror()
    epoch[], elems
end

"""
    getfat(file, arclen=10, typlen=10)

Determine the file architecture and file type of most SPICE kernel files.

### Arguments ###

- `file`: The name of a file to be examined
- `arclen`: Maximum length of output architecture string (default: 10)
- `typlen`: Maximum length of output type string (default: 10)

### Output ###

- `arch`: The architecture of the kernel file
- `typ`: The type of the kernel file

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/getfat_c.html)
"""
function getfat(file, arclen=10, typlen=10)
    arch = Array{SpiceChar}(undef, arclen)
    typ = Array{SpiceChar}(undef, typlen)
    ccall((:getfat_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceChar}, Ref{SpiceChar}),
          file, arclen, typlen, arch, typ)
    handleerror()
    chararray_to_string(arch), chararray_to_string(typ)
end

"""
    getfov(instid, room=10, shapelen=128, framelen=128)

Return the field-of-view (FOV) parameters for a specified instrument.
The instrument is specified by its NAIF ID code.

### Arguments ###

- `instid  `: NAIF ID of an instrument
- `room    `: Maximum number of vectors that can be returned (default: 10)
- `shapelen`: Space available in the string `shape` (default: 128)
- `framelen`: Space available in the string `frame` (default: 128)

### Output ###

Returns a tuple consisting of

- `shape `: Instrument FOV shape
- `frame `: Name of the frame in which FOV vectors are defined
- `bsight`: Boresight vector
- `bounds`: FOV boundary vectors

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/getfov_c.html)
"""
function getfov(instid, room=10, shapelen=128, framelen=128)
    shape = Array{SpiceChar}(undef, shapelen)
    frame = Array{SpiceChar}(undef, framelen)
    bsight = Array{SpiceDouble}(undef, 3)
    n = Ref{SpiceInt}()
    bounds = Array{SpiceDouble}(undef, 3, room)
    ccall((:getfov_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceChar}, Ref{SpiceChar}, Ref{SpiceDouble}, Ref{SpiceInt}, Ref{SpiceDouble}),
          instid, room, shapelen, framelen, shape, frame, bsight, n, bounds)
    handleerror()
    arr_bounds = cmatrix_to_array(bounds)
    shp = chararray_to_string(shape)
    frm = chararray_to_string(frame)
    shp, frm, bsight, arr_bounds[1:n[]]
end

"""
    gfdist(target, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine)

Return the time window over which a specified constraint on observer-target distance is met.

### Arguments ###

- `target`: Name of the target body
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `relate`: Relational operator
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is confined

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfdist_c.html)
"""
function gfdist(target, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine)
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfdist_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, SpiceDouble, SpiceDouble, SpiceDouble,
           SpiceInt, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          target, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gfilum(method, angtyp, target, illmn, fixref, abcorr, obsrvr, spoint, relate, refval,
           adjust, step, nintvls, cnfine)


Return the time window over which a specified constraint on the observed phase, solar incidence,
or emission angle at a specifed target body surface point is met.

### Arguments ###

- `method`: Computation method
- `angtyp`: Type of illumination angle
- `target`: Name of the target body
- `illmn `: Name of the illumination source
- `fixref`: Body-fixed, body-centered target body frame
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `spoint`: Body-fixed coordinates of a target surface point
- `relate`: Relational operator
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is confined

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfilum_c.html)
"""
function gfilum(method, angtyp, target, illmn, fixref, abcorr, obsrvr, spoint, relate, refval,
                adjust, step, nintvls, cnfine)
    @checkdims 3 spoint
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfilum_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Ref{SpiceDouble},
           Cstring, SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          method, angtyp, target, illmn, fixref, abcorr, obsrvr, spoint, relate, refval, adjust,
          step, nintvls, cnfine.cell, result.cell)
    handleerror()
    result
end

"""



### Arguments ###

   occtyp     I   Type of occultation. 
   front      I   Name of body occulting the other. 
   fshape     I   Type of shape model used for front body. 
   fframe     I   Body-fixed, body-centered frame for front body. 
   back       I   Name of body occulted by the other. 
   bshape     I   Type of shape model used for back body. 
   bframe     I   Body-fixed, body-centered frame for back body. 
   abcorr     I   Aberration correction flag. 
   obsrvr     I   Name of the observing body. 
   tol        I   Convergence tolerance in seconds. 
   udstep     I   Name of the routine that returns a time step. 
   udrefn     I   Name of the routine that computes a refined time. 
   rpt        I   Progress report flag. 
   udrepi     I   Function that initializes progress reporting. 
   udrepu     I   Function that updates the progress report. 
   udrepf     I   Function that finalizes progress reporting. 
   bail       I   Logical indicating program interrupt monitoring. 
   udbail     I   Name of a routine that signals a program interrupt. 
   cnfine    I-O  SPICE window to which the search is restricted. 
   result     O   SPICE window containing results. 

### Output ###


### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/XXX_c.html)
"""
function gfocce()
    #= +   void gfocce_c ( ConstSpiceChar     * occtyp, =#
    #=                ConstSpiceChar     * front, =#
    #=                ConstSpiceChar     * fshape, =#
    #=                ConstSpiceChar     * fframe, =#
    #=                ConstSpiceChar     * back, =#
    #=                ConstSpiceChar     * bshape, =#
    #=                ConstSpiceChar     * bframe, =#
    #=                ConstSpiceChar     * abcorr, =#
    #=                ConstSpiceChar     * obsrvr, =#
    #=                SpiceDouble          tol, =#
    #=  =#
    #=                void             ( * udstep ) ( SpiceDouble       et, =#
    #=                                                SpiceDouble     * step ), =#
    #=  =#
    #=                void             ( * udrefn ) ( SpiceDouble       t1, =#
    #=                                                SpiceDouble       t2, =#
    #=                                                SpiceBoolean      s1, =#
    #=                                                SpiceBoolean      s2, =#
    #=                                                SpiceDouble     * t    ), =#
    #=                SpiceBoolean         rpt,   =#
    #=  =#
    #=                void             ( * udrepi ) ( SpiceCell       * cnfine, =#
    #=                                                ConstSpiceChar  * srcpre, =#
    #=                                                ConstSpiceChar  * srcsuf ), =#
    #=  =#
    #=                void             ( * udrepu ) ( SpiceDouble       ivbeg, =#
    #=                                                SpiceDouble       ivend, =#
    #=                                                SpiceDouble       et      ), =#
    #=  =#
    #=                void             ( * udrepf ) ( void ), =#
    #=                SpiceBoolean         bail,       =#
    #=                SpiceBoolean     ( * udbail ) ( void ), =#
    #=                SpiceCell          * cnfine, =#
    #=                SpiceCell          * result                                ) =#
end

"""
    gfoclt(occtyp, front, fshape, fframe, back, bshape, bframe, abcorr, obsrvr, step, cnfine,
           maxwin=100)

Determine time intervals when an observer sees one target occulted by, or in transit across,
another.

The surfaces of the target bodies may be represented by triaxial ellipsoids or by topographic data
provided by DSK files.

### Arguments ###

- `occtyp`: Type of occultation
- `front`: Name of body occulting the other
- `fshape`: Type of shape model used for front body
- `fframe`: Body-fixed, body-centered frame for front body
- `back`: Name of body occulted by the other
- `bshape`: Type of shape model used for back body
- `bframe`: Body-fixed, body-centered frame for back body
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `step`: Step size in seconds for finding occultation events
- `cnfine`: Window to which the search is restricted
- `maxwin`: Maximum size of the output window (default: 100)

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfoclt_c.html)
"""
function gfoclt(occtyp, front, fshape, fframe, back, bshape, bframe, abcorr, obsrvr, step, cnfine, maxwin=100)
    result = SpiceDoubleCell(maxwin * 2)
    ccall((:gfoclt_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring,
           SpiceDouble, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          occtyp, front, fshape, fframe, back, bshape, bframe, abcorr, obsrvr, step, cnfine.cell,
          result.cell)
    handleerror()
    result
end

"""
    gfpa(result, target, illmn, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine)

Determine time intervals for which a specified constraint on the phase angle between an
illumination source, a target, and observer body centers is met.

### Arguments ###

- `target`: Name of the target body
- `illmn`: Name of the illuminating body
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `relate`: Relational operator
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is confined

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfpa_c.html)
"""
function gfpa(target, illmn, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine)
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfpa_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring,
           SpiceDouble, SpiceDouble, SpiceDouble,
           SpiceInt,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          target, illmn, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gfposc(target, frame, abcorr, obsrvr, crdsys, coord, relate, refval, adjust, step,
           nintvls, cnfine)

Determine time intervals for which a coordinate of an observer-target position vector satisfies a
numerical constraint.

### Arguments ###

- `target`: Name of the target body
- `frame`: Name of the reference frame for coordinate calculations
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `crdsys`: Name of the coordinate system containing `coord`
- `coord`: Name of the coordinate of interest
- `relate`: Operator that either looks for an extreme value (max, min, local, absolute) or compares
    the coordinate value and refval
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is restricted

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfposc_c.html)
"""
function gfposc(target, frame, abcorr, obsrvr, crdsys, coord, relate, refval, adjust, step,
                nintvls, cnfine)
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfposc_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, SpiceDouble, SpiceDouble,
           SpiceDouble, SpiceInt, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          target, frame, abcorr, obsrvr, crdsys, coord, relate, refval, adjust, step, nintvls,
          cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gfrfov(inst, raydir, rframe, abcorr, obsrvr, step, cnfine, maxwin=10000)

Determine time intervals when a specified ray intersects the space bounded by the
field-of-view (FOV) of a specified instrument.

### Arguments ###

- `inst`: Name of the instrument
- `raydir`: Ray's direction vector
- `rframe`: Reference frame of ray's direction vector
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `step`: Step size in seconds for finding FOV events
- `cnfine`: SPICE window to which the search is restricted
- `maxwin`: Maximum length of the output window (default: 10000)

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfrfov_c.html)
"""
function gfrfov(inst, raydir, rframe, abcorr, obsrvr, step, cnfine, maxwin=10000)
    @checkdims 3 raydir
    result = SpiceDoubleCell(maxwin)
    ccall((:gfrfov_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceDouble}, Cstring, Cstring, Cstring, SpiceDouble,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          inst, raydir, rframe, abcorr, obsrvr, step, cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gfrr(target, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine)

Determine time intervals for which a specified constraint on the observer-target range rate is met.

### Arguments ###

- `target`: Name of the target body
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `relate`: Relational operator
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is confined

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfrr_c.html)
"""
function gfrr(target, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine)
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfrr_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          target, abcorr, obsrvr, relate, refval, adjust, step, nintvls, cnfine.cell, result.cell)
    handleerror()
    result
end

"""

Determine time intervals when the angular separation between the position vectors of two target
bodies relative to an observer satisfies a numerical relationship.

### Arguments ###

- `targ1`: Name of first body
- `shape1`: Name of shape model describing the first body
- `frame1`: The body-fixed reference frame of the first body
- `targ2`: Name of second body
- `shape2`: Name of the shape model describing the second body
- `frame2`: The body-fixed reference frame of the second body
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `relate`: Operator that either looks for an extreme value (max, min, local, absolute) or compares
    the angular separation value and refval
- `refval`: Reference value
- `adjust`: Absolute extremum adjustment value
- `step`: Step size in seconds for finding angular separation events
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is restricted

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfsep_c.html)
"""
function gfsep(targ1, shape1, frame1, targ2, shape2, frame2, abcorr, obsrvr, relate, refval, adjust,
               step, nintvls, cnfine)
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfsep_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring,
           SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          targ1, shape1, frame1, targ2, shape2, frame2, abcorr, obsrvr, relate, refval, adjust,
          step, nintvls, cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gfsntc(target, fixref, method, abcorr, obsrvr, dref, dvec, crdsys, coord, relate, refval,
           adjust, step, nintvls, cnfine)

Determine time intervals for which a coordinate of an surface intercept position vector satisfies
a numerical constraint.

### Arguments ###

- `target`: Name of the target body
- `fixref`: Body fixed frame associated with `target`
- `method`: Name of method type for surface intercept calculation
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `dref`: Reference frame of direction vector `dvec`
- `dvec`: Pointing direction vector from `obsrvr`
- `crdsys`: Name of the coordinate system containing COORD
- `coord`: Name of the coordinate of interest
- `relate`: Operator that either looks for an extreme value (max, min, local, absolute) or compares the coordinate value and `refval`
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is restricted

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfsntc_c.html)
"""
function gfsntc(target, fixref, method, abcorr, obsrvr, dref, dvec, crdsys, coord, relate, refval,
                adjust, step, nintvls, cnfine)
    @checkdims 3 dvec
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfsntc_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Ref{SpiceDouble}, Cstring,
           Cstring, Cstring, SpiceDouble, SpiceDouble, SpiceDouble, SpiceInt,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          target, fixref, method, abcorr, obsrvr, dref, dvec, crdsys, coord, relate, refval,
          adjust, step, nintvls, cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gfsstp(step)

Set the step size to be returned by [`gfstep`](@ref).

### Arguments ###

- `step`: Time step to take

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfsstp_c.html)
"""
function gfsstp(step)
    ccall((:gfsstp_c, libcspice), Cvoid, (SpiceDouble,), step)
    handleerror()
end

function _gfstep(time)
    step = Ref{SpiceDouble}()
    ccall((:gfstep_c, libcspice), Cvoid,
          (SpiceDouble, Ref{SpiceDouble}),
          time, step)
    handleerror()
    step[]
end

"""
    gfstol(value)

Override the default GF convergence value used in the high level GF routines.

### Arguments ###

- `value`: Double precision value returned or to store

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfstol_c.html)
"""
function gfstol(value)
    ccall((:gfstol_c, libcspice), Cvoid, (SpiceDouble,), value)
    handleerror()
end

"""
    gfsubc(target, fixref, method, abcorr, obsrvr, crdsys, coord, relate, refval, adjust, step,
           nintvls, cnfine)

Determine time intervals for which a coordinate of an subpoint position vector satisfies a
numerical constraint.

### Arguments ###

- `target`: Name of the target body
- `fixref`: Body fixed frame associated with `target`
- `method`: Name of method type for subpoint calculation
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `crdsys`: Name of the coordinate system containing `coord`
- `coord`: Name of the coordinate of interest
- `relate`: Operator that either looks for an extreme value (max, min, local, absolute) or compares
    the coordinate value and refval
- `refval`: Reference value
- `adjust`: Adjustment value for absolute extrema searches
- `step`: Step size used for locating extrema and roots
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is restricted

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gfsubc_c.html)
"""
function gfsubc(target, fixref, method, abcorr, obsrvr, crdsys, coord, relate, refval, adjust, step,
                nintvls, cnfine)
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gfsubc_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, SpiceDouble,
           SpiceDouble, SpiceDouble, SpiceInt, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          target, fixref, method, abcorr, obsrvr, crdsys, coord, relate, refval, adjust, step,
          nintvls, cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gftfov(inst, target, tshape, tframe, abcorr, obsrvr, step, nintvls, cnfine)

Determine time intervals when a specified ephemeris object intersects the space bounded by the
field-of-view (FOV) of a specified instrument.

### Arguments ###

- `inst`: Name of the instrument
- `target`: Name of the target body
- `tshape`: Type of shape model used for target body
- `tframe`: Body-fixed, body-centered frame for target body
- `abcorr`: Aberration correction flag
- `obsrvr`: Name of the observing body
- `step`: Step size in seconds for finding FOV events
- `nintvls`: Workspace window interval count
- `cnfine`: Window to which the search is restricted

### Output ###

Returns a window containing the results.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gftfov_c.html)
"""
function gftfov(inst, target, tshape, tframe, abcorr, obsrvr, step, nintvls, cnfine)
    result = SpiceDoubleCell(nintvls * 2)
    ccall((:gftfov_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, SpiceDouble,
           Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          inst, target, tshape, tframe, abcorr, obsrvr, step, cnfine.cell, result.cell)
    handleerror()
    result
end

"""
    gipool(name; start=1, room=100)

Return the value of a kernel variable from the kernel pool.

### Arguments ###

- `name`: Name of the variable whose value is to be returned
- `start`: Which component to start retrieving for name (default: 1)
- `room`: The largest number of values to return (default: 100)

### Output ###

Returns an array of values if the variable exists or `nothing` if not.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gipool_c.html)
"""
function gipool(name; start=1, room=100)
    n = Ref{SpiceInt}()
    values = Array{SpiceInt}(undef, room)
    found = Ref{SpiceBoolean}()
    ccall((:gipool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceBoolean}),
          name, start - 1, room, n, values, found)
    handleerror()
    Bool(found[]) ? Int.(values[1:n[]]) : nothing
end

"""
    gnpool(name, start, room, lenout=128)

Return names of kernel variables matching a specified template.

### Arguments ###

- `name`: Template that names should match
- `start`: Index of first matching name to retrieve
- `room`: The largest number of values to return
- `lenout`: Length of strings in output array `kvars` (default: 128)

### Output ###

Returns lernel pool variables whose names match `name`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/gnpool_c.html)
"""
function gnpool(name, start, room, lenout=128)
    n = Ref{SpiceInt}()
    kvars = Array{SpiceChar}(undef, lenout, room)
    found = Ref{SpiceBoolean}()
    ccall((:gnpool_c, libcspice), Cvoid,
          (Cstring, SpiceInt, SpiceInt, SpiceInt,
           Ref{SpiceInt}, Ref{SpiceChar}, Ref{SpiceBoolean}),
          name, start - 1, room, lenout, n, kvars, found)
    handleerror()
    Bool(found[]) || return nothing
    chararray_to_string(kvars)[1:n[]]
end

