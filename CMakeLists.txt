cmake_minimum_required(VERSION 3.1)

if ( WIN32 AND NOT CYGWIN AND NOT ( CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" ) AND NOT ANDROID)
	set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MT" CACHE STRING "")
	set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MTd" CACHE STRING "")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT" CACHE STRING "")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd" CACHE STRING "")
endif ()

project(lua)

set(LUA_SRC_PATH src)

set ( LUA_IDSIZE 120 CACHE STRING "gives the maximum size for the description of the source." )

include_directories(
    ${CMAKE_SOURCE_DIR}
	${LUA_SRC_PATH}
	${CMAKE_CURRENT_BINARY_DIR}
)

aux_source_directory(${LUA_SRC_PATH} LUA_CORE)
list(REMOVE_ITEM LUA_CORE ${LUA_SRC_PATH}/lua.c ${LUA_SRC_PATH}/luac.c)

add_library(liblua
    ${LUA_CORE}
)

add_executable(lua
    ${LUA_SRC_PATH}/lua.c
)
target_link_libraries(lua liblua)

add_executable(luac
    ${LUA_SRC_PATH}/luac.c
)
target_link_libraries(luac liblua)


