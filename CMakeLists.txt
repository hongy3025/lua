cmake_minimum_required(VERSION 3.1)

if ( WIN32 AND NOT CYGWIN AND NOT ( CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" ) AND NOT ANDROID)
	set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MT" CACHE STRING "")
	set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MTd" CACHE STRING "")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT" CACHE STRING "")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd" CACHE STRING "")
endif ()

project(lua)

if (WIN32 AND NOT CYGWIN)
  add_definitions(-DLUA_USE_WINDOWS=1)
else ()
  if (UNIX)
    add_definitions(-DLUA_USE_LINUX=1)
  endif()
  if (UNIX OR APPLE)
    add_definitions(-DLUA_USE_AFORMAT=1)
  endif()
endif ()

set(LUA_SRC_PATH src)

set ( LUA_IDSIZE 120 CACHE STRING "gives the maximum size for the description of the source." )

include_directories(
    ${CMAKE_SOURCE_DIR}
	${LUA_SRC_PATH}
	${CMAKE_CURRENT_BINARY_DIR}
)

aux_source_directory(${LUA_SRC_PATH} LUA_CORE)
list(REMOVE_ITEM LUA_CORE ${LUA_SRC_PATH}/lua.c ${LUA_SRC_PATH}/luac.c)

add_library(liblua ${LUA_CORE})

include(CheckLibraryExists)
if (UNIX)
  check_library_exists(m pow "" LIBM)
  if(LIBM)
    list(APPEND LIBS m)
  endif()
  check_library_exists(dl dlopen "" LIBDL)
  if(LIBDL)
    list(APPEND LIBS dl)
  endif()
endif()

add_executable(lua ${LUA_SRC_PATH}/lua.c)
target_link_libraries(lua liblua ${LIBS})

add_executable(luac ${LUA_SRC_PATH}/luac.c)
target_link_libraries(luac liblua ${LIBS})


