export
    fovray,
    fovtrg,
    frame,
    frinfo,
    frmnam,
    ftncls,
    furnsh

"""
    fovray(inst, raydir, rframe, abcorr, observer, et)

Determine if a specified ray is within the field-of-view (FOV) of a specified instrument
at a given time.

### Arguments ###

- `inst`: Name or ID code string of the instrument
- `raydir`: Ray's direction vector
- `rframe`: Body-fixed, body-centered frame for target body
- `abcorr`: Aberration correction flag
- `observer`: Name or ID code string of the observer
- `et`: Time of the observation (seconds past J2000)

### Output ###

Returns `true` if the ray is visible.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/fovray_c.html)
"""
function fovray(inst, raydir, rframe, abcorr, observer, et)
    @checkdims 3 raydir
    visible = Ref{SpiceBoolean}()
    ccall((:fovray_c, libcspice), Cvoid,
          (Cstring, Ref{SpiceDouble}, Cstring, Cstring, Cstring, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          inst, raydir, rframe, abcorr, observer, et, visible)
    handleerror()
    Bool(visible[])
end

"""
    fovtrg(inst, target, tshape, tframe, abcorr, obsrvr, et)

Determine if a specified ephemeris object is within the field-of-view (FOV) of a specified
instrument at a given time.

### Arguments ###

- `inst`: Name or ID code string of the instrument.
- `target`: Name or ID code string of the target.
- `tshape`: Type of shape model used for the target.
- `tframe`: Body-fixed, body-centered frame for target body.
- `abcorr`: Aberration correction flag.
- `obsrvr`: Name or ID code string of the observer.
- `et`: Time of the observation (seconds past J2000).

### Output ###

Returns `true` if the object is visible.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/fovtrg_c.html)
"""
function fovtrg(inst, target, tshape, tframe, abcorr, obsrvr, et)
    visible = Ref{SpiceBoolean}()
    ccall((:fovtrg_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, Cstring, Cstring, Cstring, Ref{SpiceDouble}, Ref{SpiceBoolean}),
          inst, target, tshape, tframe, abcorr, obsrvr, et, visible)
    handleerror()
    Bool(visible[])
end

"""
    frame(x)

Given a vector `x`, this routine builds a right handed orthonormal frame `x`, `y`, `z`
where the output `x` is parallel to the input `x`.

### Arguments ###

- `x`: Input vector

### Output ###

- `x`: Unit vector parallel to `x` on output
- `y`: Unit vector in the plane orthogonal to `x`
- `z`: Unit vector given by `x × y`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/frame_c.html)
"""
function frame(x)
    @checkdims 3 x
    x = copy(x)
    y = Array{SpiceDouble}(undef, 3)
    z = Array{SpiceDouble}(undef, 3)
    ccall((:frame_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          x, y, z)
    x, y, z
end

"""
    frinfo(frcode)

Retrieve the minimal attributes associated with a frame needed for converting transformations
to and from it.

### Arguments ###

- `frcode`: The id code for a reference frame

### Output ###

- `cent`: The center of the frame
- `frclss`: The class (type) of the frame
- `clssid`: The idcode for the frame within its class

Returns `nothing` if no frame with id `frcode` could be found.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/frinfo_c.html)
"""
function frinfo(frcode)
    cent = Ref{SpiceInt}()
    frclss = Ref{SpiceInt}()
    clssid = Ref{SpiceInt}()
    found = Ref{SpiceBoolean}()
    ccall((:frinfo_c, libcspice), Cvoid,
          (SpiceInt, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceInt}, Ref{SpiceBoolean}),
          frcode, cent, frclss, clssid, found)

    Bool(found[]) || return nothing
    Int(cent[]), Int(frclss[]), Int(clssid[])
end

"""
    frmnam(frcode)

Retrieve the name of a reference frame associated with an id code.

### Arguments ###

- `frcode`: The id code for a reference frame

### Output ###

Returns the name associated with the reference frame.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/frmnam_c.html)
"""
function frmnam(frcode)
    lenout = 33
    frname = Array{SpiceChar}(undef, lenout)
    ccall((:frmnam_c, libcspice), Cvoid, (SpiceInt, SpiceInt, Ref{SpiceChar}),
          frcode, lenout, frname)
    chararray_to_string(frname)
end

@deprecate ftncls close

"""
    furnsh(kernels...)

Load one or more SPICE kernels into a program.

### Arguments ###

- `kernels`: Path(s) of SPICE kernels to load

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/furnsh_c.html)
"""
function furnsh(kernels...)
    for kernel in kernels
        ccall((:furnsh_c, libcspice), Cvoid, (Cstring,), kernel)
        handleerror()
    end
end
