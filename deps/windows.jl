using BinDeps

word_size = readall(`uname -m`) == "i686\n" ? 32 : 64
# word_size = ARGS[1]
println(word_size)
# MSYS2_ROOT = "C:\\msys64\\usr\\bin"
# if !contains(ENV["path"], "msys")
#     if !isempty(get(ENV, "MSYS2_ROOT", ""))
#         ENV["PATH"] = ENV["PATH"]*";$(ENV["MSYS2_ROOT"])"
#     elseif isdir(MSYS2_ROOT)
#         ENV["PATH"] = "$MSYS2_ROOT;"*ENV["PATH"]
#     else
#         error("MSYS2 must be installed.")
#     end
# end

path = abspath(joinpath(splitdir(@__FILE__)[1], "windows"))
cd("$path")
# for word_size in (32, 64)
    # ENV["MSYSTEM"] = "MINGW$word_size"
    # c_compiler = word_size == 32 ? "i686-w64-mingw32-gcc" : "x86_64-w64-mingw32-gcc"
    # cxx_compiler = word_size == 32 ? "i686-w64-mingw32-g++" : "x86_64-w64-mingw32-g++"
    usr = word_size == 32 ? "i686" : "x64"
    url = "http://naif.jpl.nasa.gov/pub/naif/toolkit/C/PC_Cygwin_GCC_$(word_size)bit/packages/cspice.tar.gz"
    archive = "cspice$(word_size).tar.gz"
    src = "cspice$(word_size)"
    build = "build$(word_size)"
    if !ispath(archive)
        run(download_cmd(url, archive))
    end
    if !ispath(src)
        mkdir(joinpath(path, src))
        run(unpack_cmd(archive, src, ".gz", ".tar"))
    end
    if !ispath(build)
        mkdir(build)
    end
    if !ispath(usr)
        mkdir(usr)
    end
    cd(build)
    #= run(`cmake -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_INSTALL_PREFIX=$path/$usr -DCMAKE_C_COMPILER=$c_compiler -DCMAKE_CXX_COMPILER=$cxx_compiler ..`) =#
    if !ispath(joinpath(build, "CMakeCache.txt"))
        run(`cmake -G "MSYS Makefiles" .. -DCMAKE_INSTALL_PREFIX=$path/$usr -DBITNESS:STRING=$word_size`)
    end
    run(`make`)
    run(`make install`)
    cd(path)
    cp(joinpath(usr, lib, "libcspice.dll"), "libcspice$(word_size).dll")
# end
