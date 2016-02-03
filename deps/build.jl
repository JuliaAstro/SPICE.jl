using BinDeps

@BinDeps.setup

function isinstalled(program)
    which = @unix ? "which" : "where"
    return success(`$which $program`)
end

if !isinstalled("cmake")
    error("CMake must be installed and on the path.")
end

@windows_only begin
    MSYS2_ROOT = "C:\\msys64\\usr\\bin"
    if !contains(ENV["path"], "msys")
        if !isempty(get(ENV, "MSYS2_ROOT", ""))
            ENV["PATH"] = ENV["PATH"]*";$(ENV["MSYS2_ROOT"])"
        elseif isdir(MSYS2_ROOT)
            ENV["PATH"] = ENV["PATH"]*";$MSYS2_ROOT"
        else
            error("MSYS2 must be installed.")
        end
    end
    if !isinstalled("gcc") || !isinstalled("make")
        error("GCC and Make must be installed. Please run 'pacman -S gcc make' in an MSYS2 shell.")
    end
    push!(BinDeps.defaults, SimpleBuild)
end

cspice = library_dependency("libcspice")
@osx_only provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/MacIntel_OSX_AppleC_64bit/packages/cspice.tar.Z"), cspice, os=:Darwin)
@linux_only provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Linux_GCC_64bit/packages/cspice.tar.Z"), cspice, os=:Linux)
@windows_only provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Cygwin_GCC_64bit/packages/cspice.tar.gz"), cspice, os=:Windows)

prefix = joinpath(BinDeps.depsdir(cspice), "usr")
build = joinpath(BinDeps.depsdir(cspice), "build")

provides(SimpleBuild, (@build_steps begin
    GetSources(cspice)
    CreateDirectory(build)
    @build_steps begin
        ChangeDirectory(build)
        `cmake -G "MSYS Makefiles" -DCMAKE_INSTALL_PREFIX=$prefix ..`
        `cmake --build .`
        `cmake --build . --target install`
    end
end), cspice, os=:Windows)

provides(SimpleBuild, (@build_steps begin
    GetSources(cspice)
    CreateDirectory(build)
    @build_steps begin
        ChangeDirectory(build)
        `cmake -DCMAKE_INSTALL_PREFIX=$prefix ..`
        `cmake --build .`
        `cmake --build . --target install`
    end
end), cspice, os=:Unix)

@BinDeps.install Dict(:libcspice => :libcspice)
