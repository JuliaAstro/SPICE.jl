using BinDeps
using Glob

@BinDeps.setup

cspice = library_dependency("cspice")

provides(Sources, URI("http://naif.jpl.nasa.gov/pub/naif/toolkit//C/MacIntel_OSX_AppleC_64bit/packages/cspice.tar.Z"), cspice, os=:Darwin)

prefix = joinpath(BinDeps.depsdir(cspice), "usr")
srcdir = joinpath(BinDeps.depsdir(cspice), "src", "cspice")
provides(SimpleBuild, (@build_steps begin
    GetSources(cspice)
    CreateDirectory(joinpath(prefix, "lib"))
    @build_steps begin
        ChangeDirectory(srcdir)
        FileRule(joinpath(srcdir, "lib", "cspice.a"), @build_steps begin
            `csh makeall.csh`
        end)
        FileRule(joinpath(prefix, "lib", "cspice.dylib"), @build_steps begin
            `ar -x lib/cspice.a`
            `clang -shared -fPIC -lm -o cspice.dylib $(glob("*.o"))`
            `rm -f $(glob("*.o"))`
            `cp cspice.dylib $(joinpath(prefix, "lib"))`
        end)
    end
end), cspice, os=:Darwin)
@BinDeps.install
