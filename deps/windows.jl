using BinDeps

function patch_fio(file)
    lines = open(readlines, file, "r")
    idx = findfirst(map(l -> contains(l, "isatty"), lines))
    lines[idx] = "//"*lines[idx]
    open(file, "w") do f
        write(f, lines)
    end
end

path = abspath(joinpath(splitdir(@__FILE__)[1], "windows"))
cd(path)
mkpath("usr\\lib")
for word_size in (32, 64)
    url = "http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Windows_VisualC_$(word_size)bit/packages/cspice.zip"
    archive = "cspice$(word_size).zip"
    src = "cspice$(word_size)"
    build = "build$(word_size)"
    if !ispath(archive)
        run(download_cmd(url, archive))
    end
    if !ispath(src)
        mkdir(joinpath(path, src))
        run(unpack_cmd(archive, src, ".zip", ""))
    end
    patch_fio("$src/cspice/src/cspice/fio.h")
    if !ispath(build)
        mkdir(build)
    end
    cd(build)
    if !ispath(joinpath(build, "CMakeCache.txt"))
        if word_size == 32
            run(`cmake -G "Visual Studio 14 2015" -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE -DBUILD_SHARED_LIBS=TRUE -DBITNESS:STRING=$word_size ..`)
        else
            run(`cmake -G "Visual Studio 14 2015 Win$word_size" -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE -DBUILD_SHARED_LIBS=TRUE -DBITNESS:STRING=$word_size ..`)
        end
    end
    run(`cmake --build . --config Release`)
    cd(path)
    cp("$build\\Release\\cspice.dll", "usr\\lib\\libcspice.dll", remove_destination=true)
    run(`7z a libcspice$(word_size).zip usr\\lib\\libcspice.dll`)
end
