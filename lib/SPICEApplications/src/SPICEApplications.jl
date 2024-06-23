"""
Call all SPICE Utilities from within Julia!

!!! warning
    This package is not affiliated with or endorsed by NASA, JPL, Caltech, or any
    other organization! This is an independently written package by an
    astrodynamics hobbyist.

# Extended help

## README

$(README)

## License
$(LICENSE)

## Exports
$(EXPORTS)

## Imports
$(IMPORTS)
"""
module SPICEApplications

export
    brief,
    chronos,
    ckbrief,
    commnt,
    dskbrief,
    dskexp,
    frmdiff,
    inspekt,
    mkdsk,
    mkspk,
    msopck,
    spacit,
    spkdiff,
    spkmerge,
    tobin,
    toxfr

import CSPICE_jll

using DocStringExtensions
include("docstrings.jl")

"""
BRIEF is a command-line utility program that displays a contents and time coverage summary for one or more binary SPK or binary PCK files.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `tabular` | `-t` | Display summary in a tabular format |
| `single` | `-a` | Treat all files as a single file | 
| `centers` | `-c` | Displays centers of motion/relative-to frames | 
| `utc` | `-utc` | Display times in UTC calendar date format (needs LSK) | 
| `utcdoy` | `-utcdoy` | Display times in UTC day-of-year format (needs LSK) |
| `etsec` | `-etsec` | Display times as ET seconds past J2000 | 
| `sec` | `-sec` | Display times "rounded inward" to second | 
| `min` | `-min` | Display times "rounded inward" to minute | 
| `hour` | `-hour` | Display times "rounded inward" to hour | 
| `day` | `-day` | Display times "rounded inward" to day | 
| `bytime` | `-s` | Display summary sorted by start time for each body/frame | 
| `bycoverage` | `-g` | Display summary grouped by coverage | 
| `byid` | `-n` | Display bodies/frames using numeric id-codes | 
| `byname` | `-o` | Display summary ordered by body/frame name | 
| `body` | `-sb[bod]` | Display summary for body [bod] |
| `center` | `-sc[cen]` | Display summary for center of motion/relative-to frame [cen] | 
| `at` | `-at [time]` | Display summary if coverage contains epoch [time] |
| `from` | `-from [beg]` | Display summary if coverage contains interval [beg]:[end] |
| `to` | `-to [end]` | Display summary if coverage contains interval [beg]:[end] |
| `listfile` | `-f [list]` | Summarize kernels listed in the [list] file | 
| `help` | `-h` | Display help | 
| `version` | `-v` | Display version| 
"""
function brief(
    file::AbstractString...;
    tabular=false, single=false, centers=false, utc=false, utcdoy=false, etsec=false,
    sec=false, min=false, hour=false, day=false, bytime=false, bycoverage=false,
    byid=false, byname=false, body=nothing, center=nothing, at=nothing, from=nothing,
    to=nothing, listfile=nothing, help=false, version=false, 
    stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
)
    args = String[]
    tabular && push!(args, "-t")
    single && push!(args, "-a")
    centers && push!(args, "-c")

    utc && push!(args, "-utc")
    utcdoy && push!(args, "-utcdoy")
    etsec && push!(args, "-etsec")
    sec && push!(args, "-sec")
    min && push!(args, "-min")
    hour && push!(args, "-hour")
    day && push!(args, "-day")

    bytime && push!(args, "-s")
    bycoverage && push!(args, "-g")
    byid && push!(args, "-n")
    byname && push!(args, "-o")

    !isnothing(body) && push!(args, "-sb$body")
    !isnothing(center) && push!(args, "-sc$center")
    !isnothing(at) && push!(args, "-at $at")
    !isnothing(from) && push!(args, "-from $from")
    !isnothing(to) && push!(args, "-to $to")
    !isnothing(listfile) && push!(args, "-f $listfile")

    help && push!(args, "-h")
    version && push!(args, "-v")

    args = join(args, " ")
    files = join(file, " ")
    cmd = `$(CSPICE_jll.brief()) $args $files`
    
    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
CHRONOS is a command-line program that converts between several time systems and time formats.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `from` | `-FROM <"from" time system>` | "from" time system |
| `fromtype` | `-FROMTYPE <"from" time system type>` | "from" time system type|
| `to` | `-TO <"to" time system>` | "to" time system |
| `totype` | `-TOTYPE <"to" time system type>` | "to" time system  type |
| `format` | `-FORMAT <output time format picture>` | output time format picture|
| `time` | `-TIME <input time>` | intput time|
| `sc` | `-SC <sc ID>` | sc ID|
| `center` | `-CENTER <cental body ID>` | cental body ID|
|`landingtime` | `-LANDINGTIME <UTC time of the landing>` | UTC time of the landing |
| `sol1index` | `-SOL1INDEX <index of the first SOL>` | index of the first SOL |
| `nolabel` | `-NOLABEL` | |
| `trace` | `-TRACE` | |
| `help` | `-HELP` | display help |
| `usage` | `-USAGE` | display usage |
| `template` | `-TEMPLATE` | display setup file template |
"""
function chronos(
    file::AbstractString...;
    from=nothing, fromtype=nothing, to=nothing, totype=nothing, format=nothing,
    time=nothing, sc=nothing, center=nothing, landingtime=nothing, sol1index=nothing,
    nolabel=false, trace=false, help=false, usage=false, template=nothing,
    stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
)
    args = String[]

    !isnothing(from) && push!(args, "-FROM $from")
    !isnothing(fromtype) && push!(args, "-FROMTYPE $fromtype")
    !isnothing(to) && push!(args, "-TO $to")
    !isnothing(totype) && push!(args, "-TOTYPE $totype")
    !isnothing(format) && push!(args, "-FORMAT $format")
    !isnothing(time) && push!(args, "-TIME $time")
    !isnothing(sc) && push!(args, "-sc $sc")
    !isnothing(center) && push!(args, "-CENTER $center")
    !isnothing(landingtime) && push!(args, "-LANDINGTIME $landingtime")
    !isnothing(sol1index) && push!(args, "-SOL1INDEX $sol1index")
    nolabel && push!(args, "-NOLABEL")
    trace && push!(args, "-TRACE")
    help && push!(args, "-HELP")
    usage && push!(args, "-USAGE")
    !isnothing(template) && push!(args, "-TEMPLATE $template")

    args = join(args, " ")
    files = join(file, " ")
    cmd = `$(CSPICE_jll.chronos()) $files $args`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
CKBRIEF is a command-line utility program that displays a contents and time coverage summary for one or more binary CK files.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `dump` | `-dump` | display interpolation intervals boundaries |
| `boundaries` | `-nm` | display segment boundaries |
| `relframes` | `-rel` | display relative-to frames |
| `idframes` | `-n` | display frames associated with structure IDs | 
| `tabular` | `-t` | display summary in a tabular format |
| `single` | `-a` | treat all files as a single file |
| `bycoverage` | `-g` | display summary grouped by coverage |
| `utc` | `-utc` | display times in UTC calendar date format |
| `utcdoy` | `-utcdoy` | display times in UTC day-of-year format |
| `sclk` | `-sclk` | display times as SCLK strings |
| `dpsclk` | `-dpsclk` | display times as SCLK ticks |
| `id` | `[ID]` | display summmary for structure with [ID] | 
| `summarize` | `-f` | summarize kernels listed in the `[list]` file |
| `help` | `-h` | display help |
| `version` | `-v` | display version |
"""
function ckbrief(
    file::AbstractString...;
    dump=false, boundaries=false, relframes=false, idframes=false, tabular=false,
    single=false, bycoverage=false, utc=false, utcdoy=false, sclk=false, dpsclk=false,
    id=nothing, summarize=nothing, help=false, version=false,
    stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
)
    args = String[]

    dump && push!(args, "-dump")
    boundaries && push!(args, "-nm")
    relframes && push!(args, "-rel")
    idframes && push!(args, "-n")
    tabular && push!(args, "-t")
    single && push!(args, "-a")
    bycoverage && push!(args, "-g")
    utc && push!(args, "-utc")
    utcdoy && push!(args, "-utcdoy")
    sclk && push!(args, "-sclk")
    dpsclk && push!(args , "-dpsclk")
    
    !isnothing(id) &&  push!(args, id)
    !isnothing(summarize) && push!(args, "-f $summarize")

    help && push!(args, "-h")
    version && push!(args, "-v")

    args = join(args, " ")
    files = join(file, " ")
    cmd = `$(CSPICE_jll.ckbrief()) $files $args`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end
    
    result = run(cmd; wait=wait)

    return result
end


"""
COMMNT is a command-line program that reads, adds, extracts, or deletes comments from SPICE binary kernel files.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `add` | `-a` | add comments to binary kernel |
| `extract` | `-e` | extract comments from a binary kernel |
| `read` | `-r` | read the comments in a binary kernel | 
| `delete` | `-d`| delete the comments from the binary kernel | 
| `help` | `-h` | display the help message |
"""
function commnt(
    kernelfile::Union{<:AbstractString,Nothing} = nothing, commentfile::Union{<:AbstractString,Nothing} = nothing;
    add=false, extract=false, read=false, delete=false, help=false,
    stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
) 
    args = String[]

    add && push!(args, "-a")
    extract && push!(args, "-e")
    read && push!(args, "-r")
    delete && push!(args, "-d")
    help && push!(args, "-h")

    kernel = isnothing(kernelfile) ? "" : kernelfile
    comment = isnothing(commentfile) ? "" : commentfile

    args = join(args, " ")
    cmd = `$(CSPICE_jll.commnt()) $args $kernel $comment`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
DSKBRIEF is a command-line utility program that displays a summary of the spatial coverage and additional attributes of one or more binary Digital Shape Kernel (DSK) files.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `single` | `-a` | treat all DSK files as a single file |
| `gaps` | `-gaps` | display coverage gaps (aplies only when `-a` is used) |
| `extended` | `-ext` | display extended summaries: these include data type, data class, and time bounds | 
| `timebounds` | `-tg` | require segment time bounds to match when grouping segments | 
| `full` | `-full` | display a detailed summary for each segment, including data-type-specific parameters |
| `sigdigs` | `-d <n>` | display `n` significant digits of floating point values | 
| `version` | `-v` | display the version of the program | 
| `help` | `-h` | display help text |
| `usage` | `-u` | display usage text |
"""
function dskbrief(
    file::AbstractString...;
    single=false, gaps=false, extended=false, timebounds=false, bysegment=false,
    full=false, sigdigs=nothing, version=false, help=false, usage=false,
    stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
) 
    args = String[]

    single && push!(args, "-a")
    gaps && push!(args, "-gaps")
    extended && push!(args, "-ext")
    timebounds && push!(args, "-tg")
    bysegment && push!(args, "-tg")
    full && push!(args, "-full")
    
    !isnothing(sigdigs) && push!(args, "-d $sigdigs")
    version && push!(args, "-v")
    help && push!(args, "-h")
    usage && push!(args, "-u")

    args = join(args, " ")
    files = join(file, " ")
    cmd = `$(CSPICE_jll.dskbrief()) $args $files`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
DSKEXP is a command-line program that exports data from DSK files to text files.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `dsk` | `-dsk <dsk>` | DSK kernel |
| `text` | `-text <output name>` | output name |
| `format` | `-format <MKDSK format code/name>` | MKSDK format code/name | 
| `precision` | `-prec <# of vertex mantissa digits (1:17)` | number of vertex mantissa digits |
"""
function dskexp(
    ; dsk=nothing, text=nothing, format=nothing, precision=nothing,
      stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
) 
    args = String[]

    !isnothing(dsk) && push!(args, "-dsk $dsk")
    !isnothing(text) && push!(args, "-text $text")
    !isnothing(format) && push!(args, "-format $format")
    !isnothing(precision) && push!(args, "-prec $precision")

    args = join(args, " ")
    cmd = `$(CSPICE_jll.dskexp()) $args`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
FRMDIFF is a program that samples orientation of a reference frame known to SPICE or computes differences between orientations of two reference frames known to SPICE, and either displays this orientation or these differences, or shows statistics about it or them.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `kernels` | `-k  <supporting kernel(s) name(s)>` | supporting kernel(s) name(s)> |
|  `from1` | `-f1 <first ``from'' frame, name or ID>` | first "from" frame, name or ID |
|  `to1` | `-t1 <first ``to'' frame, name or ID>` | first "to" frame, name or ID |
|  `frame1` | `-c1 <first frame for coverage look up, name or ID>` | first frame for coverage look up, name or ID |
|  `supporting_kernels1` | `-k1 <additional supporting kernel(s) for first file>` | additional supporting kernel(s) for first file |
|  `from2` | `-f2 <second ``from'' frame, name or ID>` | second "from" frame, name or ID |
|  `to2` | `-t2 <second ``to'' frame, name or ID>` | second "to" frame, name or ID |
|  `frame2` | `-c2 <second frame for coverage look up, name or ID>` | second frame for coverage look up, name or ID |
|  `supporting_kernels2` | `-k2 <additional supporting kernel(s) for second file>` | additional supporting kernel(s) for second file |
| `angular`  | `-a  <compare angular velocities: yes│no (default: no)>` | compare angular velocities |
|  `angularframe` | `-m  <frame for angular velocities: from│to (default: from)>` | frame for angular velocities |
|  `start` | `-b  <interval start time>` | interval start time |
|  `stop` | `-e  <interval stop time>` | interval stop time |
|  `numpoints` | `-n  <number of points: 1 to 1000000 (default: 1000)>` | number of points |
|  `timestep` | `-s  <time step in seconds>` | time step in seconds |
|  `timeformat` | `-f  <time format: et│sclk│sclkd│ticks│picture_for_TIMOUT (default: et)>` | time format |
|  `report` | `-t  <report: basic│stats│dumpaa│dumpm│dumpqs│dumpqo│dumpea│dumpc│dumpg>` | report |
|  `rotation` | `-o  <rotation axes order (default: z y x)>` | rotation axes order |
| `units`  | `-x  <units for output angles> (only for -t dumpaa and -t dumpea)` | units for output angles |
| `sigdigs`  | `-d  <number of significant digits: 6 to 17 (default: 14)>` | number of significant digits |
"""
function frmdiff(
    ; kernels=nothing, from1=nothing, to1=nothing, frame1=nothing, supporting_kernels1=nothing,
    from2=nothing, to2=nothing, frame2=nothing, supporting_kernels2=nothing, angular=false, 
    angularframe=nothing, start=nothing, stop=nothing, numpoints=nothing, timestep=nothing, 
    timeformat=nothing, report=nothing, rotation=nothing, units=nothing, sigdigs=nothing,
    stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
) 
    args = String[]

    additems!(collection, key::AbstractString) = push!(collection, key)
    additems!(collection, items::Union{<:Tuple, <:AbstractVector}) = append!(collection, items)

    if !isnothing(kernels)
        push!(args, "-k")
        additems!(args, kernels)
    end

    !isnothing(from1) && push!(args, "-f1 $from1")
    !isnothing(to1) && push!(args, "-t1 $to1")
    !isnothing(frame1) && push!(args, "-c1 $frame1")

    if !isnothing(supporting_kernels1)
        push!(args, "-k1")
        additems!(args, supporting_kernels1)
    end

    !isnothing(from2) && push!(args, "-f2 $from2")
    !isnothing(to2) && push!(args, "-t2 $to2")
    !isnothing(frame2) && push!(args, "-c2 $frame2")

    if !isnothing(supporting_kernels2)
        push!(args, "-k2")
        additems!(args, supporting_kernels2)
    end

    angular && push!(args, "-a " * (angular ? "yes" : "no"))

    !isnothing(angularframe) && push!(args, "-m $angularframe")
    !isnothing(start) && push!(args, "-b $start")
    !isnothing(stop) && push!(args, "-e $stop")
    !isnothing(numpoints) && push!(args, "-n $numpoints")
    !isnothing(timestep) && push!(args, "-s $timestep")
    !isnothing(timeformat) && push!(args, "-f $timeformat")
    !isnothing(report) && push!(args, "-t $report")
    !isnothing(rotation) && push!(args, "-o $rotation")
    !isnothing(units) && push!(args, "-x $units")
    !isnothing(sigdigs) && push!(args, "-d $sigdigs")

    args = join(args, " ")
    cmd = `$(CSPICE_jll.frmdiff()) $args`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    
    result = run(cmd; wait=wait)

    return result
end


"""
INSPEKT is an interactive program that examines the contents of an events component (ESQ) of an E-kernel.
"""
function inspekt(; stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,) 
    cmd = pipeline(`$(CSPICE_jll.inspekt())`; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    
    result = run(cmd; wait=wait)

    return result
end


"""
MKDSK is a utility program that creates a SPICE Digital Shape Kernel (DSK) file from a text file containing shape data for an extended object.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `setup` | `-setup <setup file name>` | setup file name |
| `input` | `-input <input shape data file name>` | input shape data file name | 
| `output` | `-output <output DSK file name>` | output DSK file name |
| `help` | `-h│-help` | display help |
| `template` | `-t│-template` | display template |
| `usage` | `-u│-usage` | display usage |
| `version` | `-v│-version` | display version | 
"""
function mkdsk(
    ; setup=nothing, input=nothing, output=nothing, help=false,
      template=nothing, usage=false, version=false,
      stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
) 
    args = String[]
    !isnothing(setup) && push!(args, "-setup $setup")
    !isnothing(input) && push!(args, "-input $input")
    !isnothing(output) && push!(args, "-output $output")

    help && push!(args, "-help")
    !isnothing(template) && push!(args, "-template $template")
    usage && push!(args, "-usage")
    version && push!(args, "-version")

    args = join(args, " ")
    files = join(file, " ")
    cmd = `$(CSPICE_jll.mkdsk()) $args $files`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
MKSPK is a program that creates an SPK file from a text file containing trajectory information.

# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `setup` | `-setup <setup file name>` | setup file name |
| `input` | `-input <input shape data file name>` | input shape data file name | 
| `output` | `-output <output DSK file name>` | output DSK file name |
| `add` | `-append` | append; output file must be new |
| `help` | `-h│-help` | display help |
| `template` | `-t│-template` | display template |
| `usage` | `-u│-usage` | display usage |
"""
function mkspk(
    ; setup=nothing, input=nothing, output=nothing, add=false, 
      usage=false, help=false, template=nothing,
      stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
)
    args = String[]
    !isnothing(setup) && push!(args, "-setup $setup")
    !isnothing(input) && push!(args, "-input $input")
    !isnothing(output) && push!(args, "-output $output")

    add && push!(args, "-append")
    usage && push!(args, "-usage")
    help && push!(args, "-help")
    !isnothing(template) && push!(args, "-template $template")

    args = join(args, " ")
    cmd = `$(CSPICE_jll.mkspk()) $args`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
MSOPCK is a command-line program that converts attitude data provided in a text file as UTC, SCLK, or ET-tagged quaternions, Euler angles, or matrices, optionally accompanied by angular velocities, into a type 1, 2, or 3 SPICE C-kernel.
"""
function msopck(
    ; setup=nothing, input=nothing, output=nothing,
      stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
) 
    args = String[]
    !isnothing(setup) && push!(args, "-setup $setup")
    !isnothing(input) && push!(args, "-input $input")
    !isnothing(output) && push!(args, "-output $output")

    args = join(args, " ")
    cmd = `$(CSPICE_jll.msopck()) $args`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end
    
    result = run(cmd; wait=wait)

    return result
end


"""
SPACIT is an interactive program that converts kernels in transfer format to binary format, converts binary kernels to transfer format, and summarizes the contents of binary kernels.
"""
function spacit(; stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true) 
    cmd = `$(CSPICE_jll.spacit())`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
SPKDIFF provides means for comparing the trajectories of two bodies or sampling the trajectory of a single body using data from SPICE kernels.
# Extended Help

!!! warning
    All descriptions below were manually parsed from the commandline program's help/usage output.

| Argument | Equivalent | Description | 
| :--- | :--- | :--- |
| `kernels` | `-k  <supporting kernel(s) name(s)>` | -k  <supporting kernel(s) name(s)> |
| `body1` | `-b1 <first body name or ID>` | -b1 <first body name or ID> |
| `center1` | `-c1 <first center name or ID>` | -c1 <first center name or ID> |
| `frame1` | `-r1 <first reference frame name>` | -r1 <first reference frame name> |
| `supporting_kernels1` | `-k1 <additional supporting kernel(s) for first SPK>` | -k1 <additional supporting kernel(s) for first SPK> |
| `body2` | `-b2 <second body name or ID>` | -b2 <second body name or ID> |
| `center2` | `-c2 <second center name or ID>` | -c2 <second center name or ID> |
| `frame2` | `-r2 <second reference frame name>` | -r2 <second reference frame name> |
| `supporting_kernels2` | `-k2 <additional supporting kernel(s) for second SPK>` | -k2 <additional supporting kernel(s) for second SPK> |
| `start` | `-b  <interval start time>` | -b  <interval start time> |
| `stop` | `-e  <interval stop time>` | -e  <interval stop time> |
| `timestep` | `-s  <time step in seconds>` | -s  <time step in seconds> |
| `numstates` | `-n  <number of states: 2 to 1000000 (default: 1000)>` | -n  <number of states: 2 to 1000000 (default: 1000)> |
| `timeformat` | `-f  <output time format (default: TDB seconds past J2000)>` | -f  <output time format (default: TDB seconds past J2000)> |
| `sigdigs1 | `-d  <number of significant digits: 6 to 17 (default: 14)>` | -d  <number of significant digits: 6 to 17 (default: 14)> |
| `report` | `-t  <report type: basic│stats│dump│dumpvf│dumpc│dumpg (def.: basic│dump)>` | -t  <report type: basic│stats│dump│dumpvf│dumpc│dumpg (def.: basic│dump)> |
"""
function spkdiff(
    ; kernels=nothing, body1=nothing, center1=nothing, frame1=nothing, supporting_kernels1=nothing,
      body2=nothing, center2=nothing, frame2=nothing, supporting_kernels2=nothing, 
      start=nothing, stop=nothing, timestep=nothing, numstates=nothing, timeformat=nothing, 
      sigdigs=nothing, report=nothing, stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true,
) 
    args = String[]

    additems!(collection, key::AbstractString) = push!(collection, key)
    additems!(collection, items::Union{<:Tuple, <:AbstractVector}) = append!(collection, items)

    if !isnothing(kernels)
        push!(args, "-k")
        additems!(args, kernels)
    end

    !isnothing(body1) && push!(args, "-b1 $body1")
    !isnothing(center1) && push!(args, "-c1 $center1")
    !isnothing(frame1) && push!(args, "-r1 $frame1")

    if !isnothing(supporting_kernels1)
        push!(args, "-k1")
        additems!(args, supporting_kernels1)
    end

    !isnothing(body2) && push!(args, "-b2 $body2")
    !isnothing(center2) && push!(args, "-c2 $center2")
    !isnothing(frame2) && push!(args, "-r2 $frame2")

    if !isnothing(supporting_kernels2)
        push!(args, "-k2")
        additems!(args, supporting_kernels2)
    end

    !isnothing(start) && push!(args, "-b $start")
    !isnothing(stop) && push!(args, "-e $stop")
    !isnothing(timestep) && push!(args, "-s $timestep")
    !isnothing(numstates) && push!(args, "-n $numstates")
    !isnothing(timeformat) && push!(args, "-f $timeformat")
    !isnothing(sigdigs) && push!(args, "-d $sigdigs")
    !isnothing(report) && push!(args, "-t $report")

    args = join(args, " ")
    cmd = `$(CSPICE_jll.spkdiff()) $args`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    
    result = run(cmd; wait=wait)

    return result
end


"""
SPKMERGE is a program that subsets or merges one or more SPK files into a single SPK file.
"""
function spkmerge(commandfile=nothing; stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true) 
    cmd = `$(CSPICE_jll.spkmerge()) $(isnothing(commandfile) ? "" : commandfile)`
        
    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end
    
    result = run(cmd; wait=wait)

    return result
end


"""
TOBIN is a command-line program that converts transfer format SPK, CK, PCK, DSK and EK files to binary format.
"""
function tobin(kernelfile=nothing; stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true) 
    cmd = `$(CSPICE_jll.tobin()) $(isnothing(kernelfile) ? "" : kernelfile)`
        
    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end

    result = run(cmd; wait=wait)

    return result
end


"""
TOXFR is a command-line program that converts binary format SPK, CK, PCK, DSK and EK files to transfer format.
"""
function toxfr(kernelfile=nothing; stdout=stdout, stderr=stderr, stdin=stdin, append=false, wait=true) 
    cmd = `$(CSPICE_jll.toxfr()) $(isnothing(kernelfile) ? "" : kernelfile)`

    if wait
        cmd = pipeline(cmd; stdout=stdout, stderr=stderr, stdin=stdin, append=append)
    end
    
    result = run(cmd; wait=wait)

    return result
end


end # module SPICEApplications
