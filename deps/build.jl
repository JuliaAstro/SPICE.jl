using BinDeps

@BinDeps.setup

cspice = library_dependency("libcspice")
provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/MacIntel_OSX_AppleC_64bit/packages/cspice.tar.Z"), cspice, os=:Darwin)
provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Linux_GCC_$(Sys.WORD_SIZE)bit/packages/cspice.tar.Z"), cspice, os=:Linux)

provides(Binaries, URI("https://github.com/helgee/SPICE.jl/releases/download/N0065/libcspice$(Sys.WORD_SIZE).zip"), cspice, os=:Windows)

prefix = joinpath(BinDeps.depsdir(cspice), "usr")
build = joinpath(BinDeps.depsdir(cspice), "build")

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
