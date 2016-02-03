cmake_minimum_required(VERSION 2.8.1)

project(cspice C)
enable_language(C CXX)

set(BITNESS 32)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(BITNESS 64)  
endif()

include(CMakeSrc.txt)
if(WIN32)
  include(GenerateExportHeader)
endif()

set(CMAKE_C_FLAGS "-m${BITNESS} -DNON_UNIX_STDIO -ansi")

add_library(cspice SHARED ${SRCS})
if(WIN32)
  GENERATE_EXPORT_HEADER(cspice
             BASE_NAME cspice
             EXPORT_MACRO_NAME cspice_EXPORT
             EXPORT_FILE_NAME cspice_Export.h
             STATIC_DEFINE cspice_BUILT_AS_STATIC)
endif()
target_link_libraries(cspice m)

INSTALL(
  TARGETS cspice
  RUNTIME DESTINATION lib
  LIBRARY DESTINATION lib
)
