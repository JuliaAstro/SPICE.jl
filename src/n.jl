export
    namfrm,
    ncpos,
    ncposr,
    nearpt,
    npedln,
    npelpt,
    nplnpt,
    nvc2pl,
    nvp2pl

"""
    namfrm(frname)

Look up the frame ID code associated with a string.

### Arguments ###

- `frname`: The name of some reference frame

### Output ###

The SPICE ID code of the frame.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/namfrm_c.html)
"""
function namfrm(frname)
    frcode = Ref{SpiceInt}()
    ccall((:namfrm_c, libcspice), Cvoid, (Cstring, Ref{SpiceInt}), frname, frcode)
    handleerror()
    Int(frcode[])
end

"""
    ncpos(str, chars, start)


Find the first occurrence in a string of a character NOT belonging to a
collection of characters, starting at a specified location, searching forward.

### Arguments ###

- `str`: A string
- `chars`: A collection of characters
- `start`: Position to begin looking for a character not in `chars`

### Output ###

Returns the index of the first character of `str` at or following index `start`
that is not in the collection `chars`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ncpos_c.html)
"""
function ncpos(str, chars, start)
    res = ccall((:ncpos_c, libcspice), SpiceInt, (Cstring, Cstring, Cint),
          str, String(chars), start - 1)
    handleerror()
    Int(res) + 1
end

"""
    ncposr(str, chars, start)

Find the first occurrence in a string of a character NOT belonging to a
collection of characters, starting at a specified location, searching
in reverse.

### Arguments ###

- `str`: A string
- `chars`: A collection of characters
- `start`: Position to begin looking for a character not in `chars`

### Output ###

Returns the index of the last character of `str` at or before index `start`
that is not in the collection `chars`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ncposr_c.html)
"""
function ncposr(str, chars, start)
    res = ccall((:ncposr_c, libcspice), SpiceInt, (Cstring, Cstring, SpiceInt),
          str, String(chars), start - 1)
    handleerror()
    Int(res) + 1
end

"""
    nearpt(positn, a, b, c)

This routine locates the point on the surface of an ellipsoid that is nearest
to a specified position. It also returns the altitude of the position above
the ellipsoid.

### Arguments ###

- `positn`: Position of a point in the bodyfixed frame
- `a`: Length of semi-axis parallel to x-axis
- `b`: Length of semi-axis parallel to y-axis
- `c`: Length on semi-axis parallel to z-axis

### Output ###

Returns a tuple consisting of `npoint` and `alt`.

- `npoint`: Point on the ellipsoid closest to `positn`
- `alt`: Altitude of `positn` above the ellipsoid

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/nearpt_c.html)
"""
function nearpt(positn, a, b, c)
    @checkdims 3 positn
    npoint = Array{SpiceDouble}(undef, 3)
    alt = Ref{SpiceDouble}()
    ccall((:nearpt_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, SpiceDouble, SpiceDouble,
           Ref{SpiceDouble}, Ref{SpiceDouble}),
          collect(positn), a, b, c, npoint, alt)
    handleerror()
    npoint, alt[]
end

"""
    npedln(a, b, c, linept, linedr)

Find nearest point on a triaxial ellipsoid to a specified line, and the
distance from the ellipsoid to the line.

### Arguments ###

- `a`: Length of semi-axis in the x direction
- `b`: Length of semi-axis in the y direction
- `c`: Length of semi-axis in the z direction
- `linept`: Point on line
- `linedr`: Direction vector of line

### Output ###

Returns a tuple consisting of `pnear` and `dist`.

- `pnear`: Nearest point on ellipsoid to line
- `dist`: Distance of ellipsoid from line

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/npedln_c.html)
"""
function npedln(a, b, c, linept, linedr)
    @checkdims 3 linept linedr
    pnear = Array{SpiceDouble}(undef, 3)
    dist = Ref{SpiceDouble}()
    ccall((:npedln_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, SpiceDouble, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          a, b, c, collect(linept), collect(linedr), pnear, dist)
    handleerror()
    pnear, dist[]
end

"""
    npelpt(point, ellips)

Find the nearest point on an ellipse to a specified point, both in
three-dimensional space, and find the distance between the ellipse
and the point.

### Arguments ###

- `point`: Point whose distance to an ellipse is to be found
- `ellips`: A SPICE ellipse

### Output ###

Returns a tuple consisting of `pnear` and `dist`.

- `pnear`: Nearest point on ellipse to input point
- `dist`: Distance of input point to ellipse

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/npelpt_c.html)
"""
function npelpt(point, ellips)
    @checkdims 3 point
    pnear = Array{SpiceDouble}(undef, 3)
    dist = Ref{SpiceDouble}()
    ccall((:npelpt_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{Ellipse}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          collect(point), ellips, pnear, dist)
    handleerror()
    pnear, dist[]
end

"""
    nplnpt(linept, linedr, point)

Find the nearest point on a line to a specified point, and find the distance
between the two points.

### Arguments ###

- `linept`: Point on line
- `linedr`: Direction vector of line
- `point`: A second point

### Output ###

Returns a tuple consisting of `pnear` and `dist`.

- `pnear`: Nearest point on the line to `point`
- `dist`: Distance between `point` and `pnear`

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/nplnpt_c.html)
"""
function nplnpt(linept, linedr, point)
    @checkdims 3 linept linedr point
    pnear = Array{SpiceDouble}(undef, 3)
    dist = Ref{SpiceDouble}()
    ccall((:nplnpt_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceDouble}),
          collect(linept), collect(linedr), collect(point), pnear, dist)
    handleerror()
    pnear, dist[]
end

"""
    nvc2pl(norm, point)

Make a SPICE plane from a normal vector and a point.

### Arguments ###

- `norm`: A normal vector...
- `constant`: ...and a constant defining a plane

### Output ###

Returns a struct representing the plane.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/nvc2pl_c.html)
"""
function nvc2pl(norm, constant)
    @checkdims 3 norm
    plane = Ref{Plane}()
    ccall((:nvc2pl_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, SpiceDouble, Ref{Plane}), collect(norm), constant, plane)
    handleerror()
    plane[]
end

"""
    nvp2pl(norm, point)

Make a SPICE plane from a normal vector and a point.

### Arguments ###

- `norm`: A normal vector...
- `point`: ...and a point defining a plane

### Output ###

Returns a struct representing the plane.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/nvp2pl_c.html)
"""
function nvp2pl(norm, orig)
    @checkdims 3 norm orig
    plane = Ref{Plane}()
    ccall((:nvp2pl_c, libcspice), Cvoid,
          (Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{Plane}),
          collect(norm), collect(orig), plane)
    handleerror()
    plane[]
end

