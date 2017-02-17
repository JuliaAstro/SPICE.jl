using BinDeps

@BinDeps.setup

cspice = library_dependency("libcspice")
@osx_only provides(Sources, URI("https://naif.jpl.nasa.gov/pub/naif/toolkit/C/MacIntel_OSX_AppleC_$(WORD_SIZE)bit/packages/cspice.tar.Z"), cspice, os=:Darwin)
@linux_only provides(Sources, URI("https://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Linux_GCC_$(WORD_SIZE)bit/packages/cspice.tar.Z"), cspice, os=:Linux)

@windows_only provides(Binaries, URI("https://github.com/helgee/SPICE.jl/releases/download/N0065/libcspice$(WORD_SIZE).zip"), cspice, os=:Windows)

prefix = joinpath(BinDeps.depsdir(cspice), "usr")
build = joinpath(BinDeps.depsdir(cspice), "build")

@unix_only begin
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
end

@BinDeps.install Dict(:libcspice => :libcspice)
