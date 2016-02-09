cmake_minimum_required(VERSION 2.8.1)

project(cspice C)
enable_language(C)

SET(BITNESS "32" CACHE STRING "The bitness.")

include(CMakeSrc.txt)

set(CMAKE_C_FLAGS "/O2 -D_COMPLEX_DEFINED -DMSDOS -DOMIT_BLANK_CC -DNON_ANSI_STDIO")

add_library(cspice SHARED ${SRCS})
