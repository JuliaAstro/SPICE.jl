var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "api/#",
    "page": "API",
    "title": "API",
    "category": "page",
    "text": ""
},

{
    "location": "api/#SPICE.SpiceCharCell",
    "page": "API",
    "title": "SPICE.SpiceCharCell",
    "category": "type",
    "text": "SpiceCharCell(size, length)\n\nCreate a SpiceCharCell that can contain up to size strings with length characters.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.SpiceDoubleCell",
    "page": "API",
    "title": "SPICE.SpiceDoubleCell",
    "category": "type",
    "text": "SpiceDoubleCell(size)\n\nCreate a SpiceDoubleCell that can contain up to size elements.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.SpiceIntCell",
    "page": "API",
    "title": "SPICE.SpiceIntCell",
    "category": "type",
    "text": "SpiceIntCell(size)\n\nCreate a SpiceIntCell that can contain up to size elements.\n\n\n\n\n\n"
},

{
    "location": "api/#Base.append!-Tuple{SPICE.SpiceCell,Any}",
    "page": "API",
    "title": "Base.append!",
    "category": "method",
    "text": "append!(cell, collection)\n\nAppend all items from collection to the char/double/integer SpiceCell cell.\n\n\n\n\n\n"
},

{
    "location": "api/#Base.copy-Union{Tuple{SpiceCell{T,T1,N} where N where T1}, Tuple{T}} where T",
    "page": "API",
    "title": "Base.copy",
    "category": "method",
    "text": "copy(cell::SpiceCell)\n\nDuplicate the SpiceCell cell.\n\n\n\n\n\n"
},

{
    "location": "api/#Base.length-Tuple{SPICE.SpiceCell}",
    "page": "API",
    "title": "Base.length",
    "category": "method",
    "text": "length(cell)\n\nReturns the cardinality (number of elements) of cell.\n\n\n\n\n\n"
},

{
    "location": "api/#Base.push!-Tuple{SPICE.SpiceCell,Vararg{Any,N} where N}",
    "page": "API",
    "title": "Base.push!",
    "category": "method",
    "text": "push!(cell, items...)\n\nInsert one or more items at the end of the char/double/integer SpiceCell cell.\n\n\n\n\n\n"
},

{
    "location": "api/#Base.union-Union{Tuple{T}, Tuple{SpiceCell{T,T1,N} where N where T1,SpiceCell{T,T1,N} where N where T1}} where T",
    "page": "API",
    "title": "Base.union",
    "category": "method",
    "text": "union(a::T, b::T) where T <: SpiceCell\n\nCompute the union of two sets of any data type to form a third set.\n\nArguments\n\na: First input set\nb: Second input set\n\nOutput\n\nReturns a cell containing the union of a and b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.appnd-Tuple{Any,SPICE.SpiceCell{UInt8,T,N} where N where T}",
    "page": "API",
    "title": "SPICE.appnd",
    "category": "method",
    "text": "appnd(item, cell)\n\nAppend an item to the char/double/integer SpiceCell cell.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/appndcc.html https://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/appnddc.html https://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/appndic.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.axisar-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.axisar",
    "category": "method",
    "text": "axisar(axis, angle)\n\nConstruct a rotation matrix that rotates vectors by a specified angle about a specified axis.\n\nArguments\n\naxis: Rotation axis\nangle: Rotation angle in radians\n\nOutput\n\nRotation matrix corresponding to axis and angle\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.b1900-Tuple{}",
    "page": "API",
    "title": "SPICE.b1900",
    "category": "method",
    "text": "b1900()\n\nReturns the Julian Date corresponding to Besselian date 1900.0.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.b1950-Tuple{}",
    "page": "API",
    "title": "SPICE.b1950",
    "category": "method",
    "text": "b1950()\n\nReturns the Julian Date corresponding to Besselian date 1950.0.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.badkpv-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.badkpv",
    "category": "method",
    "text": "badkpv(caller, name, comp, size, divby, typ)\n\nDetermine if a kernel pool variable is present and if so that it has the correct size and type.\n\nArguments\n\ncaller: Name of the routine calling this routine\nname: Name of a kernel pool variable\ncomp: Comparison operator\nsize: Expected size of the kernel pool variable\ndivby: A divisor of the size of the kernel pool variable\ntype: Expected type of the kernel pool variable\n\nOutput\n\nThe function returns false if the kernel pool variable is OK otherwise an exception is thrown.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bltfrm-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bltfrm",
    "category": "method",
    "text": "bltfrm(frmcls)\n\nReturn a SPICE set containing the frame IDs of all built-in frames of a specified class.\n\nArguments\n\nfrmcls: Frame class\n\nOutput\n\nidset: Set of ID codes of frames of the specified class\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bodc2n-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bodc2n",
    "category": "method",
    "text": "bodc2n(code)\n\nTranslate the SPICE integer code of a body into a common name for that body.\n\nArguments\n\ncode: Integer ID code to be translated into a name\n\nOutput\n\nname: A common name for the body identified by code\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bodc2s-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bodc2s",
    "category": "method",
    "text": "bodc2s(code)\n\nTranslate a body ID code to either the corresponding name or if no name to ID code mapping exists, the string representation of the body ID value.\n\nArguments\n\ncode: Integer ID code to translate to a string\n\nOutput\n\nname: String corresponding to code\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.boddef-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.boddef",
    "category": "method",
    "text": "boddef(name, code)\n\nDefine a body name/ID code pair for later translation via bodn2c or bodc2n.\n\nArguments\n\nname: Common name of some body\ncode: Integer code for that body\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bodfnd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.bodfnd",
    "category": "method",
    "text": "bodfnd(body, item)\n\nDetermine whether values exist for some item for any body in the kernel pool.\n\nArguments\n\nbody: ID code of body\nitem: Item to find (\"RADII\", \"NUTAMPRA\", etc.)\n\nOutput\n\nfound: true if the item is in the kernel pool and false if it is not.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bodn2c-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bodn2c",
    "category": "method",
    "text": "bodn2c(name)\n\nTranslate the name of a body or object to the corresponding SPICE integer ID code.\n\nArguments\n\nname: Body name to be translated into a SPICE ID code\n\nOutput\n\ncode: SPICE integer ID code for the named body\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bods2c-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bods2c",
    "category": "method",
    "text": "bods2c(name)\n\nTranslate a string containing a body name or ID code to an integer code.\n\nArguments\n\nname: String to be translated to an ID code\n\nOutput\n\ncode: Integer ID code corresponding to name\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bodvcd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.bodvcd",
    "category": "method",
    "text": "bodvcd(bodyid, item)\n\nFetch from the kernel pool the double precision values of an item associated with a body, where the body is specified by an integer ID code.\n\nArguments\n\nbodyid: Body ID code\nitem: Item for which values are desired. (\"RADII\", \"NUTPRECANGLES\", etc.)\n\nOutput\n\nvalues: Values\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bodvrd",
    "page": "API",
    "title": "SPICE.bodvrd",
    "category": "function",
    "text": "bodvrd(bodynm, item)\n\nFetch from the kernel pool the double precision values of an item associated with a body.\n\nArguments\n\nbodynm: Body name\nitem: Item for which values are desired. (\"RADII\", \"NUTPRECANGLES\", etc.)\nmaxn: Maximum number of values that may be returned.\n\nOutput\n\nvalues: Values\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.brcktd",
    "page": "API",
    "title": "SPICE.brcktd",
    "category": "function",
    "text": "brcktd(number, e1, e2)\n\nwarning: Deprecated\nUse clamp from Julia\'s standard library instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.brckti",
    "page": "API",
    "title": "SPICE.brckti",
    "category": "function",
    "text": "brckti(number, e1, e2)\n\nwarning: Deprecated\nUse clamp from Julia\'s standard library instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bschoc",
    "page": "API",
    "title": "SPICE.bschoc",
    "category": "function",
    "text": "bschoc(value, array, order)\n\nwarning: Deprecated\nUse findfirst(array .== value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bschoi",
    "page": "API",
    "title": "SPICE.bschoi",
    "category": "function",
    "text": "bschoi(value, array, order)\n\nwarning: Deprecated\nUse `findfirst(array .== value)` instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bsrchc",
    "page": "API",
    "title": "SPICE.bsrchc",
    "category": "function",
    "text": "bsrchc(value, array)\n\nwarning: Deprecated\nUse findfirst(array .== value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bsrchd",
    "page": "API",
    "title": "SPICE.bsrchd",
    "category": "function",
    "text": "bsrchd(value, array)\n\nwarning: Deprecated\nUse findfirst(array .== value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.bsrchi",
    "page": "API",
    "title": "SPICE.bsrchi",
    "category": "function",
    "text": "bsrchi(value, array)\n\nwarning: Deprecated\nUse findfirst(array .== value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.card-Tuple{SPICE.SpiceCell}",
    "page": "API",
    "title": "SPICE.card",
    "category": "method",
    "text": "card(cell)\n\nReturns the cardinality (number of elements) of cell.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ccifrm-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.ccifrm",
    "category": "method",
    "text": "ccifrm(frclss, clssid)\n\nReturn the frame name, frame ID, and center associated with a given frame class and class ID.\n\nArguments\n\nfrclss: Class of frame\nclssid: Class ID of frame\n\nOutput\n\nReturn the tuple (frcode, frname, center).\n\nfrcode: ID code of the frame\nfrname: Name of the frame\ncenter: ID code of the center of the frame\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cgv2el-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.cgv2el",
    "category": "method",
    "text": "cgv2el(center, vec1, vec2)\n\nForm a CSPICE ellipse from a center vector and two generating vectors.\n\nArguments\n\ncenter: Center vector\nvec1: Generating vector\nvec2: Generating vector\n\nOutput\n\nThe CSPICE ellipse defined by the input vectors.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cidfrm-Tuple{Any}",
    "page": "API",
    "title": "SPICE.cidfrm",
    "category": "method",
    "text": "cidfrm(cent)\n\nRetrieve frame ID code and name to associate with a frame center.\n\nArguments\n\ncent: ID code for an object for which there is a preferred reference frame\n\nOutput\n\nReturns the tuple (frcode, frname)\n\nfrcode: The ID code of the frame associated with cent\nfrname: The name of the frame with ID frcode\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckcls-Tuple{Any}",
    "page": "API",
    "title": "SPICE.ckcls",
    "category": "method",
    "text": "ckcls(handle)\n\nClose an open CK file.\n\nArguments\n\nhandle: Handle of the CK file to be closed\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckcov!-NTuple{7,Any}",
    "page": "API",
    "title": "SPICE.ckcov!",
    "category": "method",
    "text": "ckcov!(ck, idcode, needav, level, tol, timsys, cover)\n\nFind the coverage window for a specified object in a specified CK file.\n\nArguments\n\nck: Name of CK file\nidcode: ID code of object\nneedav: Flag indicating whether angular velocity is needed\nlevel: Coverage level:  \"SEGMENT\" OR \"INTERVAL\"\ntol: Tolerance in ticks\ntimsys: Time system used to represent coverage\ncover: Window giving coverage for idcode. Data already present in cover   will be combined with coverage found for the object designated by idcode   in the file ck.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckcov-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.ckcov",
    "category": "method",
    "text": "ckcov(ck, idcode, needav, level, tol, timsys)\n\nFind the coverage window for a specified object in a specified CK file.\n\nArguments\n\nck: Name of CK file\nidcode: ID code of object\nneedav: Flag indicating whether angular velocity is needed\nlevel: Coverage level:  \"SEGMENT\" OR \"INTERVAL\"\ntol: Tolerance in ticks\ntimsys: Time system used to represent coverage\n\nOutput\n\nWindow giving coverage for idcode\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckgp-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.ckgp",
    "category": "method",
    "text": "ckgp(inst, sclkdp, tol, ref)\n\nGet pointing (attitude) for a specified spacecraft clock time.\n\nArguments\n\ninst: NAIF ID of instrument, spacecraft, or structure\nsclkdp: Encoded spacecraft clock time\ntol: Time tolerance\nref: Reference frame\n\nOutputs\n\ncmat: C-matrix pointing data\nclkout: Output encoded spacecraft clock time\nfound: true when requested pointing is available\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckgpav-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.ckgpav",
    "category": "method",
    "text": "ckgpav(inst, sclkdp, tol, ref)\n\nGet pointing (attitude) and angular velocity for a specified spacecraft clock time.\n\nArguments\n\ninst: NAIF ID of instrument, spacecraft, or structure\nsclkdp: Encoded spacecraft clock time\ntol: Time tolerance\nref: Reference frame\n\nOutputs\n\ncmat: C-matrix pointing data\nav: Angular velocity vector\nclkout: Output encoded spacecraft clock time\nfound: true when requested pointing is available\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cklpf-Tuple{Any}",
    "page": "API",
    "title": "SPICE.cklpf",
    "category": "method",
    "text": "cklpf(filename)\n\nLoad a CK pointing file for use by the CK readers.  Return that file\'s handle, to be used by other CK routines to refer to the file.\n\nArguments\n\nfilename: Name of the CK file to be loaded\n\nOutput\n\nLoaded file\'s handle\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckobj!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.ckobj!",
    "category": "method",
    "text": "ckobj!(ck, ids)\n\nFind the set of ID codes of all objects in a specified CK file.\n\nArguments\n\nck: Name of CK file\nids: Set of ID codes of objects in CK file. Data already present in   ids will be combined with ID code set found for the file ck.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckobj-Tuple{Any}",
    "page": "API",
    "title": "SPICE.ckobj",
    "category": "method",
    "text": "ckobj(ck)\n\nFind the set of ID codes of all objects in a specified CK file.\n\nArguments\n\nck: Name of CK file\n\nOutput\n\nSet of ID codes of objects in CK file.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckopn",
    "page": "API",
    "title": "SPICE.ckopn",
    "category": "function",
    "text": "ckopn(fname, ifname=\"CK_file\", ncomch=0)\n\nOpen a new CK file, returning the handle of the opened file.\n\nArguments\n\nfname: The name of the CK file to be opened\nifname=\"CK_file\": The internal filename for the CK, default is \"CK_file\"\nncomch=0: The number of characters to reserve for comments, default is zero\n\nOutput\n\nhandle: The handle of the opened CK file\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckupf-Tuple{Any}",
    "page": "API",
    "title": "SPICE.ckupf",
    "category": "method",
    "text": "ckupf(handle)\n\nUnload a CK pointing file so that it will no longer be searched by the readers.\n\nArguments\n\nhandle: Handle of CK file to be unloaded\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ckw01",
    "page": "API",
    "title": "SPICE.ckw01",
    "category": "function",
    "text": "ckw01(handle, inst, ref, segid, sclkdp, quats, avvs=Matrix{SpiceDouble}(0,0);\n    begtim=sclkdp[1], endtim=sclkdp[end])\n\nAdd a type 1 segment to a C-kernel.\n\nArguments\n\nhandle: Handle of an open CK file\ninst: The NAIF instrument ID code\nref: The reference frame of the segment\nsegid: Segment identifier\nsclkdp: Encoded SCLK times\nquats: Quaternions representing instrument pointing\navvs: Angular velocity vectors (optional)\nbegtim: The beginning encoded SCLK of the segment (optional)\nendtim: The ending encoded SCLK of the segment (optional)\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.clight-Tuple{}",
    "page": "API",
    "title": "SPICE.clight",
    "category": "method",
    "text": "clight()\n\nReturns the speed of light in vacuo (km/sec).\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.clpool-Tuple{}",
    "page": "API",
    "title": "SPICE.clpool",
    "category": "method",
    "text": "clpool()\n\nRemove all variables from the kernel pool. Watches on kernel variables are retained.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cmprss-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.cmprss",
    "category": "method",
    "text": "cmprss(delim, n, input)\n\nCompress a character string by removing occurrences of more than n consecutive occurrences of a specified character.\n\nArguments\n\ndelim: Delimiter to be compressed\nn: Maximum consecutive occurrences of delim\ninput: Input string\n\nOutput\n\nReturns the compressed string.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cnmfrm",
    "page": "API",
    "title": "SPICE.cnmfrm",
    "category": "function",
    "text": "cnmfrm(cname)\n\nRetrieve frame ID code and name to associate with an object.\n\nArguments\n\ncname: Name of the object to find a frame for\n\nOutput\n\nReturns a tuple of the ID code and the name of the frame associated with cname or nothing if no frame is found.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.conics-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.conics",
    "category": "method",
    "text": "conics(elts, et)\n\nDetermine the state (position, velocity) of an orbiting body from a set of elliptic, hyperbolic, or parabolic orbital elements.\n\nArguments\n\nelts: Conic elements\net: Input time\n\nOutput\n\nReturns the state of orbiting body at et.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.convrt-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.convrt",
    "category": "method",
    "text": "convrt(x, in, out)\n\nTake a measurement x, the units associated with x, and units to which x should be converted; return y - the value of the measurement in the output units.\n\nArguments\n\nx: Number representing a measurement in some units\nin: The units in which x is measured\nout: Desired units for the measurement\n\nOutput\n\nReturns the measurement in the desired units.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cpos-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.cpos",
    "category": "method",
    "text": "cpos(str, chars, start)\n\nFind the first occurrence in a string of a character belonging to a collection of characters, starting at a specified location, searching forward.\n\nArguments\n\nstr: Any character string\nchars: A collection of characters\nstart: Position to begin looking for one of chars\n\nOutput\n\nReturns the index of the first character of str that is one of the characters in string chars. Returns -1 if none of the characters was found.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cposr-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.cposr",
    "category": "method",
    "text": "cposr(str, chars, start)\n\nFind the first occurrence in a string of a character belonging to a collection of characters, starting at a specified location, searching in reverse.\n\nArguments\n\nstr: Any character string\nchars: A collection of characters\nstart: Position to begin looking for one of chars\n\nOutput\n\nReturns the index of the last character of str that is one of the characters in string chars. Returns -1 if none of the characters was found.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cvpool-Tuple{Any}",
    "page": "API",
    "title": "SPICE.cvpool",
    "category": "method",
    "text": "cvpool(agent)\n\nIndicate whether or not any watched kernel variables that have a specified agent on their notification list have been updated.\n\nArguments\n\nagent: Name of the agent to check for notices\n\nOutput\n\ntrue if variables for agent have been updated.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cyllat-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.cyllat",
    "category": "method",
    "text": "cyllat(r, lonc, z)\n\nConvert from cylindrical to latitudinal coordinates.\n\nArguments\n\nr: Distance of point from z axis\nlonc: Cylindrical angle of point from XZ plane (radians)\nz: Height of point above XY plane\n\nOutput\n\nReturns a tuple of radius, longitude (radians), and latitude (radians).\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cylrec-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.cylrec",
    "category": "method",
    "text": "cylrec(r, lon, z)\n\nConvert from cylindrical to rectangular coordinates.\n\nArguments\n\nr: Distance of the point of interest from z axis\nlon: Cylindrical angle (in radians) of the point of interest from XZ plane\nz: Height of the point above XY plane\n\nOutput\n\nReturns rectangular coordinates of the point of interest.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.cylsph-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.cylsph",
    "category": "method",
    "text": "cylsph(r, lonc, z)\n\nConvert from cylindrical to spherical coordinates.\n\nArguments\n\nr: Distance of point from z axis\nlonc: Angle (radians) of point from XZ plane\nz: Height of point above XY plane\n\nOutput\n\nReturns a tuple of distance of the point from the origin, polar angle (co-latitude in radians), and azimuthal angle (longitude).\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.dtpool-Tuple{Any}",
    "page": "API",
    "title": "SPICE.dtpool",
    "category": "method",
    "text": "dtpool(name)\n\nReturn the data about a kernel pool variable. \n\nArguments\n\nname: Name of the variable whose value is to be returned\n\nOutput\n\nReturns the tuple (n ,vartype).\n\nn: Number of values returned for name\nvartype: Type of the variable\n:C if the data is character data\n:N if the data is numeric\n:X if there is no variable name in the pool\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.edlimb-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.edlimb",
    "category": "method",
    "text": "edlimb(a, b, c, viewpt)\n\nFind the limb of a triaxial ellipsoid, viewed from a specified point.\n\nArguments\n\na: Length of ellipsoid semi-axis lying on the x-axis\nb: Length of ellipsoid semi-axis lying on the y-axis\nc: Length of ellipsoid semi-axis lying on the z-axis\nviewpt: Location of viewing point\n\nOutput\n\nReturns the limb of the ellipsoid as seen from the viewing point.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.edterm-NTuple{7,Any}",
    "page": "API",
    "title": "SPICE.edterm",
    "category": "method",
    "text": "edterm(trmtyp, source, target, et, fixref, obsrvr, abcorr)\n\nCompute a set of points on the umbral or penumbral terminator of a specified target body, where the target shape is modeled as an ellipsoid.\n\nArguments\n\ntrmtyp: Terminator type.\nsource: Light source.\ntarget: Target body.\net: Observation epoch.\nfixref: Body-fixed frame associated with target.\nobsrvr: Observer.\nnpts: Number of points in terminator set.\nabcorr: Aberration correction.\n\nOutput\n\ntrgepc: Epoch associated with target center.\nobspos: Position of observer in body-fixed frame.\ntrmpts: Terminator point set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.et2utc-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.et2utc",
    "category": "method",
    "text": "et2utc(et, format, prec)\n\nConvert an input time from ephemeris seconds past J2000 to Calendar, Day-of-Year, or Julian Date format, UTC.\n\nArguments\n\net: Input epoch, given in ephemeris seconds past J2000\nformat: Format of output epoch. It may be any of the following:\n:C: Calendar format, UTC\n:D: Day-of-Year format, UTC\n:J: Julian Date format, UTC\n:ISOC: ISO Calendar format, UTC\n:ISOD: ISO Day-of-Year format, UTC\nprec: Digits of precision in fractional seconds or days\n\nOutput\n\nReturns an output time string equivalent to the input epoch, in the specified format.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.etcal",
    "page": "API",
    "title": "SPICE.etcal",
    "category": "function",
    "text": "etcal(et, lenout=128)\n\nConvert from an ephemeris epoch measured in seconds past the epoch of J2000 to a calendar string format using a formal calendar free of leapseconds.\n\nArguments\n\net: Ephemeris time measured in seconds past J2000\nlenout: Length of output string (default: 128)\n\nOutput\n\nReturns a standard calendar representation of et.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.eul2m-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.eul2m",
    "category": "method",
    "text": "eul2m(angle3, angle2, angle1, axis3, axis2, axis1)\n\nConstruct a rotation matrix from a set of Euler angles.\n\nArguments\n\nangle3, angle2, angle1: Rotation angles about third, second, and first rotation axes (radians)\naxis3, axis2, axis1: Axis numbers of third, second, and first rotation axes\n\nOutput\n\nA rotation matrix corresponding to the product of the 3 rotations.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.fovray-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.fovray",
    "category": "method",
    "text": "fovray(inst, raydir, rframe, abcorr, observer, et)\n\nDetermine if a specified ray is within the field-of-view (FOV) of a specified instrument at a given time.\n\nArguments\n\ninst: Name or ID code string of the instrument\nraydir: Ray\'s direction vector\nrframe: Body-fixed, body-centered frame for target body\nabcorr: Aberration correction flag\nobserver: Name or ID code string of the observer\net: Time of the observation (seconds past J2000)\n\nOutput\n\nReturns true if the ray is visible.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.fovtrg-NTuple{7,Any}",
    "page": "API",
    "title": "SPICE.fovtrg",
    "category": "method",
    "text": "fovtrg(inst, target, tshape, tframe, abcorr, obsrvr, et)\n\nDetermine if a specified ephemeris object is within the field-of-view (FOV) of a specified instrument at a given time.\n\nArguments\n\ninst: Name or ID code string of the instrument.\ntarget: Name or ID code string of the target.\ntshape: Type of shape model used for the target.\ntframe: Body-fixed, body-centered frame for target body.\nabcorr: Aberration correction flag.\nobsrvr: Name or ID code string of the observer.\net: Time of the observation (seconds past J2000).\n\nOutput\n\nReturns true if the object is visible.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.frame-Tuple{Any}",
    "page": "API",
    "title": "SPICE.frame",
    "category": "method",
    "text": "frame(x)\n\nGiven a vector x, this routine builds a right handed orthonormal frame x, y, z where the output x is parallel to the input x.\n\nArguments\n\nx: Input vector\n\nOutput\n\nx: Unit vector parallel to x on output\ny: Unit vector in the plane orthogonal to x\nz: Unit vector given by x × y\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.frinfo-Tuple{Any}",
    "page": "API",
    "title": "SPICE.frinfo",
    "category": "method",
    "text": "frinfo(frcode)\n\nRetrieve the minimal attributes associated with a frame needed for converting transformations to and from it.\n\nArguments\n\nfrcode: The id code for a reference frame\n\nOutput\n\ncent: The center of the frame\nfrclss: The class (type) of the frame\nclssid: The idcode for the frame within its class\n\nReturns nothing if no frame with id frcode could be found.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.frmnam-Tuple{Any}",
    "page": "API",
    "title": "SPICE.frmnam",
    "category": "method",
    "text": "frmnam(frcode)\n\nRetrieve the name of a reference frame associated with an id code.\n\nArguments\n\nfrcode: The id code for a reference frame\n\nOutput\n\nReturns the name associated with the reference frame.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.furnsh-Tuple",
    "page": "API",
    "title": "SPICE.furnsh",
    "category": "method",
    "text": "furnsh(kernels...)\n\nLoad one or more SPICE kernels into a program.\n\nArguments\n\nkernels: Path(s) of SPICE kernels to load\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.gcpool-Tuple{Any}",
    "page": "API",
    "title": "SPICE.gcpool",
    "category": "method",
    "text": "gcpool(name; start=1, room=100, lenout=128)\n\nReturn the value of a kernel variable from the kernel pool.\n\nArguments\n\nname: Name of the variable whose value is to be returned\nstart: Which component to start retrieving for name (default: 1)\nroom: The largest number of values to return (default: 100)\nlenout: The length of the longest string to return (default: 128)\n\nOutput\n\nReturns an array of values if the variable exists or nothing if not.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.gdpool-Tuple{Any}",
    "page": "API",
    "title": "SPICE.gdpool",
    "category": "method",
    "text": "gdpool(name; start=1, room=100)\n\nReturn the value of a kernel variable from the kernel pool.\n\nArguments\n\nname: Name of the variable whose value is to be returned\nstart: Which component to start retrieving for name (default: 1)\nroom: The largest number of values to return (default: 100)\n\nOutput\n\nReturns an array of values if the variable exists or nothing if not.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.georec-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.georec",
    "category": "method",
    "text": "georec(lon, lat, alt, re, f)\n\nConvert geodetic coordinates to rectangular coordinates.\n\nArguments\n\nlon: Geodetic longitude of point (radians)\nlat: Geodetic latitude  of point (radians)\nalt: Altitude of point above the reference spheroid\nre: Equatorial radius of the reference spheroid\nf: Flattening coefficient\n\nOutput\n\nReturns the rectangular coordinates of point.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.getfov",
    "page": "API",
    "title": "SPICE.getfov",
    "category": "function",
    "text": "getfov(instid, room=10, shapelen=128, framelen=128)\n\nReturn the field-of-view (FOV) parameters for a specified instrument. The instrument is specified by its NAIF ID code.\n\nArguments\n\ninstid: NAIF ID of an instrument\nroom: Maximum number of vectors that can be returned (default: 10)\nshapelen: Space available in the string shape (default: 128)\nframelen: Space available in the string frame (default: 128)\n\nOutput\n\nReturns a tuple consisting of\n\nshape: Instrument FOV shape\nframe: Name of the frame in which FOV vectors are defined\nbsight: Boresight vector\nbounds: FOV boundary vectors\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.gfpa!-NTuple{11,Any}",
    "page": "API",
    "title": "SPICE.gfpa!",
    "category": "method",
    "text": "gfpa!(cnfine, result, target, illmn, abcorr, obsrvr, relate, refval, adjust, step, nintvls)\n\nDetermine time intervals for which a specified constraint on the phase angle between an illumination source, a target, and observer body centers is met.\n\nArguments\n\ncnfine: Window to which the search is confined\ntarget: Name of the target body\nillmn: Name of the illuminating body\nabcorr: Aberration correction flag\nobsrvr: Name of the observing body\nrelate: Relational operator\nrefval: Reference value\nadjust: Adjustment value for absolute extrema searches\nstep: Step size used for locating extrema and roots\nnintvls: Workspace window interval count\n\nOutput\n\nReturns a tuple consisting of\n\ncnfine: Window to which the search is confined.\nresult: Window containing results.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.gipool-Tuple{Any}",
    "page": "API",
    "title": "SPICE.gipool",
    "category": "method",
    "text": "gipool(name; start=1, room=100)\n\nReturn the value of a kernel variable from the kernel pool.\n\nArguments\n\nname: Name of the variable whose value is to be returned\nstart: Which component to start retrieving for name (default: 1)\nroom: The largest number of values to return (default: 100)\n\nOutput\n\nReturns an array of values if the variable exists or nothing if not.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.halfpi",
    "page": "API",
    "title": "SPICE.halfpi",
    "category": "function",
    "text": "halfpi()\n\nwarning: Deprecated\nUse π/2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.hrmint-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.hrmint",
    "category": "method",
    "text": "hrmint(xvals, yvals, x)\n\nEvaluate a Hermite interpolating polynomial at a specified abscissa value.\n\nArguments\n\nxvals: Abscissa values\nyvals: Ordinate and derivative values\nx: Point at which to interpolate the polynomial\n\nOutput\n\nf: Interpolated function value at x\ndf: Interpolated function\'s derivative at x\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.hx2dp-Tuple{Any}",
    "page": "API",
    "title": "SPICE.hx2dp",
    "category": "method",
    "text": "hx2dp(str)\n\nConvert a string representing a double precision number in a base 16 \"scientific notation\" into its equivalent double precision number.\n\nArguments\n\nstr: Hex form string to convert to double precision\n\nOutput\n\ndp: Double precision value to be returned\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.illumf-NTuple{8,Any}",
    "page": "API",
    "title": "SPICE.illumf",
    "category": "method",
    "text": "illumf(method, target, ilusrc, et, fixref, abcorr, obsrvr, spoint)\n\nCompute the illumination angles - phase, incidence, and emission - at a specified point on a target body. Return logical flags indicating whether the surface point is visible from the observer\'s position and whether the surface point is illuminated.\n\nThe target body\'s surface is represented using topographic data provided by DSK files, or by a reference ellipsoid.\n\nThe illumination source is a specified ephemeris object.\n\nArguments\n\nmethod: Computation method\ntarget: Name of target body\nilusrc: Name of illumination source\net: Epoch in TDB seconds past J2000 TDB\nfixref: Body-fixed, body-centered target body frame\nabcorr: Aberration correction flag\nobsrvr: Name of observing body\nspoint: Body-fixed coordinates of a target surface point\n\nOutput\n\ntrgepc: Target surface point epoch\nsrfvec: Vector from observer to target surface point\nphase: Phase angle at the surface point\nincdnc: Source incidence angle at the surface point\nemissn: Emission angle at the surface point\nvisibl: Visibility flag (true if visible)\nlit: Illumination flag (true if illuminated)\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.illumg-NTuple{7,Any}",
    "page": "API",
    "title": "SPICE.illumg",
    "category": "method",
    "text": "illumg(method, target, ilusrc, et, fixref, obsrvr, spoint, abcorr)\n\nFind the illumination angles (phase, incidence, and emission) at a specified surface point of a target body.\n\nThe surface of the target body may be represented by a triaxial ellipsoid or by topographic data provided by DSK files.\n\nThe illumination source is a specified ephemeris object.\n\nArguments\n\nmethod: Computation method.\ntarget: Name of target body.\nilusrc: Name of illumination source.\net: Epoch in ephemeris seconds past J2000 TDB.\nfixref: Body-fixed, body-centered target body frame.\nobsrvr: Name of observing body.\nspoint: Body-fixed coordinates of a target surface point.\nabcorr: Aberration correction.\n\nOutput\n\ntrgepc: Sub-solar point epoch.\nsrfvec: Vector from observer to sub-solar point.\nphase: Phase angle at the surface point.\nincdnc: Solar incidence angle at the surface point.\nemissn: Emission angle at the surface point.\n\nReferences\n\n[NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/illumgc.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ilumin-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.ilumin",
    "category": "method",
    "text": "ilumin(method, target, et, fixref, obsrvr, spoint, abcorr)\n\nFind the illumination angles (phase, solar incidence, and emission) at a specified surface point of a target body.\n\nArguments\n\nmethod: Computation method.\ntarget: Name of target body.\net: Epoch in ephemeris seconds past J2000 TDB.\nfixref: Body-fixed, body-centered target body frame.\nobsrvr: Name of observing body.\nspoint: Body-fixed coordinates of a target surface point.\nabcorr: Aberration correction.\n\nOutput\n\ntrgepc: Sub-solar point epoch.\nsrfvec: Vector from observer to sub-solar point.\nphase: Phase angle at the surface point.\nincdnc: Solar incidence angle at the surface point.\nemissn: Emission angle at the surface point.\n\nReferences\n\n[NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/iluminc.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.inedpl-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.inedpl",
    "category": "method",
    "text": "inedpl(a, b, c, plane)\n\nFind the intersection of a triaxial ellipsoid and a plane.\n\nArguments\n\na: Length of ellipsoid semi-axis lying on the x-axis\nb: Length of ellipsoid semi-axis lying on the y-axis\nc: Length of ellipsoid semi-axis lying on the z-axis\nplane: Plane that intersects ellipsoid\n\nOutput\n\nellipse: Intersection ellipse\n\nReturns nothing if no ellipse could be found.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.inelpl-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.inelpl",
    "category": "method",
    "text": "inelpl(ellips, plane)\n\nFind the intersection of an ellipse and a plane.\n\nArguments\n\nellips: An ellipse\nplane: A plane\n\nOutput\n\nnxpts: Number of intersection points of ellipse and plane\nxpt1, xpt2: Intersection points\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.inrypl-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.inrypl",
    "category": "method",
    "text": "inrypl(vertex, dir, plane)\n\nFind the intersection of a ray and a plane.\n\nArguments\n\nvertex, dir: Vertex and direction vector of ray\nplane: A plane\n\nOutput\n\nnxpts: Number of intersection points of ray and plane\nxpt1, xpt2: Intersection points\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.insrtc!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.insrtc!",
    "category": "method",
    "text": "insrtc!(set, item)\n\nInsert an item into a character set.\n\nArguments\n\nset: Insertion set\nitem: Item to be inserted\n\nOutput\n\nReturns the updated set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.insrtd!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.insrtd!",
    "category": "method",
    "text": "insrtd!(set, item)\n\nInsert an item into a double set.\n\nArguments\n\nset: Insertion set\nitem: Item to be inserted\n\nOutput\n\nReturns the updated set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.insrti!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.insrti!",
    "category": "method",
    "text": "insrti!(set, item)\n\nInsert an item into an integer set.\n\nArguments\n\nset: Insertion set\nitem: Item to be inserted\n\nOutput\n\nReturns the updated set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.inter-Union{Tuple{T}, Tuple{SpiceCell{T,T1,N} where N where T1,SpiceCell{T,T1,N} where N where T1}} where T",
    "page": "API",
    "title": "SPICE.inter",
    "category": "method",
    "text": "inter(a, b)\n\nIntersect two sets of any data type to form a third set.\n\nArguments\n\na: First input set\nb: Second input set\n\nOutput\n\nReturns intersection of a and b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.intmax",
    "page": "API",
    "title": "SPICE.intmax",
    "category": "function",
    "text": "intmax()\n\n!!! warning Deprecated     Use typemax(Cint) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.intmin",
    "page": "API",
    "title": "SPICE.intmin",
    "category": "function",
    "text": "intmin()\n\n!!! warning Deprecated     Use typemin(Cint) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.invert",
    "page": "API",
    "title": "SPICE.invert",
    "category": "function",
    "text": "invert(matrix)\n\n!!! warning Deprecated     Use inv(matrix) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.invort",
    "page": "API",
    "title": "SPICE.invort",
    "category": "function",
    "text": "invort(matrix)\n\n!!! warning Deprecated     Use inv(matrix) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.isordv",
    "page": "API",
    "title": "SPICE.isordv",
    "category": "function",
    "text": "isordv(vec)\n\n!!! warning Deprecated     Use isperm(vec) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.isrchc",
    "page": "API",
    "title": "SPICE.isrchc",
    "category": "function",
    "text": "isrchc(value, array)\n\n!!! warning Deprecated     Use findfirst(array .== value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.isrchd",
    "page": "API",
    "title": "SPICE.isrchd",
    "category": "function",
    "text": "isrchd(value, array)\n\n!!! warning Deprecated     Use findfirst(array .== value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.isrchi",
    "page": "API",
    "title": "SPICE.isrchi",
    "category": "function",
    "text": "isrchi(value, array)\n\n!!! warning Deprecated     Use findfirst(array .== value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.isrot-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.isrot",
    "category": "method",
    "text": "isrot(m, ntol, dtol)\n\nIndicate whether a 3x3 matrix is a rotation matrix.\n\nArguments\n\nm: A matrix to be tested\nntol: Tolerance for the norms of the columns of m\ndtol: Tolerance for the determinant of a matrix whose columns are the unitized columns of m\n\nOutput\n\nReturns true if m is a rotation matrix.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.iswhsp",
    "page": "API",
    "title": "SPICE.iswhsp",
    "category": "function",
    "text": "iswhsp(str)\n\n!!! warning Deprecated     Use isempty(strip(str)) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.j1900-Tuple{}",
    "page": "API",
    "title": "SPICE.j1900",
    "category": "method",
    "text": "j1900()\n\nReturns the Julian Date of 1899 DEC 31 12:00:00 (1900 JAN 0.5).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/j1900c.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.j1950-Tuple{}",
    "page": "API",
    "title": "SPICE.j1950",
    "category": "method",
    "text": "j1950()\n\nReturns the Julian Date of 1950 JAN 01 00:00:00 (1950 JAN 1.0).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/j1950c.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.j2000-Tuple{}",
    "page": "API",
    "title": "SPICE.j2000",
    "category": "method",
    "text": "j2000()\n\nReturns the Julian Date of 2000 JAN 01 12:00:00 (2000 JAN 1.5).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/j2000c.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.j2100-Tuple{}",
    "page": "API",
    "title": "SPICE.j2100",
    "category": "method",
    "text": "j2100()\n\nReturns the Julian Date of 2100 JAN 01 12:00:00 (2100 JAN 1.5).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/j2100c.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.jyear-Tuple{}",
    "page": "API",
    "title": "SPICE.jyear",
    "category": "method",
    "text": "jyear()\n\nReturns the number of seconds per Julian year.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/jyearc.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.kclear-Tuple{}",
    "page": "API",
    "title": "SPICE.kclear",
    "category": "method",
    "text": "kclear()\n\nClear the KEEPER subsystem: unload all kernels, clear the kernel pool, and re-initialize the subsystem. Existing watches on kernel variables are retained.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.kdata",
    "page": "API",
    "title": "SPICE.kdata",
    "category": "function",
    "text": "kdata(which, kind, fillen=1024, srclen=256)\n\nReturn data for the n-th kernel that is among a list of specified kernel types.\n\nArguments\n\nwhich: Index of kernel to fetch from the list of kernels\nkind: The kind of kernel to which fetches are limited\nfillen: Available space in output file string\nsrclen: Available space in output source string\n\nOutput\n\nReturns nothing if no kernel was found or a tuple consisting of\n\nfile: The name of the kernel file\nfiltyp: The type of the kernel\nsource: Name of the source file used to load file\nhandle: The handle attached to file\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.kinfo",
    "page": "API",
    "title": "SPICE.kinfo",
    "category": "function",
    "text": "kinfo(file, srclen=256)\n\nArguments\n\nfile: Name of a kernel to fetch information for\nsrclen: Available space in output source string\n\nOutput\n\nReturns nothing if no kernel was found or a tuple consisting of\n\nfiltyp: The type of the kernel\nsource: Name of the source file used to load file\nhandle: The handle attached to file\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.kplfrm",
    "page": "API",
    "title": "SPICE.kplfrm",
    "category": "function",
    "text": "kplfrm(frmcls)\n\nReturn a SPICE set containing the frame IDs of all reference frames of a given class having specifications in the kernel pool.\n\nArguments\n\nfrmcls: Frame class\nsize: Size of the output set\n\nOutput\n\nReturns the set of ID codes of frames of the specified class.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ktotal-Tuple{Any}",
    "page": "API",
    "title": "SPICE.ktotal",
    "category": "method",
    "text": "ktotal(kind)\n\nReturn the current number of kernels that have been loaded via the KEEPER interface that are of a specified type.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.kxtrct",
    "page": "API",
    "title": "SPICE.kxtrct",
    "category": "function",
    "text": "kxtrct(keywd, terms, string)\n\nLocate a keyword in a string and extract the substring from the beginning of the first word following the keyword to the beginning of the first subsequent recognized terminator of a list.\n\nArguments\n\nkeywd: Word that marks the beginning of text of interest\nterms: Set of words, any of which marks the end of text\nstring: String containing a sequence of words\n\nOutput\n\nReturns nothing if keywd was found or a tuple consisting of\n\nstring: The input string with the text of interest removed\nsubstr: String from end of keywd to beginning of first terms item found\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lastnb-Tuple{Any}",
    "page": "API",
    "title": "SPICE.lastnb",
    "category": "method",
    "text": "lastnb(str)\n\nReturn the index of the last non-blank character in a character string.\n\nArguments\n\nstr: Input character string\n\nOutput\n\nThe function returns the one-based index of the last non-blank character in a character string. If the string is entirely blank or is empty, the value 0 is returned.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.latcyl-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.latcyl",
    "category": "method",
    "text": "latcyl(radius, lon, lat)\n\nConvert from latitudinal coordinates to cylindrical coordinates.\n\nArguments\n\nradius: Distance of a point from the origin\nlon: Angle of the point from the XZ plane in radians\nlat: Angle of the point from the XY plane in radians\n\nOutput\n\nReturn the tuple (r, lonc, z).\n\nr: Distance of the point from the z axis\nlonc: Angle of the point from the XZ plane in radians. \'lonc\' is set equal to \'lon\'\nz: Height of the point above the XY plane\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.latrec-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.latrec",
    "category": "method",
    "text": "latrec(radius, lon, lat)\n\nConvert from latitudinal coordinates to rectangular coordinates.\n\nArguments\n\nradius: Distance of a point from the origin\nlon: Angle of the point from the XZ plane in radians\nlat: Angle of the point from the XY plane in radians\n\nOutput\n\nReturn the rectangular coordinates vector of the point.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.latsph-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.latsph",
    "category": "method",
    "text": "latsph(radius, lon, lat)\n\nConvert from latitudinal coordinates to rectangular coordinates.\n\nArguments\n\nradius: Distance of a point from the origin\nlon: Angle of the point from the XZ plane in radians\nlat: Angle of the point from the XY plane in radians\n\nOutput\n\nReturn the tuple (rho, colat, lons).\n\nrho: Distance of the point from the origin\ncolat: Angle of the point from positive z axis (radians)\nlons: Angle of the point from the XZ plane (radians)\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.latsrf-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.latsrf",
    "category": "method",
    "text": "latsrf(method, target, et, fixref, npts, lonlat)\n\nMap array of planetocentric longitude/latitude coordinate pairs to surface points on a specified target body.\n\nThe surface of the target body may be represented by a triaxial ellipsoid or by topographic data provided by DSK files.\n\nArguments\n\nmethod: Computation method\ntarget: Name of target body\net: Epoch in TDB seconds past J2000 TDB\nfixref: Body-fixed, body-centered target body frame\nnpts: Number of coordinate pairs in input array\nlonlat: Array of longitude/latitude coordinate pairs\n\nOutput\n\nReturns an array of surface points\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lcase",
    "page": "API",
    "title": "SPICE.lcase",
    "category": "function",
    "text": "lcase(in)\n\nwarning: Deprecated\nUse lowercase(in) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ldpool-Tuple{Any}",
    "page": "API",
    "title": "SPICE.ldpool",
    "category": "method",
    "text": "ldpool(kernel)\n\nLoad the variables contained in a NAIF ASCII kernel file into the kernel pool.\n\nArguments\n\nkernel: Name of the kernel file\n\nOutput\n\nNone\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lgrind-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.lgrind",
    "category": "method",
    "text": "lgrind(xvals, yvals, x)\n\nEvaluate a Lagrange interpolating polynomial for a specified set of coordinate pairs, at a specified abscissa value. Return the value of both polynomial and derivative.\n\nArguments\n\nxvals: Abscissa values of coordinate pairs\nyvals: Ordinate values of coordinate pairs\nx: Point at which to interpolate the polynomial\n\nOutput\n\nReturns the tuple (p, dp).\n\np: The value at x of the unique polynomial of      degree n-1 that fits the points in the plane      defined by xvals and yvals\ndp: The derivative at x of the interpolating       polynomial described above\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.limbpt-NTuple{13,Any}",
    "page": "API",
    "title": "SPICE.limbpt",
    "category": "method",
    "text": "limbpt(method, target, et, fixref, abcorr, corloc, obsrvr, refvec, rolstp, ncuts, schstp, soltol, maxn)\n\nFind limb points on a target body. The limb is the set of points of tangency on the target of rays emanating from the observer. The caller specifies half-planes bounded by the observer-target center vector in which to search for limb points.\n\nThe surface of the target body may be represented either by a triaxial ellipsoid or by topographic data.\n\nArguments\n\nmethod: Computation method\ntarget: Name of target body\net: Epoch in ephemeris seconds past J2000 TDB\nfixref: Body-fixed, body-centered target body frame\nabcorr: Aberration correction\ncorloc: Aberration correction locus\nobsrvr: Name of observing body\nrefvec: Reference vector for cutting half-planes\nrolstp: Roll angular step for cutting half-planes\nncuts: Number of cutting half-planes\nschstp: Angular step size for searching\nsoltol: Solution convergence tolerance\nmaxn: Maximum number of entries in output arrays\n\nOutput\n\nReturns the tuple (npts, points, epochs, tangts).\n\nnpts: Counts of limb points corresponding to cuts\npoints: Limb points\nepochs: Times associated with limb points\ntangts: Tangent vectors emanating from the observer\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lmpool-Tuple{Any}",
    "page": "API",
    "title": "SPICE.lmpool",
    "category": "method",
    "text": "lmpool(cvals)\n\nLoad the variables contained in an internal buffer into the kernel pool.\n\nArguments\n\ncvals: An array that contains a SPICE text kernel\n\nOutput\n\nNone\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lparse-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.lparse",
    "category": "method",
    "text": "lparse(list, delim, nmax)\n\nParse a list of items delimited by a single character.\n\nArguments\n\nlist: List of items delimited by delim\ndelim: Single character used to delimit items\nnmax: Maximum number of items to return\n\nOutput\n\nReturns an array with the items in the list, left justified.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lparsm-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.lparsm",
    "category": "method",
    "text": "lparsm(list, delims, nmax)\n\nParse a list of items separated by multiple delimiters.\n\nArguments\n\nlist: List of items delimited by delim\ndelims: Single characters which delimit items\nnmax: Maximum number of items to return\n\nOutput\n\nReturns an array with the items in the list, left justified.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lparss-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.lparss",
    "category": "method",
    "text": "lparss(list, delims)\n\nParse a list of items separated by multiple delimiters, placing the resulting items into a set.\n\nArguments\n\nlist: List of items delimited by delim\ndelims: Single characters which delimit items\n\nOutput\n\nReturns a set containing items in the list, left justified\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lspcn-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.lspcn",
    "category": "method",
    "text": "lspcn(body, et, abcorr)\n\nCompute L_s, the planetocentric longitude of the sun, as seen from a specified body.\n\nArguments\n\nbody: Name of the central body\net: Epoch in seconds past J2000 TDB\nabcorr: Aberration correction\n\nOutput\n\nReturns the planetocentric longitude of the sun for the specified body at the specified time in radians.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lstle",
    "page": "API",
    "title": "SPICE.lstle",
    "category": "function",
    "text": "lstle(x, array)\n\nGiven an element x and an array of non-decreasing elements (floats, integers, or strings), find the index of the largest array element less than or equal to x.\n\nArguments\n\nx: Value to search against\narrays: Array of possible lower bounds\n\nOutput\n\nReturns the index of the highest-indexed element in the input array that is less than or equal to x.  The routine assumes the array elements are sorted in non-decreasing order.\n\nIf all elements of the input array are greater than x, the function returns 0.\n\nReferences\n\nNAIF Documentation\nNAIF Documentation\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lstlt",
    "page": "API",
    "title": "SPICE.lstlt",
    "category": "function",
    "text": "lstle(x, array)\n\nGiven an element x and an array of non-decreasing elements (floats, integers, or strings), find the index of the largest array element less than x.\n\nArguments\n\nx: Value to search against\narrays: Array of possible lower bounds\n\nOutput\n\nReturns the index of the highest-indexed element in the input array that is less than x.  The routine assumes the array elements are sorted in non-decreasing order.\n\nIf all elements of the input array are greater than or equal to x, the function returns 0.\n\nReferences\n\nNAIF Documentation\nNAIF Documentation\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ltime-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.ltime",
    "category": "method",
    "text": "ltime(etobs, obs, dir, targ)\n\nThis routine computes the transmit (or receive) time of a signal at a specified target, given the receive (or transmit) time at a specified observer. The elapsed time between transmit and receive is also returned.\n\nArguments\n\netobs: Epoch of a signal at some observer\nobs: NAIF ID of some observer\ndir: Direction the signal travels ( \"->\" or \"<-\" )\ntarg: Time between transmit and receipt of the signal\n\nOutput\n\nReturns the tuple (ettarg, elapsd).\n\nettarg: Epoch of the signal at the target\nobs: NAIF ID of some observer\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lx4dec-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.lx4dec",
    "category": "method",
    "text": "lx4dec(string, first)\n\nScan a string from a specified starting position for the end of a decimal number.\n\nArguments\n\nstring: Any character string\nfirst: First character to scan from in string\n\nOutput\n\nReturns the tuple (last, nchar).\n\nlast: Last character that is part of a decimal number. If there is no such         character, last will be returned with the value first-1.\nnchar: Number of characters in the decimal number\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lx4num-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.lx4num",
    "category": "method",
    "text": "lx4num(string, first)\n\nScan a string from a specified starting position for the end of a number.\n\nArguments\n\nstring: Any character string\nfirst: First character to scan from in string\n\nOutput\n\nReturns the tuple (last, nchar).\n\nlast: Last character that is part of a number. If there is no such         character, last will be returned with the value first-1.\nnchar: Number of characters in the number\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lx4sgn-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.lx4sgn",
    "category": "method",
    "text": "lx4sgn(string, first)\n\nScan a string from a specified starting position for the end of a signed integer.\n\nArguments\n\nstring: Any character string\nfirst: First character to scan from in string\n\nOutput\n\nReturns the tuple (last, nchar).\n\nlast: Last character that is part of a signed integer. If there is no such         character, last will be returned with the value first-1.\nnchar: Number of characters in the signed integer\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.lx4uns-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.lx4uns",
    "category": "method",
    "text": "lx4uns(string, first)\n\nScan a string from a specified starting position for the end of a unsigned integer.\n\nArguments\n\nstring: Any character string\nfirst: First character to scan from in string\n\nOutput\n\nReturns the tuple (last, nchar).\n\nlast: Last character that is part of an unsigned integer. If there is no such         character, last will be returned with the value first-1.\nnchar: Number of characters in the unsigned integer\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.m2eul-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.m2eul",
    "category": "method",
    "text": "m2eul(r, axis3, axis2, axis1)\n\nFactor a rotation matrix as a product of three rotations about specified coordinate axes.\n\nArguments\n\nr: A rotation matrix to be factored\naxis3: Number of the third rotation axis\naxis2: Number of the second rotation axis\naxis1: Number of the first rotation axis\n\nOutput\n\nA tuple consisting of the third, second, and first Euler angles in radians.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.m2q-Tuple{Any}",
    "page": "API",
    "title": "SPICE.m2q",
    "category": "method",
    "text": "m2q(r)\n\nFind a unit quaternion corresponding to a specified rotation matrix.\n\nArguments\n\nr: A rotation matrix\n\nOutput\n\nA unit quaternion representing `r\'\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.matchi-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.matchi",
    "category": "method",
    "text": "matchi(string, templ, wstr, wchar)\n\nDetermine whether a string is matched by a template containing wild cards. The pattern comparison is case-insensitive.\n\nArguments\n\nstring: String to be tested\ntempl: Template (with wild cards) to test against string\nwstr: Wild string token\nwchr: Wild character token\n\nOutput\n\nReturns true if the string matches.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.matchw-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.matchw",
    "category": "method",
    "text": "matchw(string, templ, wstr, wchar)\n\nDetermine whether a string is matched by a template containing wild cards.\n\nArguments\n\nstring: String to be tested\ntempl: Template (with wild cards) to test against string\nwstr: Wild string token\nwchr: Wild character token\n\nOutput\n\nReturns true if the string matches.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.maxd",
    "page": "API",
    "title": "SPICE.maxd",
    "category": "function",
    "text": "maxd(args...)\n\nwarning: Deprecated\nUse max(args...) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.maxi",
    "page": "API",
    "title": "SPICE.maxi",
    "category": "function",
    "text": "maxi(args...)\n\nwarning: Deprecated\nUse max(args...) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mequ",
    "page": "API",
    "title": "SPICE.mequ",
    "category": "function",
    "text": "mequ(m1, mout)\n\nwarning: Deprecated\nUse mout .= m1 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mequg",
    "page": "API",
    "title": "SPICE.mequg",
    "category": "function",
    "text": "mequg(m1, mout)\n\nwarning: Deprecated\nUse mout .= m1 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mind",
    "page": "API",
    "title": "SPICE.mind",
    "category": "function",
    "text": "mind(args...)\n\nwarning: Deprecated\nUse min(args...) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mini",
    "page": "API",
    "title": "SPICE.mini",
    "category": "function",
    "text": "mini(args...)\n\nwarning: Deprecated\nUse min(args...) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mtxm",
    "page": "API",
    "title": "SPICE.mtxm",
    "category": "function",
    "text": "mtxm(m1, m2)\n\nwarning: Deprecated\nUse m1\' * m2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mtxmg",
    "page": "API",
    "title": "SPICE.mtxmg",
    "category": "function",
    "text": "mtxmg(m1, m2)\n\nwarning: Deprecated\nUse m1\' * m2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mtxv",
    "page": "API",
    "title": "SPICE.mtxv",
    "category": "function",
    "text": "mtxv(m1,v2)\n\nwarning: Deprecated\nUse m1\' * v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mtxvg",
    "page": "API",
    "title": "SPICE.mtxvg",
    "category": "function",
    "text": "mtxvg(m1,v2)\n\nwarning: Deprecated\nUse m1\' * v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mxm",
    "page": "API",
    "title": "SPICE.mxm",
    "category": "function",
    "text": "mxm(m1, m2)\n\nwarning: Deprecated\nUse m1 * m2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mxmg",
    "page": "API",
    "title": "SPICE.mxmg",
    "category": "function",
    "text": "mxmg(m1, m2)\n\nwarning: Deprecated\nUse m1 * m2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mxmt",
    "page": "API",
    "title": "SPICE.mxmt",
    "category": "function",
    "text": "mxmt(m1, m2)\n\nwarning: Deprecated\nUse m1 * m2\' instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mxmtg",
    "page": "API",
    "title": "SPICE.mxmtg",
    "category": "function",
    "text": "mxmtg(m1, m2)\n\nwarning: Deprecated\nUse m1 * m2\' instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mxv",
    "page": "API",
    "title": "SPICE.mxv",
    "category": "function",
    "text": "mxv(m1,v2)\n\nwarning: Deprecated\nUse m1 * v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.mxvg",
    "page": "API",
    "title": "SPICE.mxvg",
    "category": "function",
    "text": "mxvg(m1,v2)\n\nwarning: Deprecated\nUse m1 * v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.namfrm-Tuple{Any}",
    "page": "API",
    "title": "SPICE.namfrm",
    "category": "method",
    "text": "namfrm(frname)\n\nLook up the frame ID code associated with a string.\n\nArguments\n\nfrname: The name of some reference frame\n\nOutput\n\nThe SPICE ID code of the frame.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ncpos-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.ncpos",
    "category": "method",
    "text": "ncpos(str, chars, start)\n\nFind the first occurrence in a string of a character NOT belonging to a collection of characters, starting at a specified location, searching forward.\n\nArguments\n\nstr: A string\nchars: A collection of characters\nstart: Position to begin looking for a character not in chars\n\nOutput\n\nReturns the index of the first character of str at or following index start that is not in the collection chars.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ncposr-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.ncposr",
    "category": "method",
    "text": "ncposr(str, chars, start)\n\nFind the first occurrence in a string of a character NOT belonging to a collection of characters, starting at a specified location, searching in reverse.\n\nArguments\n\nstr: A string\nchars: A collection of characters\nstart: Position to begin looking for a character not in chars\n\nOutput\n\nReturns the index of the last character of str at or before index start that is not in the collection chars.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.nearpt-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.nearpt",
    "category": "method",
    "text": "nearpt(positn, a, b, c)\n\nThis routine locates the point on the surface of an ellipsoid that is nearest to a specified position. It also returns the altitude of the position above the ellipsoid.\n\nArguments\n\npositn: Position of a point in the bodyfixed frame\na: Length of semi-axis parallel to x-axis\nb: Length of semi-axis parallel to y-axis\nc: Length on semi-axis parallel to z-axis\n\nOutput\n\nReturns a tuple consisting of npoint and alt.\n\nnpoint: Point on the ellipsoid closest to positn\nalt: Altitude of positn above the ellipsoid\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.npedln-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.npedln",
    "category": "method",
    "text": "npedln(a, b, c, linept, linedr)\n\nFind nearest point on a triaxial ellipsoid to a specified line, and the distance from the ellipsoid to the line.\n\nArguments\n\na: Length of semi-axis in the x direction \nb: Length of semi-axis in the y direction \nc: Length of semi-axis in the z direction \nlinept: Point on line \nlinedr: Direction vector of line \n\nOutput\n\nReturns a tuple consisting of pnear and dist.\n\npnear: Nearest point on ellipsoid to line \ndist: Distance of ellipsoid from line\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.npelpt-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.npelpt",
    "category": "method",
    "text": "npelpt(point, ellips)\n\nFind the nearest point on an ellipse to a specified point, both in three-dimensional space, and find the distance between the ellipse and the point.\n\nArguments\n\npoint: Point whose distance to an ellipse is to be found\nellips: A SPICE ellipse\n\nOutput\n\nReturns a tuple consisting of pnear and dist.\n\npnear: Nearest point on ellipse to input point\ndist: Distance of input point to ellipse\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.nplnpt-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.nplnpt",
    "category": "method",
    "text": "nplnpt(linept, linedr, point)\n\nFind the nearest point on a line to a specified point, and find the distance between the two points.\n\nArguments\n\nlinept: Point on line \nlinedr: Direction vector of line \npoint: A second point\n\nOutput\n\nReturns a tuple consisting of pnear and dist.\n\npnear: Nearest point on the line to point\ndist: Distance between point and pnear\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.nvc2pl-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.nvc2pl",
    "category": "method",
    "text": "nvc2pl(norm, point)\n\nMake a SPICE plane from a normal vector and a point.\n\nArguments\n\nnorm: A normal vector...\nconstant: ...and a constant defining a plane\n\nOutput\n\nReturns a struct representing the plane.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.nvp2pl-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.nvp2pl",
    "category": "method",
    "text": "nvp2pl(norm, point)\n\nMake a SPICE plane from a normal vector and a point.\n\nArguments\n\nnorm: A normal vector...\npoint: ...and a point defining a plane\n\nOutput\n\nReturns a struct representing the plane.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.occult-NTuple{9,Any}",
    "page": "API",
    "title": "SPICE.occult",
    "category": "method",
    "text": "occult(targ1, shape1, frame1, targ2, shape2, frame2, abcorr, obsrvr, et)\n\nDetermines the occultation condition (not occulted, partially, etc.) of one target relative to another target as seen by an observer at a given time.\n\nThe surfaces of the target bodies may be represented by triaxial ellipsoids or by topographic data provided by DSK files.\n\nArguments\n\ntarg1: Name or ID of first target.\nshape1: Type of shape model used for first target.\nframe1: Body-fixed, body-centered frame for first body.\ntarg2: Name or ID of second target.\nshape2: Type of shape model used for second target.\nframe2: Body-fixed, body-centered frame for second body.\nabcorr: Aberration correction flag.\nobsrvr: Name or ID of the observer.\net: Time of the observation (seconds past J2000).\n\nOutput\n\nReturns the occultation identification code.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ordc-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.ordc",
    "category": "method",
    "text": "ordc(set, item)\n\nThe function returns the ordinal position of any given item in a character set.\n\nArguments\n\nset: A set to search for a given item\nitem: An item to locate within a set\n\nOutput\n\nReturns the ordinal position or nothing if the items does not appear in the set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ordd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.ordd",
    "category": "method",
    "text": "ordd(set, item)\n\nThe function returns the ordinal position of any given item in a character set.\n\nArguments\n\nset: A set to search for a given item\nitem: An item to locate within a set\n\nOutput\n\nReturns the ordinal position or nothing if the items does not appear in the set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.orderc",
    "page": "API",
    "title": "SPICE.orderc",
    "category": "function",
    "text": "orderc(array)\n\n!!! warning Deprecated     Use sortperm instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.orderd",
    "page": "API",
    "title": "SPICE.orderd",
    "category": "function",
    "text": "orderd(array)\n\n!!! warning Deprecated     Use sortperm instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.orderi",
    "page": "API",
    "title": "SPICE.orderi",
    "category": "function",
    "text": "orderi(array)\n\n!!! warning Deprecated     Use sortperm instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ordi-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.ordi",
    "category": "method",
    "text": "ordi(set, item)\n\nThe function returns the ordinal position of any given item in a character set.\n\nArguments\n\nset: A set to search for a given item\nitem: An item to locate within a set\n\nOutput\n\nReturns the ordinal position or nothing if the items does not appear in the set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.oscelt-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.oscelt",
    "category": "method",
    "text": "oscelt(state, et, mu)\n\nDetermine the set of osculating conic orbital elements that corresponds to the state (position, velocity) of a body at some epoch.\n\nArguments\n\nstate: State of body at epoch of elements\net: Epoch of elements\nmu: Gravitational parameter (GM) of primary body\n\nOutput\n\nReturns the equivalent conic elements:\n\nrp: Perifocal distance\necc: Eccentricity\ninc: Inclination\nlnode: Longitude of the ascending node\nargp: Argument of periapsis\nm0: Mean anomaly at epoch\nt0: Epoch\nmu: Gravitational parameter\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.oscltx-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.oscltx",
    "category": "method",
    "text": "oscltx(state, et, mu)\n\nDetermine the set of osculating conic orbital elements that corresponds to the state (position, velocity) of a body at some epoch. In addition to the classical elements, return the true anomaly, semi-major axis, and period, if applicable.\n\nArguments\n\nstate: State of body at epoch of elements\net: Epoch of elements\nmu: Gravitational parameter (GM) of primary body\n\nOutput\n\nReturns the extended set of classical conic elements:\n\nrp: Perifocal distance.\necc: Eccentricity.\ninc: Inclination.\nlnode: Longitude of the ascending node.\nargp: Argument of periapsis.\nm0: Mean anomaly at epoch.\nt0: Epoch.\nmu: Gravitational parameter.\nnu: True anomaly at epoch.\na: Semi-major axis. A is set to zero if it is not computable.\ntau: Orbital period. Applicable only for elliptical orbits. Set to zero otherwise.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pckcov!-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.pckcov!",
    "category": "method",
    "text": "pckcov!(cover, pck, idcode)\n\nFind the coverage window for a specified reference frame in a specified binary PCK file.\n\nArguments\n\ncover: An initalized window SpiceDoubleCell\npck: Path of PCK file\nidcode: Class ID code of PCK reference frame\n\nOutput\n\nReturns cover containing coverage in pck for idcode\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pckfrm!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pckfrm!",
    "category": "method",
    "text": "pckfrm!(ids, pck)\n\nFind the set of reference frame class ID codes of all frames in a specified binary PCK file.\n\nArguments\n\nids: An initalized SpiceIntCell\npck: Path of PCK file\n\nOutput\n\nReturns ids containing a set of frame class ID codes of frames in PCK file.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pcklof-Tuple{Any}",
    "page": "API",
    "title": "SPICE.pcklof",
    "category": "method",
    "text": "pcklof(filename)\n\nLoad a binary PCK file for use by the readers. Return the handle of the loaded file which is used by other PCK routines to refer to the file.\n\nArguments\n\nfilename: Path of the PCK file\n\nOutput\n\nReturns an integer handle.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pckuof-Tuple{Any}",
    "page": "API",
    "title": "SPICE.pckuof",
    "category": "method",
    "text": "pckuof(handle)\n\nUnload a binary PCK file so that it will no longer be searched by the readers.\n\nArguments\n\nhandle: Integer handle of a PCK file\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pcpool-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pcpool",
    "category": "method",
    "text": "pcpool(name, vals)\n\nInsert character data into the kernel pool.\n\nArguments\n\nname: The kernel pool name to associate with vals\nvals: An array of values to insert into the kernel pool\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pdpool-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pdpool",
    "category": "method",
    "text": "pdpool(name, vals)\n\nInsert double precision data into the kernel pool.\n\nArguments\n\nname: The kernel pool name to associate with vals\nvals: An array of values to insert into the kernel pool\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pgrrec-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.pgrrec",
    "category": "method",
    "text": "pgrrec(body, lon, lat, alt, re, f)\n\nConvert planetographic coordinates to rectangular coordinates.\n\nArguments\n\nbody: Body with which coordinate system is associated.\nlon: Planetographic longitude of a point (radians).\nlat: Planetographic latitude of a point (radians).\nalt: Altitude of a point above reference spheroid.\nre: Equatorial radius of the reference spheroid.\nf: Flattening coefficient.\n\nOutput\n\nReturns the rectangular coordinates of the point.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.phaseq-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.phaseq",
    "category": "method",
    "text": "phaseq(et, target, illmn, obsrvr, abcorr)\n\nCompute the apparent phase angle for a target, observer, illuminator set of ephemeris objects.\n\nArguments\n\net: Ephemeris seconds past J2000 TDB\ntarget: Target body name\nillmn: Illuminating body name\nobsrvr: Observer body\nabcorr: Aberration correction flag\n\nOutput\n\nReturns the value of the phase angle.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pipool-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pipool",
    "category": "method",
    "text": "pipool(name, ivals)\n\nInsert integer data into the kernel pool.\n\nArguments\n\nname: The kernel pool name to associate with the values\nivals: An array of integers to insert into the pool\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pjelpl-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pjelpl",
    "category": "method",
    "text": "pjelpl(elin, plane)\n\nProject an ellipse onto a plane, orthogonally.\n\nArguments\n\nelin: An ellipse to be projected\nplane: A plane onto which elin is to be projected\n\nOutput\n\nReturns the ellipse resulting from the projection.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pl2nvc-Tuple{Any}",
    "page": "API",
    "title": "SPICE.pl2nvc",
    "category": "method",
    "text": "pl2nvc(plane)\n\nReturn a unit normal vector and constant that define a specified plane.\n\nArguments\n\nplane: A plane\n\nOutput\n\nReturns a tuple consisting of\n\nnormal: A normal vector and...\nconstant: ... constant defining the geometric plane represented by plane\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pl2nvp-Tuple{Any}",
    "page": "API",
    "title": "SPICE.pl2nvp",
    "category": "method",
    "text": "pl2nvp(plane)\n\nReturn a unit normal vector and point that define a specified plane.\n\nArguments\n\nplane: A plane\n\nOutput\n\nReturns a tuple consisting of\n\nnormal: A normal vector and...\npoint: ... point defining the geometric plane represented by plane\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pl2psv-Tuple{Any}",
    "page": "API",
    "title": "SPICE.pl2psv",
    "category": "method",
    "text": "pl2psv(plane)\n\nReturn a point and two orthogonal spanning vectors that define a specified plane.\n\nArguments\n\nplane: A plane\n\nOutput\n\nReturns a tuple consisting of a point in the plane and two vectors spanning the input plane.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pltar-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pltar",
    "category": "method",
    "text": "pltar(vrtces, plates)\n\nCompute the total area of a collection of triangular plates.\n\nArguments\n\nvrtces: Array of vertices\nplates: Array of plates\n\nOutput\n\nReturns the area.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pltexp-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pltexp",
    "category": "method",
    "text": "pltexp(iverts, delta)\n\nExpand a triangular plate by a specified amount. The expanded plate is co-planar with, and has the same orientation as, the original. The centroids of the two plates coincide.\n\nArguments\n\niverts: Vertices of the plate to be expanded\ndelta: Fraction by which the plate is to be expanded\n\nOutput\n\nReturns the vertices of the expanded plate.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pltnp-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.pltnp",
    "category": "method",
    "text": "pltnp(point, v1, v2, v3)\n\nFind the nearest point on a triangular plate to a given point.\n\nArguments\n\npoint: A point in 3-dimensional space.\nv1, v2, v3: Vertices of a triangular plate\n\nOutput\n\nReturns a tuple consisting of\n\npnear: Nearest point on the plate to point\ndist: Distance between pnear and point\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pltnrm-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.pltnrm",
    "category": "method",
    "text": "pltnrm(v1, v2, v3)\n\nCompute an outward normal vector of a triangular plate.  The vector does not necessarily have unit length.\n\nArguments\n\nv1, v2, v3: Vertices of a plate\n\nOutput\n\nReturns the plate\'s outward normal vector.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pltvol-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.pltvol",
    "category": "method",
    "text": "pltvol(vrtces, plates)\n\nCompute the volume of a three-dimensional region bounded by a collection of triangular plates.\n\nArguments\n\nvrtces: Array of vertices\nplates: Array of plates\n\nOutput\n\nReturns the volume of the spatial region bounded by the plates.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.polyds-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.polyds",
    "category": "method",
    "text": "polyds(coeffs, nderiv, t)\n\nCompute the value of a polynomial and it\'s first nderiv derivatives at the value t.\n\nArguments\n\ncoeffs: Coefficients of the polynomial to be evaluated\nnderiv: Number of derivatives to compute\nt: Point to evaluate the polynomial and derivatives\n\nOutput\n\nReturns the value of the polynomial and the derivatives as an array.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pos",
    "page": "API",
    "title": "SPICE.pos",
    "category": "function",
    "text": "pos(str, substr, start)\n\nwarning: Deprecated\nUse first(findnext(substr, str, start)) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.posr",
    "page": "API",
    "title": "SPICE.posr",
    "category": "function",
    "text": "posr(str, substr, start)\n\nwarning: Deprecated\nUse first(findprev(substr, str, start)) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.prop2b-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.prop2b",
    "category": "method",
    "text": "prop2b(gm, pvinit, dt)\n\nGiven a central mass and the state of massless body at time t_0, this routine determines the state as predicted by a two-body force model at time t_0 + dt.\n\nArguments\n\ngm: Gravity of the central mass.\npvinit: Initial state from which to propagate a state.\ndt: Time offset from initial state to propagate to.\n\nOutput\n\nReturns the propagated state.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.prsdp",
    "page": "API",
    "title": "SPICE.prsdp",
    "category": "function",
    "text": "prsdp(str)\n\nwarning: Deprecated\nUse parse(Float64, str) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.prsint",
    "page": "API",
    "title": "SPICE.prsint",
    "category": "function",
    "text": "prsint(str)\n\nwarning: Deprecated\nUse parse(Int, str) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.psv2pl-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.psv2pl",
    "category": "method",
    "text": "psv2pl(point, span1, span2)\n\nMake a plane from a point and two spanning vectors.\n\nArguments\n\npoint, span1, span2: A point and two spanning vectors defining a plane\n\nOutput\n\nReturns the plane.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pxform-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.pxform",
    "category": "method",
    "text": "pxform(from, to, et)\n\nReturn the matrix that transforms position vectors from one specified frame to another at a specified epoch.\n\nArguments\n\nfrom: Name of the frame to transform from\nto: Name of the frame to transform to\net: Epoch of the rotation matrix\n\nOutput\n\nReturns the rotation matrix.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.pxfrm2-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.pxfrm2",
    "category": "method",
    "text": "pxfrm2(from, to, etfrom, etto)\n\nReturn the 3x3 matrix that transforms position vectors from one specified frame at a specified epoch to another specified frame at another specified epoch.\n\nArguments\n\nfrom: Name of the frame to transform from\nto: Name of the frame to transform to\netfrom: Evaluation time of from frame\netto: Evaluation time of to frame\n\nOutput\n\nReturns a position transformation matrix from frame from to frame to.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.q2m-Tuple",
    "page": "API",
    "title": "SPICE.q2m",
    "category": "method",
    "text": "q2m(q...)\n\nFind the rotation matrix corresponding to a specified unit quaternion.\n\nArguments\n\nq: A unit quaternion (as any kind of iterable with four elements)\n\nOutput\n\nA rotation matrix corresponding to q.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.qdq2av-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.qdq2av",
    "category": "method",
    "text": "qdq2av(q,dq)\n\nDerive angular velocity from a unit quaternion and its derivative  with respect to time. \n\nArguments\n\nq: Unit SPICE quaternion (as any kind of iterable with four elements)\ndq: Derivative of `q\' with respect to time\n\nOutput\n\nAngular velocity vector defined by q\' anddq\'\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.qxq-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.qxq",
    "category": "method",
    "text": "qxq(q1,q2)\n\nMultiply two quaternions. \n\nArguments\n\nq1: First SPICE quaternion factor (as any kind of iterable with four elements)\nq2: Second SPICE quaternion factor (as any kind of iterable with four elements)\n\nOutput\n\nA quaternion corresponding to the product of q1\' andq2\'\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.radrec-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.radrec",
    "category": "method",
    "text": "radrec(range, ra, dec)\n\nConvert from range, right ascension, and declination to rectangular coordinates.\n\nArguments\n\nrange: Distance of a point from the origin\nra: Right ascension of point in radians\ndec: Declination of point in radians\n\nOutput\n\nReturns the rectangular coordinates of the point.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.rav2xf-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.rav2xf",
    "category": "method",
    "text": "rav2xf(rot, av)\n\nDetermine a state transformation matrix from a rotation matrix and the angular velocity of the rotation.\n\nArguments\n\nrot: Rotation matrix\nav: Angular velocity vector\n\nOutput\n\nReturns state transformation matrix associated with rot and av.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.raxisa-Tuple{Any}",
    "page": "API",
    "title": "SPICE.raxisa",
    "category": "method",
    "text": "raxisa(matrix)\n\nCompute the axis of the rotation given by an input matrix and the angle of the rotation about that axis.\n\nArguments\n\nmatrix: A 3x3 rotation matrix\n\nOutput\n\naxis: Axis of the rotation\nangle: Angle through which the rotation is performed\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.reccyl-Tuple{Any}",
    "page": "API",
    "title": "SPICE.reccyl",
    "category": "method",
    "text": "reccyl(rectan)\n\nConvert from rectangular to cylindrical coordinates.\n\nArguments\n\nrectan: Rectangular coordinates of a point\n\nOutput\n\nr: Distance of the point from the Z axis\nlon: Angle (radians) of the point from the XZ plane\nz: Height of the point above the XY plane\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.recgeo-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.recgeo",
    "category": "method",
    "text": "recgeo(rectan, re, f)\n\nConvert from rectangular coordinates to geodetic coordinates.\n\nArguments\n\nrectan: Rectangular coordinates of a point\nre: Equatorial radius of the reference spheroid\nf: Flattening coefficient\n\nOutput\n\nlon: Geodetic longitude of the point (radians)\nlat: Geodetic latitude  of the point (radians)\nalt: Altitude of the point above reference spheroid\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.reclat-Tuple{Any}",
    "page": "API",
    "title": "SPICE.reclat",
    "category": "method",
    "text": "reclat(rectan)\n\nConvert from rectangular coordinates to latitudinal coordinates.\n\nArguments\n\nrectan: Rectangular coordinates of a point\n\nOutput\n\nReturns a tuple consisting of:\n\nrad: Distance of the point from the origin\nlon: Planetographic longitude of the point (radians)\nlat: Planetographic latitude of the point (radians)\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.recpgr-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.recpgr",
    "category": "method",
    "text": "recpgr(body, rectan, re, f)\n\nConvert rectangular coordinates to planetographic coordinates.\n\nArguments\n\nbody: Body with which coordinate system is associated\nrectan: Rectangular coordinates of a point\nre: Equatorial radius of the reference spheroid\nf: flattening coefficient\n\nOutput\n\nlon: Planetographic longitude of the point (radians).\nlat: Planetographic latitude of the point (radians).\nalt: Altitude of the point above reference spheroid.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.recrad-Tuple{Any}",
    "page": "API",
    "title": "SPICE.recrad",
    "category": "method",
    "text": "recrad(rectan)\n\nConvert rectangular coordinates to range, right ascension, and declination.\n\nArguments\n\nrectan: Rectangular coordinates of a point\n\nOutput\n\nReturn the tuple (range, ra, dec).\n\nrange: Distance of the point from the origin\nra: Right ascension in radians\ndec: Declination in radians\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.recsph-Tuple{Any}",
    "page": "API",
    "title": "SPICE.recsph",
    "category": "method",
    "text": "recsph(rectan)\n\nConvert from rectangular coordinates to spherical coordinates.\n\nArguments\n\nrectan: Rectangular coordinates of a point\n\nOutput\n\nr: Distance of the point from the origin\ncolat: Angle of the point from the Z-axis in radian\nlon: Longitude of the point in radians\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.removc!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.removc!",
    "category": "method",
    "text": "removc!(set, item)\n\nRemove an item from a character set.\n\nArguments\n\nset: A set\nitem: Item to be removed\n\nOutput\n\nReturns the updated set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.removd!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.removd!",
    "category": "method",
    "text": "removd!(set, item)\n\nRemove an item from a double set.\n\nArguments\n\nset: A set\nitem: Item to be removed\n\nOutput\n\nReturns the updated set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.removi!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.removi!",
    "category": "method",
    "text": "removi!(set, item)\n\nRemove an item from a character set.\n\nArguments\n\nset: A set\nitem: Item to be removed\n\nOutput\n\nReturns the updated set.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.reordc",
    "page": "API",
    "title": "SPICE.reordc",
    "category": "function",
    "text": "reordc(iorder, array)\n\n!!! warning Deprecated     Use array[iorder] instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.reordd",
    "page": "API",
    "title": "SPICE.reordd",
    "category": "function",
    "text": "reordd(iorder, array)\n\n!!! warning Deprecated     Use array[iorder] instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.reordi",
    "page": "API",
    "title": "SPICE.reordi",
    "category": "function",
    "text": "reordi(iorder, array)\n\n!!! warning Deprecated     Use array[iorder] instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.reordl",
    "page": "API",
    "title": "SPICE.reordl",
    "category": "function",
    "text": "reordl(iorder, array)\n\n!!! warning Deprecated     Use array[iorder] instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.repmc",
    "page": "API",
    "title": "SPICE.repmc",
    "category": "function",
    "text": "repmc(input, marker, value)\n\n!!! warning Deprecated     Use replace(input, marker=>value) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.repmct",
    "page": "API",
    "title": "SPICE.repmct",
    "category": "function",
    "text": "repmct\n\n!!! warning Deprecated     Use replace instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.repmd",
    "page": "API",
    "title": "SPICE.repmd",
    "category": "function",
    "text": "repmd\n\n!!! warning Deprecated     Use replace instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.repmf",
    "page": "API",
    "title": "SPICE.repmf",
    "category": "function",
    "text": "repmf\n\n!!! warning Deprecated     Use replace instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.repmi",
    "page": "API",
    "title": "SPICE.repmi",
    "category": "function",
    "text": "repmi\n\n!!! warning Deprecated     Use replace instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.repmot",
    "page": "API",
    "title": "SPICE.repmot",
    "category": "function",
    "text": "repmot\n\n!!! warning Deprecated     Use replace instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.rotate-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.rotate",
    "category": "method",
    "text": "rotate(angle, iaxis)\n\nCalculate the 3x3 rotation matrix generated by a rotation of a specified angle about a specified axis. This rotation is thought of as rotating the coordinate system.\n\nArguments\n\nangle: Angle of rotation (radians)\niaxis: Axis of rotation (X=1, Y=2, Z=3)\n\nOutput\n\nReturns rotation matrix associated with angle and iaxis.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.rotmat-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.rotmat",
    "category": "method",
    "text": "rotmat(m1, angle, iaxis)\n\nApplies a rotation of angle radians about axis iaxis to a matrix m1. This rotation is thought of as rotating the coordinate system.\n\nArguments\n\nm1: Matrix to be rotated\nangle: Angle of rotation (radians)\niaxis: Axis of rotation (X=1, Y=2, Z=3)\n\nOutput\n\nReturns the resulting rotated matrix.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.rotvec-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.rotvec",
    "category": "method",
    "text": "rotvec(v1, angle, iaxis)\n\nTransform a vector to a new coordinate system rotated by angle radians about axis iaxis. This transformation rotates v1 by -angle radians about the specified axis.\n\nArguments\n\nv1: Vector whose coordinate system is to be rotated\nangle: Angle of rotation in radians\niaxis: Axis of rotation (X=1, Y=2, Z=3)\n\nOutput\n\nReturns the resulting vector expressed in the new coordinate system.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.rpd",
    "page": "API",
    "title": "SPICE.rpd",
    "category": "function",
    "text": "rpd()\n\n!!! warning Deprecated     Use deg2rad instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.rquad-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.rquad",
    "category": "method",
    "text": "Arguments\n\nOutput\n\nReturns nothing if no kernel was found or\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.saelgv-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.saelgv",
    "category": "method",
    "text": "saelgv(vec1, vec2)\n\nFind semi-axis vectors of an ellipse generated by two arbitrary three-dimensional vectors.\n\nArguments\n\nvec1, vec2: Two vectors used to generate an ellipse\n\nOutput\n\nsmajor: Semi-major axis of ellipse\nsminor: Semi-minor axis of ellipse\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.scard!-Union{Tuple{T}, Tuple{SpiceCell{T,T1,N} where N where T1,Any}} where T",
    "page": "API",
    "title": "SPICE.scard!",
    "category": "method",
    "text": "scard!(cell::SpiceCell{T}, card) where T\n\nSet the cardinality of a cell.\n\nArguments\n\ncell: The cell\ncard: Cardinality of (number of elements in) the cell\n\nOutput\n\nReturns cell with its cardinality set to card.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.scdecd",
    "page": "API",
    "title": "SPICE.scdecd",
    "category": "function",
    "text": "scdecd(sc, sclkdp, lenout=128)\n\nConvert double precision encoding of spacecraft clock time into a character representation.\n\nArguments\n\nsc: NAIF spacecraft identification code\nsclkdp: Encoded representation of a spacecraft clock count\nlenout: Maximum allowed length of output SCLK string\n\nOutput\n\nReturns the character representation of a clock count.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sce2c-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.sce2c",
    "category": "method",
    "text": "sce2c(sc, et)\n\nConvert ephemeris seconds past J2000 (ET) to continuous encoded spacecraft clock (\"ticks\"). Non-integral tick values may be returned.\n\nArguments\n\nsc: NAIF spacecraft ID code\net: Ephemeris time, seconds past J2000\n\nOutput\n\nReturns SCLK, encoded as ticks since spacecraft clock start.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sce2s",
    "page": "API",
    "title": "SPICE.sce2s",
    "category": "function",
    "text": "sce2s(sc, et, lenout=128)\n\nConvert an epoch specified as ephemeris seconds past J2000 (ET) to a character string representation of a spacecraft clock value (SCLK).\n\nArguments\n\nsc: NAIF spacecraft identification code\net: Ephemeris time, specified as seconds past J2000\nlenout: Maximum allowed length of output SCLK string\n\nOutput\n\nReturns an SCLK string.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sce2t-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.sce2t",
    "category": "method",
    "text": "sce2t(sc, et)\n\nConvert ephemeris seconds past J2000 (ET) to integral encoded spacecraft clock (\"ticks\"). For conversion to fractional ticks, (required for C-kernel production), see the routine sce2c.\n\nArguments\n\nsc: NAIF spacecraft ID code\net: Ephemeris time, seconds past J2000\n\nOutput\n\nReturns SCLK, encoded as ticks since spacecraft clock start.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.scencd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.scencd",
    "category": "method",
    "text": "scencd(sc, sclkch)\n\nEncode character representation of spacecraft clock time into a double precision number.\n\nArguments\n\nsc: NAIF spacecraft identification code\nsclkch: Character representation of a spacecraft clock\n\nOutput\n\nReturns the encoded representation of the clock count.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.scfmt",
    "page": "API",
    "title": "SPICE.scfmt",
    "category": "function",
    "text": "scfmt(sc, ticks, lenout=128)\n\nConvert encoded spacecraft clock ticks to character clock format.\n\nArguments\n\nsc: NAIF spacecraft identification code\nticks: Encoded representation of a spacecraft clock count\nlenout: Maximum allowed length of output string\n\nOutput\n\nReturns a character representation of a clock count.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.scpart-Tuple{Any}",
    "page": "API",
    "title": "SPICE.scpart",
    "category": "method",
    "text": "scpart(sc)\n\nGet spacecraft clock partition information from a spacecraft clock kernel file.\n\nArguments\n\nsc: NAIF spacecraft identification code\n\nOutput\n\nnparts: The number of spacecraft clock partitions\npstart: Array of partition start times\npstop: Array of partition stop times\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.scs2e-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.scs2e",
    "category": "method",
    "text": "scs2e(sc, sclkch)\n\nConvert a spacecraft clock string to ephemeris seconds past J2000 (ET).\n\nArguments\n\nsc: NAIF integer code for a spacecraft\nsclkch: An SCLK string\n\nOutput\n\nReturns ephemeris time seconds past J2000.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sct2e-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.sct2e",
    "category": "method",
    "text": "sct2e(sc, sclkdp)\n\nConvert encoded spacecraft clock (\"ticks\") to ephemeris seconds past J2000 (ET).\n\nArguments\n\nsc: NAIF integer code for a spacecraft\nsclkdp: SCLK, encoded as ticks since spacecraft clock start.\n\nOutput\n\nReturns ephemeris time seconds past J2000.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sctiks-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.sctiks",
    "category": "method",
    "text": "sctiks(sc, clkstr)\n\nConvert a spacecraft clock format string to number of \"ticks\".\n\nArguments\n\nsc: NAIF spacecraft identification code\nclkstr: Character representation of a spacecraft clock\n\nOutput\n\nReturns the number of ticks represented by the clock string.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sdiff-Union{Tuple{T}, Tuple{SpiceCell{T,T1,N} where N where T1,SpiceCell{T,T1,N} where N where T1}} where T",
    "page": "API",
    "title": "SPICE.sdiff",
    "category": "method",
    "text": "sdiff(a::T, b::T) where T <: SpiceCell\n\nCompute the symmetric difference of two sets of any data type to form a third set.\n\nArguments\n\na: First input set\nb: Second input set\n\nOutput\n\nReturns a cell containing the symmetric difference of a and b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.set-Union{Tuple{T}, Tuple{SpiceCell{T,T1,N} where N where T1,Any,SpiceCell{T,T1,N} where N where T1}} where T",
    "page": "API",
    "title": "SPICE.set",
    "category": "method",
    "text": "set(a::T, b::T) where T <: SpiceCell\n\nGiven a relational operator, compare two sets of any data type.\n\nArguments\n\na: First set\nop: Comparison operator\nb: Second set\n\nOutput\n\nReturns the result of the comparison: a (op) b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.shellc",
    "page": "API",
    "title": "SPICE.shellc",
    "category": "function",
    "text": "shellc(array)\n\nwarning: Deprecated\nUse sort!(array) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.shelld",
    "page": "API",
    "title": "SPICE.shelld",
    "category": "function",
    "text": "shelld(array)\n\nwarning: Deprecated\nUse sort!(array) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.shelli",
    "page": "API",
    "title": "SPICE.shelli",
    "category": "function",
    "text": "shelli(array)\n\nwarning: Deprecated\nUse sort!(array) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sincpt-NTuple{8,Any}",
    "page": "API",
    "title": "SPICE.sincpt",
    "category": "method",
    "text": "sincpt(method, target, et, fixref, abcorr, obsrvr, dref, dvec)\n\nGiven an observer and a direction vector defining a ray, compute the surface intercept of the ray on a target body at a specified epoch, optionally corrected for light time and stellar aberration.\n\nThe surface of the target body may be represented by a triaxial ellipsoid or by topographic data provided by DSK files.\n\nArguments\n\nmethod: Computation method\ntarget: Name of target body\net: Epoch in TDB seconds past J2000 TDB\nfixref: Body-fixed, body-centered target body frame\nabcorr: Aberration correction flag\nobsrvr: Name of observing body\ndref: Reference frame of ray\'s direction vector\ndvec: Ray\'s direction vector\n\nOutput\n\nReturns a tuple consisting of the following data or nothing if no intercept was found.\n\nspoint: Surface intercept point on the target body\ntrgepc: Intercept epoch\nsrfvec: Vector from observer to intercept point\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spd-Tuple{}",
    "page": "API",
    "title": "SPICE.spd",
    "category": "method",
    "text": "spd()\n\nReturns the number of seconds in a day.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sphcyl-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.sphcyl",
    "category": "method",
    "text": "sphcyl(radius, colat, slon)\n\nConverts from spherical coordinates to cylindrical coordinates.\n\nArguments\n\nradius: Distance of point from origin\ncolat: Polar angle (co-latitude in radians) of point\nslon: Azimuthal angle (longitude) of point (radians)\n\nOutput\n\nr: Distance of point from Z axis\nlon: Angle (radians) of point from XZ plane\nz: Height of point above XY plane\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sphlat-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.sphlat",
    "category": "method",
    "text": "sphlat(r, colat, lons)\n\nConvert from spherical coordinates to latitudinal coordinates.\n\nArguments\n\nr: Distance of the point from the origin\ncolat: Angle of the point from positive z axis (radians)\nlons: Angle of the point from the XZ plane (radians)\n\nOutput\n\nradius: Distance of a point from the origin\nlon: Angle of the point from the XZ plane in radians\nlat: Angle of the point from the XY plane in radians\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sphrec-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.sphrec",
    "category": "method",
    "text": "sphrec(r, colat, lon)\n\nConvert from spherical coordinates to rectangular coordinates.\n\nArguments\n\nr: Distance of a point from the origin\ncolat: Angle of the point from the Z-axis in radians\nlon: Angle of the point from the XZ plane in radians\n\nOutput\n\nReturns the rectangular coordinates of the point.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spk14a-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.spk14a",
    "category": "method",
    "text": "spk14a(handle, ncsets, coeffs, epochs)\n\nAdd data to a type 14 SPK segment associated with handle. See also spk14b and spk14e.\n\nArguments\n\nhandle: The handle of an SPK file open for writing\nncsets: The number of coefficient sets and epochs\ncoeffs: The collection of coefficient sets\nepochs: The epochs associated with the coefficient sets\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spk14b-NTuple{8,Any}",
    "page": "API",
    "title": "SPICE.spk14b",
    "category": "method",
    "text": "spk14b(handle, segid, body, center, frame, first, last, chbdeg)\n\nBegin a type 14 SPK segment in the SPK file associated with handle. See also spk14a and spk14e.\n\nArguments\n\nhandle: The handle of an SPK file open for writing\nsegid: The string to use for segment identifier\nbody: The NAIF ID code for the body of the segment\ncenter: The center of motion for body\nframe: The reference frame for this segment\nfirst: The first epoch for which the segment is valid\nlast: The last epoch for which the segment is valid\nchbdeg: The degree of the Chebyshev Polynomial used\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spk14e-Tuple{Any}",
    "page": "API",
    "title": "SPICE.spk14e",
    "category": "method",
    "text": "spk14e(handle)\n\nEnd the type 14 SPK segment currently being written to the SPK file associated with handle. See also spk14a and spk14b.\n\nArguments\n\nhandle: The handle of an SPK file open for writing\n\nOutput\n\nReturns the handle of the SPK file.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkacs-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.spkacs",
    "category": "method",
    "text": "spkacs(targ, et, ref, abcorr, obs, starg, lt, dlt)\n\nReturn the state (position and velocity) of a target body relative to an observer, optionally corrected for light time and stellar aberration, expressed relative to an inertial reference frame.\n\nArguments\n\ntarg: Target body\net: Observer epoch\nref: Inertial reference frame of output state\nabcorr: Aberration correction flag\nobs: Observer\n\nOutput\n\nstarg: State of target\nlt: One way light time between observer and target\ndlt: Derivative of light time with respect to time\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkapo-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.spkapo",
    "category": "method",
    "text": "spkapo(targ, et, ref, sobs, abcorr)\n\nReturn the position of a target body relative to an observer, optionally corrected for light time and stellar aberration.\n\nArguments\n\ntarg: Target body\net: Observer epoch\nref: Inertial reference frame of observer\'s state\nsobs: State of observer wrt. solar system barycenter\nabcorr: Aberration correction flag\n\nOutput\n\nptarg: Position of target\nlt: One way light time between observer and target\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkaps-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.spkaps",
    "category": "method",
    "text": "spkaps(targ, et, ref, abcorr, stobs, accobs)\n\nGiven the state and acceleration of an observer relative to the solar system barycenter, return the state (position and velocity) of a target body relative to the observer, optionally corrected for light time and stellar aberration. All input and output vectors are expressed relative to an inertial reference frame.\n\nUsers normally should call the high-level API routines spkezr or spkez rather than this routine.\n\nArguments\n\ntarg: Target body.\net: Observer epoch.\nref: Inertial reference frame of output state.\nabcorr: Aberration correction flag.\nstobs: State of the observer relative to the SSB.\naccobs: Acceleration of the observer relative to the SSB.\n\nOutput\n\nstarg: State of target.\nlt: One way light time between observer and target.\ndlt: Derivative of light time with respect to time.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkcls-Tuple{Any}",
    "page": "API",
    "title": "SPICE.spkcls",
    "category": "method",
    "text": "spkcls(handle)\n\nClose an open SPK file.\n\nArguments\n\nhandle: Handle of the SPK file to be closed\n\nOutput\n\nReturns the handle of the closed file.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkcov",
    "page": "API",
    "title": "SPICE.spkcov",
    "category": "function",
    "text": "spkcov!(cover, spk, idcode)\nspkcov(spk, idcode)\n\nFind the coverage window for a specified ephemeris object in a specified SPK file.\n\nArguments\n\ncover: Window giving coverage in spk for idcode\nspk: Name of the SPK file\nidcode: ID code of ephemeris object\n\nOutput\n\nReturns the extended coverage window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkcpo-NTuple{7,Any}",
    "page": "API",
    "title": "SPICE.spkcpo",
    "category": "method",
    "text": "Returns the state of a target body relative to a constant-position observer location.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/spkcpoc.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkezr-Tuple{AbstractString,Float64,AbstractString,AbstractString}",
    "page": "API",
    "title": "SPICE.spkezr",
    "category": "method",
    "text": "Returns the state of a target body relative to an observing body.\n\nNAIF documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkobj!",
    "page": "API",
    "title": "SPICE.spkobj!",
    "category": "function",
    "text": "spkobj!(ids, spk)\nspkobj(spk)\n\nFind the set of ID codes of all objects in a specified SPK file.\n\nArguments\n\nids: A preallocated set of ID codes of objects in SPK file\nspk: Name of the SPK file\n\nOutput\n\nReturns the set of id codes.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkopn",
    "page": "API",
    "title": "SPICE.spkopn",
    "category": "function",
    "text": "spkopn(name, ifname=\"\", ncomch=0)\n\nCreate a new SPK file, returning the handle of the opened file.\n\nArguments\n\nname: The name of the new SPK file to be created\nifname: The internal filename for the SPK file (default: \"\")\nncomch: The number of characters to reserve for comments (default: 0)\n\nOutput\n\nReturns the handle of the opened SPK file.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkpos-Tuple{AbstractString,Float64,AbstractString,AbstractString}",
    "page": "API",
    "title": "SPICE.spkpos",
    "category": "method",
    "text": "Returns the state of a target body relative to an observing body.\n\nNAIF documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.spkssb-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.spkssb",
    "category": "method",
    "text": "spkssb(targ, et, ref)\n\nReturn the state (position and velocity) of a target body relative to the solar system barycenter.\n\nArguments\n\ntarg: Target body\net: Target epoch\nref: Target reference frame\n\nOutput\n\nReturns the state of target.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.subpnt-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.subpnt",
    "category": "method",
    "text": "subpnt(method, target, et, fixref, obsrvr, abcorr)\n\nCompute the rectangular coordinates of the sub-observer point on a target body at a specified epoch, optionally corrected for light time and stellar aberration.\n\nArguments\n\nmethod: Computation method.\ntarget: Name of target body.\net: Epoch in ephemeris seconds past J2000 TDB.\nfixref: Body-fixed, body-centered target body frame.\nobsrvr: Name of observing body.\nabcorr: Aberration correction.\n\nOutput\n\nspoint: Sub-solar point on the target body.\ntrgepc: Sub-solar point epoch.\nsrfvec: Vector from observer to sub-solar point.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.subslr-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.subslr",
    "category": "method",
    "text": "subslr(method, target, et, fixref, obsrvr, abcorr)\n\nCompute the rectangular coordinates of the sub-solar point on a target body at a specified epoch, optionally corrected for light time and stellar aberration.\n\nArguments\n\nmethod: Computation method.\ntarget: Name of target body.\net: Epoch in ephemeris seconds past J2000 TDB.\nfixref: Body-fixed, body-centered target body frame.\nobsrvr: Name of observing body.\nabcorr: Aberration correction.\n\nOutput\n\nspoint: Sub-solar point on the target body.\ntrgepc: Sub-solar point epoch.\nsrfvec: Vector from observer to sub-solar point.\n\nReturns cell with its cardinality set to card.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.surfpt-NTuple{5,Any}",
    "page": "API",
    "title": "SPICE.surfpt",
    "category": "method",
    "text": "surfpt(positn, u, a, b, c)\n\nDetermine the intersection of a line-of-sight vector with the surface of an ellipsoid.\n\nArguments\n\npositn: Position of the observer in body-fixed frame\nu: Vector from the observer in some direction\na: Length of the ellipsoid semi-axis along the x-axis\nb: Length of the ellipsoid semi-axis along the y-axis\nc: Length of the ellipsoid semi-axis along the z-axis\n\nOutput\n\nReturns the point on the ellipsoid pointed to by u or nothing if none was found.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.swpool-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.swpool",
    "category": "method",
    "text": "swpool(agent, names)\n\nAdd a name to the list of agents to notify whenever a member of a list of kernel variables is updated.\n\nArguments\n\nagent: The name of an agent to be notified after updates\nnames: Variable names whose update causes the notice\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.sxform-Tuple{String,String,Float64}",
    "page": "API",
    "title": "SPICE.sxform",
    "category": "method",
    "text": "Return the state transformation matrix from one frame to another at a specified epoch.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkitdocs/C/cspice/sxformc.html\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.timdef",
    "page": "API",
    "title": "SPICE.timdef",
    "category": "function",
    "text": "timdef(action, item, value=\"\")\n\nSet and retrieve the defaults associated with calendar input strings.\n\nArguments\n\naction: The kind of action to take, either :SET or :GET\nitem: The default item of interest. The items that may be requested are:\n:CALENDAR with allowed values:\n\"GREGORIAN\"\n\"JULIAN\"\n\"MIXED\"\n:SYSTEM with allowed values:\n\"TDB\"\n\"TDT\"\n\"UTC\"\n:ZONE with allowed values (0 <= HR < 13 and 0 <= MN < 60):\n\"EST\"\n\"EDT\"\n\"CST\"\n\"CDT\"\n\"MST\"\n\"MDT\"\n\"PST\"\n\"PDT\"\n\"UTC+$HR\"\n\"UTC-$HR\"\n\"UTC+$HR:$MN\"\n\"UTC-$HR:$MN\"\n\nOutput\n\nReturns the value associated with the default item.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.timout",
    "page": "API",
    "title": "SPICE.timout",
    "category": "function",
    "text": "timout(et, pictur, lenout=128)\n\nThis routine converts an input epoch represented in TDB seconds past the TDB epoch of J2000 to a character string formatted to the specifications of a user\'s format picture.\n\nArguments\n\net: An epoch in seconds past the ephemeris epoch J2000\npictur: A format specification for the output string\nlenout: The length of the output string plus 1 (default: 128)\n\nOutput\n\nReturns a string representation of the input epoch.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.tipbod-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.tipbod",
    "category": "method",
    "text": "tipbod(ref, body, et)\n\nReturn a 3x3 matrix that transforms positions in inertial coordinates to positions in body-equator-and-prime-meridian coordinates.\n\nArguments\n\nref: Name of inertial reference frame to transform from\nbody: ID code of body\net: Epoch of transformation\n\nOutput\n\nReturns transformation matrix from intertial position to prime meridian.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.tisbod-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.tisbod",
    "category": "method",
    "text": "tisbod(ref, body, et)\n\nReturn a 6x6 matrix that transforms states in inertial coordinates to states in body-equator-and-prime-meridian coordinates.\n\nArguments\n\nref: Name of inertial reference frame to transform from\nbody: ID code of body\net: Epoch of transformation\n\nOutput\n\nReturns transformation matrix from intertial state to prime meridian.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.tkvrsn",
    "page": "API",
    "title": "SPICE.tkvrsn",
    "category": "function",
    "text": "tkvrsn(item=:TOOLKIT)\n\nGiven an item such as the Toolkit or an entry point name, return the latest version string.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.tparse-Tuple{Any}",
    "page": "API",
    "title": "SPICE.tparse",
    "category": "method",
    "text": "tparse(string)\n\nParse a time string and return seconds past the J2000 epoch on a formal calendar. \n\nArguments\n\nstring: Input time string in UTC\n\nOutput\n\nReturns UTC expressed in seconds since J2000.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.tpictr",
    "page": "API",
    "title": "SPICE.tpictr",
    "category": "function",
    "text": "tpictr(sample, lenout=80)\n\nGiven a sample time string, create a time format picture suitable for use by the routine timout.\n\nArguments\n\nsample: A sample time string\nlenout: The length for the output picture string (default: 80)\n\nOutput\n\nReturns a format picture that describes sample.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.trace",
    "page": "API",
    "title": "SPICE.trace",
    "category": "function",
    "text": "trace(matrix)\n\nwarning: Deprecated\nUse LinearAlgebra.tr(matrix) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.tsetyr-Tuple{Any}",
    "page": "API",
    "title": "SPICE.tsetyr",
    "category": "method",
    "text": "tsetyr(year)\n\nSet the lower bound on the 100 year range.\n\nArguments\n\n-year: Lower bound on the 100 year interval of expansion\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.twopi",
    "page": "API",
    "title": "SPICE.twopi",
    "category": "function",
    "text": "twopi()\n\nwarning: Deprecated\nUse 2π instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.twovec-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.twovec",
    "category": "method",
    "text": "twovec(axdef, indexa, plndef, indexp)\n\nFind the transformation to the right-handed frame having a given vector as a specified axis and having a second given vector lying in a specified coordinate plane.\n\nArguments\n\naxdef: Vector defining a principal axis\nindexa: Principal axis number of axdef (X=1, Y=2, Z=3)\nplndef: Vector defining (with axdef) a principal plane\nindexp: Second axis number (with indexa) of principal plane\n\nOutput\n\nReturns output rotation matrix.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.tyear-Tuple{}",
    "page": "API",
    "title": "SPICE.tyear",
    "category": "method",
    "text": "tyear()\n\nReturns the number of seconds per tropical year.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ucase",
    "page": "API",
    "title": "SPICE.ucase",
    "category": "function",
    "text": "ucase(in)\n\nwarning: Deprecated\nUse uppercase(in) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.ucrss",
    "page": "API",
    "title": "SPICE.ucrss",
    "category": "function",
    "text": "ucrss(v1, v2)\n\nwarning: Deprecated\nUse LinearAlgebra.normalize(LinearAlgebra.cross(v1, v2)) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.uddf-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.uddf",
    "category": "method",
    "text": "uddf(udfunc, x, dx)\n\nRoutine to calculate the first derivative of a caller-specified function using a three-point estimation.\n\nArguments\n\nudfunc: A callable that computes the scalar value of interest,   e.g. f(x::Float64) -> Float64.\nx: Independent variable of \'udfunc\'\ndx: Interval from x for derivative calculation\n\nOutput\n\nReturns the approximate derivative of udfunc at x.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.unitim-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.unitim",
    "category": "method",
    "text": "unitim(epoch, insys, outsys)\n\nTransform time from one uniform scale to another.\n\nArguments\n\nepoch: An epoch to be converted\ninsys: The time scale associated with the input epoch\noutsys: The time scale associated with the function value\n\nThe uniform time scales are:\n\n:TAI\n:TDT\n:TDB\n:ET\n:JED\n:JDTDB\n:JDTDT\n\nOutput\n\nReturns the time in the system specified by outsys that is equivalent to the epoch in the insys time scale.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.unload-Tuple{Any}",
    "page": "API",
    "title": "SPICE.unload",
    "category": "method",
    "text": "unload(file)\n\nUnload a SPICE kernel.\n\nArguments\n\nfile: The file name of a kernel to unload\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.unorm",
    "page": "API",
    "title": "SPICE.unorm",
    "category": "function",
    "text": "unorm(v1)\n\nwarning: Deprecated\nUse (LinearAlgebra.normalize(v1), LinearAlgebra.norm(v1)) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.unormg",
    "page": "API",
    "title": "SPICE.unormg",
    "category": "function",
    "text": "unormg(v1)\n\nwarning: Deprecated\nUse (LinearAlgebra.normalize(v1), LinearAlgebra.norm(v1)) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.utc2et-Tuple{Any}",
    "page": "API",
    "title": "SPICE.utc2et",
    "category": "method",
    "text": "utc2et(utcstr)\n\nConvert an input time from Calendar or Julian Date format, UTC, to ephemeris seconds past J2000.\n\nArguments\n\nutcstr: Input time string, UTC\n\nOutput\n\nReturns the equivalent of utcstr, expressed in ephemeris seconds past J2000.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vadd",
    "page": "API",
    "title": "SPICE.vadd",
    "category": "function",
    "text": "vadd(v1, v2)\n\nwarning: Deprecated\nUse v1 .+ v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vaddg",
    "page": "API",
    "title": "SPICE.vaddg",
    "category": "function",
    "text": "vaddg(v1, v2)\n\nwarning: Deprecated\nUse v1 .+ v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.valid!-Union{Tuple{SpiceCell{T,T1,N} where N where T1}, Tuple{T}} where T",
    "page": "API",
    "title": "SPICE.valid!",
    "category": "method",
    "text": "valid!(set::SpiceCell{T}) where T\n\nCreate a valid SPICE set from a SPICE Cell of any data type.\n\nArguments\n\nset: Set to be validated\n\nOutput\n\nReturns the validated set with ordered elements and duplicates removed.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vcrss",
    "page": "API",
    "title": "SPICE.vcrss",
    "category": "function",
    "text": "vcrss(v1, v2)\n\nwarning: Deprecated\nUse LinearAlgebra.cross(v1, v2) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vdist",
    "page": "API",
    "title": "SPICE.vdist",
    "category": "function",
    "text": "vdist(v1, v2)\n\nwarning: Deprecated\nUse LinearAlgebra.norm(v1 .- v2) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vdistg",
    "page": "API",
    "title": "SPICE.vdistg",
    "category": "function",
    "text": "vdistg(v1, v2)\n\nwarning: Deprecated\nUse LinearAlgebra.norm(v1 .- v2) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vdot",
    "page": "API",
    "title": "SPICE.vdot",
    "category": "function",
    "text": "vdot(v1, v2)\n\nwarning: Deprecated\nUse LinearAlgebra.dot(v1, v2) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vdotg",
    "page": "API",
    "title": "SPICE.vdotg",
    "category": "function",
    "text": "vdotg(v1, v2)\n\nwarning: Deprecated\nUse LinearAlgebra.dot(v1, v2) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vequ",
    "page": "API",
    "title": "SPICE.vequ",
    "category": "function",
    "text": "vequ(v1, v2)\n\nwarning: Deprecated\nUse v1 .= v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vequg",
    "page": "API",
    "title": "SPICE.vequg",
    "category": "function",
    "text": "vequg(v1, v2)\n\nwarning: Deprecated\nUse v1 .= v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vhat",
    "page": "API",
    "title": "SPICE.vhat",
    "category": "function",
    "text": "vhat(v1)\n\nwarning: Deprecated\nUse LinearAlgebra.normalize(v1) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vhatg",
    "page": "API",
    "title": "SPICE.vhatg",
    "category": "function",
    "text": "vhatg(v1)\n\nwarning: Deprecated\nUse LinearAlgebra.normalize(v1) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vlcom",
    "page": "API",
    "title": "SPICE.vlcom",
    "category": "function",
    "text": "vlcom(a, v1, b, v2)\n\nwarning: Deprecated\nUse a .* v1 .+ b .* v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vlcom3",
    "page": "API",
    "title": "SPICE.vlcom3",
    "category": "function",
    "text": "vlcom3(a, v1, b, v2, c, v3)\n\nwarning: Deprecated\nUse a .* v1 .+ b .* v2 .+ c .* v3 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vlcomg",
    "page": "API",
    "title": "SPICE.vlcomg",
    "category": "function",
    "text": "vlcomg(a, v1, b, v2)\n\nwarning: Deprecated\nUse a .* v1 .+ b .* v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vminug",
    "page": "API",
    "title": "SPICE.vminug",
    "category": "function",
    "text": "vminug(vin)\n\nwarning: Deprecated\nUse -vin instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vminus",
    "page": "API",
    "title": "SPICE.vminus",
    "category": "function",
    "text": "vminus(vin)\n\nwarning: Deprecated\nUse -vin instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vnorm",
    "page": "API",
    "title": "SPICE.vnorm",
    "category": "function",
    "text": "vnorm(v1)\n\nwarning: Deprecated\nUse LinearAlgebra.norm(v1) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vnormg",
    "page": "API",
    "title": "SPICE.vnormg",
    "category": "function",
    "text": "vnormg(v1, v2)\n\nwarning: Deprecated\nUse LinearAlgebra.norm(v1) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vpack",
    "page": "API",
    "title": "SPICE.vpack",
    "category": "function",
    "text": "vpack(x, y, z)\n\nwarning: Deprecated\nUse [x, y, z] instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vperp-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.vperp",
    "category": "method",
    "text": "vperp(a, b)\n\nFind the component of a vector that is perpendicular to a second vector.\n\nArguments\n\na: The vector whose orthogonal component is sought\nb: The vector used as the orthogonal reference\n\nOutput\n\nReturns the component a orthogonal to b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vprjp-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.vprjp",
    "category": "method",
    "text": "vprjp(vin, plane)\n\nProject a vector onto a specified plane, orthogonally.\n\nArguments\n\nvin: Vector to be projected\nplane: Plane onto which vin is projected\n\nOutput\n\nReturns the vector resulting from the projection.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vprjpi-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.vprjpi",
    "category": "method",
    "text": "vprjpi(vin, projpl, invpl)\n\nFind the vector in a specified plane that maps to a specified vector in another plane under orthogonal projection.\n\nArguments\n\nvin: The projected vector\nprojpl: Plane containing vin\ninvpl: Plane containing inverse image of vin\n\nOutput\n\nReturns the inverse projection of vin or nothing if vin could not be calculated.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vproj-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.vproj",
    "category": "method",
    "text": "vproj(a, b)\n\nFinds the projection of one vector onto another vector. All vectors are 3-dimensional.\n\nArguments\n\na: The vector to be projected\nb: The vector onto which a is to be projected\n\nOutput\n\nReturns the projection of a onto b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vrel-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.vrel",
    "category": "method",
    "text": "vrel(v1, v2)\n\nReturn the relative difference between two 3-dimensional vectors.\n\nArguments\n\nv1, v2: Two three-dimensional input vectors\n\nOutput\n\nReturns the relative differences between v1 and v2.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vrelg-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.vrelg",
    "category": "method",
    "text": "vrelg(v1, v2)\n\nReturn the relative difference between two vectors.\n\nArguments\n\nv1, v2: Input vectors\n\nOutput\n\nReturns the relative differences between v1 and v2.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vrotv-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.vrotv",
    "category": "method",
    "text": "vrotv(v, axis, theta)\n\nRotate a vector about a specified axis vector by a specified angle and return the rotated vector.\n\nArguments\n\nv: Vector to be rotated\naxis: Axis of the rotation\ntheta: Angle of rotation (radians)\n\nOutput\n\nResult of rotating v about axis by theta.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vscl",
    "page": "API",
    "title": "SPICE.vscl",
    "category": "function",
    "text": "vscl(s, v1)\n\nwarning: Deprecated\nUse s .* v1 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vsclg",
    "page": "API",
    "title": "SPICE.vsclg",
    "category": "function",
    "text": "vsclg(s, v1)\n\nwarning: Deprecated\nUse s .* v1 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vsep-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.vsep",
    "category": "method",
    "text": "vsep(v1, v2)\n\nReturn the sepative difference between two 3-dimensional vectors.\n\nArguments\n\nv1, v2: Two three-dimensional input vectors\n\nOutput\n\nReturns the angle between v1 and v2 in radians.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vsepg-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.vsepg",
    "category": "method",
    "text": "vsepg(v1, v2)\n\nReturn the sepative difference between two vectors.\n\nArguments\n\nv1, v2: Input vectors\n\nOutput\n\nReturns the angle between v1 and v2 in radians.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vsub",
    "page": "API",
    "title": "SPICE.vsub",
    "category": "function",
    "text": "vsub(v1, v2)\n\nwarning: Deprecated\nUse v1 .- v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vsubg",
    "page": "API",
    "title": "SPICE.vsubg",
    "category": "function",
    "text": "vsubg(v1, v2)\n\nwarning: Deprecated\nUse v1 .- v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vtmv",
    "page": "API",
    "title": "SPICE.vtmv",
    "category": "function",
    "text": "vtmv(v1, matrix, v2)\n\nwarning: Deprecated\nUse v1\' * matrix * v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vtmvg",
    "page": "API",
    "title": "SPICE.vtmvg",
    "category": "function",
    "text": "vtmvg(v1, matrix, v2)\n\nwarning: Deprecated\nUse v1\' * matrix * v2 instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vupack",
    "page": "API",
    "title": "SPICE.vupack",
    "category": "function",
    "text": "vupack(v)\n\nwarning: Deprecated\nUse x, y, z = v instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vzero",
    "page": "API",
    "title": "SPICE.vzero",
    "category": "function",
    "text": "vzero(v1)\n\nwarning: Deprecated\nUse iszero(v1) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.vzerog",
    "page": "API",
    "title": "SPICE.vzerog",
    "category": "function",
    "text": "vzerog(v1, v2)\n\nwarning: Deprecated\nUse iszero(v1) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wncard-Tuple{Any}",
    "page": "API",
    "title": "SPICE.wncard",
    "category": "method",
    "text": "wncard(window)\n\nReturn the cardinality (number of intervals) of a double precision window.\n\nArguments\n\nwindow: Input window\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wncomd-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.wncomd",
    "category": "method",
    "text": "wncomd(window, left, right)\n\nDetermine the complement of a double precision window with respect to a specified interval.\n\nArguments\n\nwindow: Input window. \nleft:  Left endpoint of the complement interval\nright:  Right endpoint of the complement interval\n\nOutput\n\nReturns the complement of window with respect to [left,right].\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wncond!-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.wncond!",
    "category": "method",
    "text": "wncond!(window, left, right)\n\nContract each of the intervals of a double precision window.\n\nArguments\n\nwindow: Window to be contracted\nleft:  Amount added to each left endpoint\nright: Amount subtracted from each right endpoint\n\nOutput\n\nReturns the contracted window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wndifd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wndifd",
    "category": "method",
    "text": "wndifd(a, b)\n\nPlace the difference of two double precision windows into a third window.\n\nArguments\n\na: Input window\nb: Input window\n\nOutput\n\nReturns a window containing the difference of a and b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnelmd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wnelmd",
    "category": "method",
    "text": "wnelmd(window, point)\n\nDetermine whether a point is an element of a double precision window.\n\nArguments\n\nwindow: Input window\npoint: Input point\n\nOutput\n\nReturns true if point is an element of window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnexpd!-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.wnexpd!",
    "category": "method",
    "text": "wnexpd(window, left, right)\n\nExpand each of the intervals of a double precision window.\n\nArguments\n\nleft: Amount subtracted from each left endpoint\nright: Amount added to each right endpoint\n\nOutput\n\nReturns the expanded window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnextd!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wnextd!",
    "category": "method",
    "text": "wnextd!(window, side)\n\nExtract the left or right endpoints from a double precision window.\n\nArguments\n\nwindow: Window to be extracted\nside: Extract left (:L) or right (:R) endpoints\n\nOutput\n\nReturns the extracted window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnfetd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wnfetd",
    "category": "method",
    "text": "wnfetd(window, n)\n\nFetch a particular interval from a double precision window.\n\nArguments\n\nwindow: Input window\nn: Index of interval to be fetched\n\nOutput\n\nReturns a tuple consisting of the left and right endpoints of the n-th interval in the input window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnfild!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wnfild!",
    "category": "method",
    "text": "wnfild!(window, small)\n\nFill small gaps between adjacent intervals of a double precision window.\n\nArguments\n\nwindow: Window to be filled\nsmall: Limiting measure of small gaps\n\nOutput\n\nReturns the updated window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnfltd!-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wnfltd!",
    "category": "method",
    "text": "wnfild!(window, small)\n\nFilter (remove) small intervals from a double precision window.\n\nArguments\n\nwindow: Window to be filtered\nsmall: Limiting measure of small intervals\n\nOutput\n\nReturns the updated window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnincd-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.wnincd",
    "category": "method",
    "text": "wnincd(window, left, right)\n\nDetermine whether an interval is included in a double precision window.\n\nArguments\n\nwindow: Input window\nleft: Left endpoint of the input interval\nright: Right endpoint of the input interval\n\nOutput\n\nReturns true when (left, right) is contained in window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wninsd!-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.wninsd!",
    "category": "method",
    "text": "wninsd!(window, left, right)\n\nInsert an interval into a double precision window.\n\nArguments\n\nwindow: Input window\nleft: Left endpoint of the new interval\nright: Right endpoint of the new interval\n\nOutput\n\nReturns the updated windows.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnintd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wnintd",
    "category": "method",
    "text": "wnintd(a, b)\n\nPlace the intersection of two double precision windows into a third window.\n\nArguments\n\na: Input window\nb: Input window\n\nOutput\n\nReturns a window containing the intersection of a and b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnreld-Tuple{Any,Any,Any}",
    "page": "API",
    "title": "SPICE.wnreld",
    "category": "method",
    "text": "wnreld(a, op, b)\n\nCompare two double precision windows.\n\nnote: Note\nConsider using overloaded operators instead, i.e. a == b, a ⊆ b, and a ⊊ b.\n\nArguments\n\na: First window\nop: Comparison operator\nb: Second window\n\nOutput\n\nReturns the result of comparison a (op) b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnsumd-Tuple{Any}",
    "page": "API",
    "title": "SPICE.wnsumd",
    "category": "method",
    "text": "wnsumd(window)\n\nSummarize the contents of a double precision window.\n\nArguments\n\nwindow: Window to be summarized\n\nOutput\n\nReturns a tuple consisting of:\n\nmeas: Total measure of intervals in window\navg: Average measure\nstddev: Standard deviation\nshortest: Location of shortest interval\nlongest: Location of longest interval \n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnunid-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.wnunid",
    "category": "method",
    "text": "wnunid(a, b)\n\nPlace the union of two double precision windows into a third window.\n\nArguments\n\na: Input window\nb: Input window\n\nOutput\n\nReturns a window containing the union of a and b.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.wnvald!-Tuple{Any}",
    "page": "API",
    "title": "SPICE.wnvald!",
    "category": "method",
    "text": "wnvald!(window)\n\nForm a valid double precision window from the contents of a window array.\n\nArguments\n\nwindow: A (possibly uninitialized) SpiceDoubleCell containing endpoints of   (possibly unordered and non-disjoint) intervals. \n\nOutput\n\nReturns the validated window.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.xf2eul-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.xf2eul",
    "category": "method",
    "text": "xf2eul(xform, axisa, axisb, axisc)\n\nConvert a state transformation matrix to Euler angles and their derivatives with respect to a specified set of axes.\n\nArguments\n\nxform: A state transformation matrix\naxisa: Axis A of the Euler angle factorization\naxisb: Axis B of the Euler angle factorization\naxisc: Axis C of the Euler angle factorization\n\nOutput\n\nReturns a tuple of an array of Euler angles and their derivatives and a boolean that indicates whether these are a unique representation.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.xf2rav-Tuple{Any}",
    "page": "API",
    "title": "SPICE.xf2rav",
    "category": "method",
    "text": "xf2rav(xform)\n\nDetermines the rotation matrix and angular velocity of the rotation from a state transformation matrix.\n\nArguments\n\nxform: State transformation matrix\n\nOutput\n\nReturns a tuple of the rotation matrix and the angular velocity vector associated with xform.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.xfmsta-NTuple{4,Any}",
    "page": "API",
    "title": "SPICE.xfmsta",
    "category": "method",
    "text": "xfmsta(input_state, input_coord_sys, output_coord_sys, body)\n\nTransform a state between coordinate systems.\n\nArguments\n\ninput_state: Input state\ninput_coord_sys: Current (input) coordinate system\n`outputcoordsys: Desired (output) coordinate system\nbody: Name or NAIF ID of body with which coordinates are associated (if applicable)\n\nOutput\n\nReturns the converted output state.\n\nReferences\n\nNAIF Documentation\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.xpose",
    "page": "API",
    "title": "SPICE.xpose",
    "category": "function",
    "text": "xpose(matrix)\n\nwarning: Deprecated\nUse transpose(matrix) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.xpose6",
    "page": "API",
    "title": "SPICE.xpose6",
    "category": "function",
    "text": "xpose6(matrix)\n\nwarning: Deprecated\nUse transpose(matrix) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#SPICE.xposeg",
    "page": "API",
    "title": "SPICE.xposeg",
    "category": "function",
    "text": "xposeg(matrix)\n\nwarning: Deprecated\nUse transpose(matrix) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#API-1",
    "page": "API",
    "title": "API",
    "category": "section",
    "text": "DocTestSetup = quote\n    using SPICE\nendModules = [SPICE]\nPrivate = false"
},

]}
