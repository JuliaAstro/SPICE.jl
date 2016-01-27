using BinDeps
using Glob

function patchbuild(file, libext)
    name, ext = splitext(file)
    newfile = name*"-patched"*ext
    script = open(readlines, file, "r")
    lines = []
    indices = []
    for (idx, line) in enumerate(script)
        if ismatch(r"^\s*set TKLINKOPTIONS", line)
            re = r"\".*\""
            m = match(re, line)
            push!(lines, line[1:m.offset-1] * m.match[1:end-1] * " -shared\"\n")
            push!(indices, idx)
        elseif ismatch(r"^\s*ar", line)
            push!(lines, "\$TKCOMPILER -o \$LIBRARY.$libext *.o \$TKLINKOPTIONS\n")
            push!(indices, idx)
        elseif ismatch(r"^\s*ranlib", line)
            push!(lines, "")
            push!(indices, idx)
        end
    end
    for (i, l) in zip(indices, lines)
        script[i] = l
    end
    open(newfile, "w") do f
        write(f, script)
    end
    return nothing
end

@BinDeps.setup

cspice = library_dependency("cspice")

@osx_only begin
    provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/MacIntel_OSX_AppleC_64bit/packages/cspice.tar.Z"), cspice, os=:Darwin)
end

@linux_only begin
    provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Linux_GCC_64bit/packages/cspice.tar.Z"), cspice, os=:Linux)
end

@windows_only begin
    provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Windows_VisualC_64bit/packages/cspice.zip"), cspice, os=:Windows)
end

prefix = joinpath(BinDeps.depsdir(cspice), "usr")
srcdir = joinpath(BinDeps.depsdir(cspice), "src", "cspice", "src", "cspice")
libdir = joinpath(BinDeps.depsdir(cspice), "src", "cspice", "lib")
compiler = @linux ? "gcc" : @osx ? "clang" : "nope"
libext = @linux ? "so" : @osx ? "dylib" : "dll"
libname = "cspice.$libext"
patch() = patchbuild(joinpath(srcdir, "mkprodct.csh"), libext)

provides(SimpleBuild, (@build_steps begin
    GetSources(cspice)
    CreateDirectory(joinpath(prefix, "lib"))
    @build_steps begin
        ChangeDirectory(srcdir)
        FileRule(joinpath(srcdir, "mkprodct-patched.csh"), @build_steps begin
            patch
        end)
        FileRule(joinpath(prefix, "lib", libname), @build_steps begin
            `csh mkprodct-patched.csh`
            `cp $(joinpath(libdir, libname)) $(joinpath(prefix, "lib"))`
        end)
    end
end), cspice, os=:Unix)

@BinDeps.install
