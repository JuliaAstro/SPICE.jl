using BinDeps

@BinDeps.setup

function isinstalled(program)
    return success(`which $program`)
end

if !isinstalled("cmake")
    error("CMake must be installed and on the path.")
end

cspice = library_dependency("libcspice")
@osx_only provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/MacIntel_OSX_AppleC_$(WORD_SIZE)bit/packages/cspice.tar.Z"), cspice, os=:Darwin)
@linux_only provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Linux_GCC_$(WORD_SIZE)bit/packages/cspice.tar.Z"), cspice, os=:Linux)

@windows_only provides(Binaries, URI("https://bintray.com/artifact/download/helgee/generic/libcspice$(WORD_SIZE).dll"), cspice, os=:Windows)

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
