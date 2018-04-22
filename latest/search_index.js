var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "api.html#",
    "page": "API",
    "title": "API",
    "category": "page",
    "text": ""
},

{
    "location": "api.html#SPICE.SpiceCharCell-Tuple{Int64,Int64}",
    "page": "API",
    "title": "SPICE.SpiceCharCell",
    "category": "method",
    "text": "SpiceCharCell(size, length)\n\nCreate a SpiceCharCell that can contain up to size strings with length characters.\n\n\n\n"
},

{
    "location": "api.html#SPICE.SpiceDoubleCell-Tuple{Any}",
    "page": "API",
    "title": "SPICE.SpiceDoubleCell",
    "category": "method",
    "text": "SpiceDoubleCell(size)\n\nCreate a SpiceDoubleCell that can contain up to size elements.\n\n\n\n"
},

{
    "location": "api.html#SPICE.SpiceIntCell-Tuple{Any}",
    "page": "API",
    "title": "SPICE.SpiceIntCell",
    "category": "method",
    "text": "SpiceIntCell(size)\n\nCreate a SpiceIntCell that can contain up to size elements.\n\n\n\n"
},

{
    "location": "api.html#Base.append!-Tuple{SPICE.SpiceCell,Any}",
    "page": "API",
    "title": "Base.append!",
    "category": "method",
    "text": "append!(cell, collection)\n\nAppend all items from collection to the char/double/integer SpiceCell cell.\n\n\n\n"
},

{
    "location": "api.html#Base.length-Tuple{SPICE.SpiceCell}",
    "page": "API",
    "title": "Base.length",
    "category": "method",
    "text": "length(cell)\n\n\n\n"
},

{
    "location": "api.html#Base.push!-Tuple{SPICE.SpiceCell,Vararg{Any,N} where N}",
    "page": "API",
    "title": "Base.push!",
    "category": "method",
    "text": "push!(cell, items...)\n\nInsert one or more items at the end of the char/double/integer SpiceCell cell.\n\n\n\n"
},

{
    "location": "api.html#SPICE.appnd-Tuple{Any,SPICE.SpiceCell{UInt8,N} where N}",
    "page": "API",
    "title": "SPICE.appnd",
    "category": "method",
    "text": "appnd(item, cell)\n\nAppend an item to the char/double/integer SpiceCell cell.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndc_c.html https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndd_c.html https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndi_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.axisar-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.axisar",
    "category": "method",
    "text": "axisar(axis, angle)\n\nConstruct a rotation matrix that rotates vectors by a specified angle about a specified axis.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/axisar_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.b1900-Tuple{}",
    "page": "API",
    "title": "SPICE.b1900",
    "category": "method",
    "text": "b1900()\n\nReturns the Julian Date corresponding to Besselian date 1900.0.\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.b1950-Tuple{}",
    "page": "API",
    "title": "SPICE.b1950",
    "category": "method",
    "text": "b1950()\n\nReturns the Julian Date corresponding to Besselian date 1950.0.\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.badkpv-NTuple{6,Any}",
    "page": "API",
    "title": "SPICE.badkpv",
    "category": "method",
    "text": "badkpv(caller, name, comp, size, divby, typ)\n\nDetermine if a kernel pool variable is present and if so that it has the correct size and type.\n\nArguments\n\ncaller: Name of the routine calling this routine\nname: Name of a kernel pool variable\ncomp: Comparison operator\nsize: Expected size of the kernel pool variable\ndivby: A divisor of the size of the kernel pool variable\ntype: Expected type of the kernel pool variable\n\nOutput\n\nThe function returns false if the kernel pool variable is OK otherwise and exception is thrown.\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bltfrm-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bltfrm",
    "category": "method",
    "text": "bltfrm(frmcls)\n\nReturn a SPICE set containing the frame IDs of all built-in frames of a specified class.\n\nArguments\n\nfrmcls: Frame class\n\nOutput\n\nidset: Set of ID codes of frames of the specified class\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bodc2n-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bodc2n",
    "category": "method",
    "text": "bodc2n(code)\n\nTranslate the SPICE integer code of a body into a common name for that body.\n\nArguments\n\ncode: Integer ID code to be translated into a name\n\nOutput\n\nname: A common name for the body identified by code\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bodc2s-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bodc2s",
    "category": "method",
    "text": "bodc2s(code)\n\nTranslate a body ID code to either the corresponding name or if no name to ID code mapping exists, the string representation of the body ID value.\n\nArguments\n\ncode: Integer ID code to translate to a string\n\nOutput\n\nname: String corresponding to code\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.boddef-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.boddef",
    "category": "method",
    "text": "boddef(name, code)\n\nDefine a body name/ID code pair for later translation via bodn2c or bodc2n.\n\nArguments\n\nname: Common name of some body\ncode: Integer code for that body\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bodfnd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.bodfnd",
    "category": "method",
    "text": "bodfnd(body, item)\n\nDetermine whether values exist for some item for any body in the kernel pool.\n\nArguments\n\nbody: ID code of body\nitem: Item to find (\"RADII\", \"NUT_AMP_RA\", etc.)\n\nOutput\n\nfound: true if the item is in the kernel pool and false if it is not.\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bodn2c-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bodn2c",
    "category": "method",
    "text": "bodn2c(name)\n\nTranslate the name of a body or object to the corresponding SPICE integer ID code.\n\nArguments\n\nname: Body name to be translated into a SPICE ID code\n\nOutput\n\ncode: SPICE integer ID code for the named body\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bods2c-Tuple{Any}",
    "page": "API",
    "title": "SPICE.bods2c",
    "category": "method",
    "text": "bods2c(name)\n\nTranslate a string containing a body name or ID code to an integer code.\n\nArguments\n\nname: String to be translated to an ID code\n\nOutput\n\ncode: Integer ID code corresponding to name\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bodvcd-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.bodvcd",
    "category": "method",
    "text": "bodvcd(bodyid, item)\n\nFetch from the kernel pool the double precision values of an item associated with a body, where the body is specified by an integer ID code.\n\nArguments\n\nbodyid: Body ID code\nitem: Item for which values are desired. (\"RADII\", \"NUT_PREC_ANGLES\", etc.)\n\nOutput\n\nvalues: Values\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.bodvrd",
    "page": "API",
    "title": "SPICE.bodvrd",
    "category": "function",
    "text": "bodvrd(bodynm, item)\n\nFetch from the kernel pool the double precision values of an item associated with a body.\n\nArguments\n\nbodynm: Body name\nitem: Item for which values are desired. (\"RADII\", \"NUT_PREC_ANGLES\", etc.)\nmaxn: Maximum number of values that may be returned. \n\nOutput\n\nvalues: Values\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.card-Tuple{SPICE.SpiceCell}",
    "page": "API",
    "title": "SPICE.card",
    "category": "method",
    "text": "card(cell)\n\nReturns the cardinality (number of elements) of a SpiceCell cell.\n\n\n\n"
},

{
    "location": "api.html#SPICE.ccifrm-Tuple{Any,Any}",
    "page": "API",
    "title": "SPICE.ccifrm",
    "category": "method",
    "text": "ccifrm(frclss, clssid)\n\nReturn the frame name, frame ID, and center associated with a given frame class and class ID.\n\nArguments\n\nfrclss: Class of frame\nclssid: Class ID of frame\n\nOutput\n\nReturn the tuple (frcode, frname, center).\n\nfrcode: ID code of the frame\nfrname: Name of the frame\ncenter: ID code of the center of the frame\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.cidfrm-Tuple{Any}",
    "page": "API",
    "title": "SPICE.cidfrm",
    "category": "method",
    "text": "cidfrm(cent)\n\nRetrieve frame ID code and name to associate with a frame center.\n\nArguments\n\ncent: ID code for an object for which there is a preferred reference frame\n\nOutput\n\nReturns the tuple (frcode, frname)\n\nfrcode: The ID code of the frame associated with cent\nfrname: The name of the frame with ID frcode\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.ckcls-Tuple{Any}",
    "page": "API",
    "title": "SPICE.ckcls",
    "category": "method",
    "text": "ckcls(handle)\n\nClose an open CK file.\n\nArguments\n\nhandle: Handle of the CK file to be closed\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.ckgp-Tuple{}",
    "page": "API",
    "title": "SPICE.ckgp",
    "category": "method",
    "text": "\n\n"
},

{
    "location": "api.html#SPICE.ckgpav-Tuple{}",
    "page": "API",
    "title": "SPICE.ckgpav",
    "category": "method",
    "text": "\n\n"
},

{
    "location": "api.html#SPICE.ckopn",
    "page": "API",
    "title": "SPICE.ckopn",
    "category": "function",
    "text": "ckopn(fname, ifname=\"CK_file\", ncomch=0)\n\nOpen a new CK file, returning the handle of the opened file.\n\nArguments\n\nfname: The name of the CK file to be opened\nifname=\"CK_file\": The internal filename for the CK, default is \"CK_file\"\nncomch=0: The number of characters to reserve for comments, default is zero\n\nOutput\n\nhandle: The handle of the opened CK file\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.ckw01",
    "page": "API",
    "title": "SPICE.ckw01",
    "category": "function",
    "text": "\n\n"
},

{
    "location": "api.html#SPICE.clight-Tuple{}",
    "page": "API",
    "title": "SPICE.clight",
    "category": "method",
    "text": "Returns the speed of light in vacuo (km/sec).\n\n\n\n"
},

{
    "location": "api.html#SPICE.hx2dp-Tuple{Any}",
    "page": "API",
    "title": "SPICE.hx2dp",
    "category": "method",
    "text": "hx2dp(str)\n\nConvert a string representing a double precision number in a base 16 \"scientific notation\" into its equivalent double precision number.\n\nArguments\n\nstr: Hex form string to convert to double precision\n\nOutput\n\ndp: Double precision value to be returned\n\nReferences\n\nNAIF Documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.j1900-Tuple{}",
    "page": "API",
    "title": "SPICE.j1900",
    "category": "method",
    "text": "j1900()\n\nReturns the Julian Date of 1899 DEC 31 12:00:00 (1900 JAN 0.5).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j1900_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.j1950-Tuple{}",
    "page": "API",
    "title": "SPICE.j1950",
    "category": "method",
    "text": "j1950()\n\nReturns the Julian Date of 1950 JAN 01 00:00:00 (1950 JAN 1.0).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j1950_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.j2000-Tuple{}",
    "page": "API",
    "title": "SPICE.j2000",
    "category": "method",
    "text": "j2000()\n\nReturns the Julian Date of 2000 JAN 01 12:00:00 (2000 JAN 1.5).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j2000_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.j2100-Tuple{}",
    "page": "API",
    "title": "SPICE.j2100",
    "category": "method",
    "text": "j2100()\n\nReturns the Julian Date of 2100 JAN 01 12:00:00 (2100 JAN 1.5).\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/j2100_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.jyear-Tuple{}",
    "page": "API",
    "title": "SPICE.jyear",
    "category": "method",
    "text": "jyear()\n\nReturns the number of seconds per Julian year.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/jyear_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.kclear-Tuple{}",
    "page": "API",
    "title": "SPICE.kclear",
    "category": "method",
    "text": "kclear()\n\nClear the KEEPER subsystem: unload all kernels, clear the kernel pool, and re-initialize the subsystem. Existing watches on kernel variables are retained.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/kclear_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.ktotal-Tuple{Any}",
    "page": "API",
    "title": "SPICE.ktotal",
    "category": "method",
    "text": "ktotal(kind)\n\nReturn the current number of kernels that have been loaded  via the KEEPER interface that are of a specified type. \n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/ktotal_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.pxform-Tuple{String,String,Float64}",
    "page": "API",
    "title": "SPICE.pxform",
    "category": "method",
    "text": "Return the matrix that transforms position vectors from one specified frame to another at a specified epoch.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/pxform_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.spd-Tuple{}",
    "page": "API",
    "title": "SPICE.spd",
    "category": "method",
    "text": "Returns the number of seconds in a day.\n\n\n\n"
},

{
    "location": "api.html#SPICE.spkcpo-NTuple{7,Any}",
    "page": "API",
    "title": "SPICE.spkcpo",
    "category": "method",
    "text": "Returns the state of a target body relative to a constant-position observer location.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/spkcpo_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.spkezr-Tuple{AbstractString,Float64,AbstractString,AbstractString}",
    "page": "API",
    "title": "SPICE.spkezr",
    "category": "method",
    "text": "Returns the state of a target body relative to an observing body.\n\nNAIF documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.spkpos-Tuple{AbstractString,Float64,AbstractString,AbstractString}",
    "page": "API",
    "title": "SPICE.spkpos",
    "category": "method",
    "text": "Returns the state of a target body relative to an observing body.\n\nNAIF documentation\n\n\n\n"
},

{
    "location": "api.html#SPICE.sxform-Tuple{String,String,Float64}",
    "page": "API",
    "title": "SPICE.sxform",
    "category": "method",
    "text": "Return the state transformation matrix from one frame to another at a specified epoch.\n\nhttps://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/sxform_c.html\n\n\n\n"
},

{
    "location": "api.html#SPICE.tyear-Tuple{}",
    "page": "API",
    "title": "SPICE.tyear",
    "category": "method",
    "text": "Returns the number of seconds per tropical year.\n\n\n\n"
},

{
    "location": "api.html#API-1",
    "page": "API",
    "title": "API",
    "category": "section",
    "text": "DocTestSetup = quote\n    using SPICE\nendModules = [SPICE]\nPrivate = false"
},

]}
