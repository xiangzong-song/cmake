cmake_minimum_required(VERSION 3.10)
project(test)

option(RELEASE_VER "Build release version" OFF)

file(GLOB_RECURSE SOURCES src/*.c)

add_executable(test ${SOURCES})

target_compile_definitions(test PRIVATE
    $<IF:$<BOOL:${RELEASE_VER}>,RELEASE_VER,>
)

file(GLOB ALL_ENTRIES src/*)
foreach(ENTRY ${ALL_ENTRIES})
    if(IS_DIRECTORY ${ENTRY})
        list(APPEND INCLUDE_DIRS ${ENTRY})
    endif()
endforeach()
target_include_directories(test PRIVATE ${INCLUDE_DIRS})

set_target_properties(test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin"
)
