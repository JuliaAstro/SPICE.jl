export 
    ilumin,
    illumg

"""
    ilumin(method, target, et, fixref, obsrvr, spoint, abcorr)

Find the illumination angles (phase, solar incidence, and emission) at a specified surface point of a target body.
This routine supersedes illum_c.

### Arguments ###

- `method`: Computation method. 
- `target`: Name of target body. 
- `et`: Epoch in ephemeris seconds past J2000 TDB. 
- `fixref`: Body-fixed, body-centered target body frame.  
- `obsrvr`: Name of observing body. 
- `spoint`: Body-fixed coordinates of a target surface point.
- `abcorr`: Aberration correction.

### Output ###

- `trgepc`: Sub-solar point epoch. 
- `srfvec`: Vector from observer to sub-solar point.
- `phase`: Phase angle at the surface point. 
- `incdnc`: Solar incidence angle at the surface point. 
- `emissn`: Emission angle at the surface point. 

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ilumin_c.html
"""
function ilumin(method, target, et, fixref, obsrvr, spoint; abcorr="NONE")
    trgepc = Ref{SpiceDouble}(0)
    srfvec = Array{SpiceDouble}(undef, 3)
    phase  = Ref{SpiceDouble}(0)
    incdnc = Ref{SpiceDouble}(0)
    emissn = Ref{SpiceDouble}(0)
    ccall((:ilumin_c, libcspice), Cvoid,
          (Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          method, target, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec, phase, incdnc, emissn) 
    handleerror()
    trgepc[], srfvec, phase[], incdnc[], emissn[]
end

"""
    illumg(method, target, ilusrc, et, fixref, obsrvr, spoint, abcorr)

Find the illumination angles (phase, incidence, and emission) at a specified surface point of a target body. 
  
The surface of the target body may be represented by a triaxial ellipsoid or by topographic data provided by DSK files. 
  
The illumination source is a specified ephemeris object. 

### Arguments ###

- `method`: Computation method. 
- `target`: Name of target body. 
- `ilusrc`: Name of illumination source.
- `et`: Epoch in ephemeris seconds past J2000 TDB. 
- `fixref`: Body-fixed, body-centered target body frame.  
- `obsrvr`: Name of observing body. 
- `spoint`: Body-fixed coordinates of a target surface point.
- `abcorr`: Aberration correction.

### Output ###

- `trgepc`: Sub-solar point epoch. 
- `srfvec`: Vector from observer to sub-solar point.
- `phase`: Phase angle at the surface point. 
- `incdnc`: Solar incidence angle at the surface point. 
- `emissn`: Emission angle at the surface point. 

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/illumg_c.html
"""
function illumg(method, target, ilusrc, et, fixref, obsrvr, spoint; abcorr="NONE")
    trgepc = Ref{SpiceDouble}(0)
    srfvec = Array{SpiceDouble}(undef, 3)
    phase  = Ref{SpiceDouble}(0)
    incdnc = Ref{SpiceDouble}(0)
    emissn = Ref{SpiceDouble}(0)
    ccall((:illumg_c, libcspice), Cvoid,
          (Cstring, Cstring, Cstring, SpiceDouble, Cstring, Cstring, Cstring, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ptr{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}, Ref{SpiceDouble}),
          method, target, ilusrc, et, fixref, abcorr, obsrvr, spoint, trgepc, srfvec, phase, incdnc, emissn) 
    handleerror()
    trgepc[], srfvec, phase[], incdnc[], emissn[]
end