cmake_minimum_required(VERSION 2.6)

project(cspice C)
enable_language(C)

include(CMakeSrc.txt)

set(CMAKE_C_FLAGS "-m64 -fPIC -DNON_UNIX_STDIO -ansi")

add_library(cspice SHARED ${SRCS})
target_link_libraries(cspice m)

install(TARGETS cspice LIBRARY DESTINATION lib)
