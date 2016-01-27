using BinDeps

@BinDeps.setup

cspice = library_dependency("libcspice")

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
build = joinpath(BinDeps.depsdir(cspice), "build")

provides(SimpleBuild, (@build_steps begin
    GetSources(cspice)
    #= CreateDirectory(joinpath(prefix, "lib")) =#
    CreateDirectory(build)
    @build_steps begin
        ChangeDirectory(build)
        `cmake -DCMAKE_INSTALL_PREFIX=$prefix ..`
        `cmake --build .`
        `cmake --build . --target install`
    end
end), cspice)

@BinDeps.install
