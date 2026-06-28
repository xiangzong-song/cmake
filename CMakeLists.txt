cmake_minimum_required(VERSION 3.10)
project(test)

file(GLOB_RECURSE SOURCES src/*.c)
add_executable(test ${SOURCES})

# === Parse sdkconfig ===
set(CONFIG_DEFINES "")
if(EXISTS ${PROJECT_SOURCE_DIR}/sdkconfig)
    file(STRINGS ${PROJECT_SOURCE_DIR}/sdkconfig CONFIG_LINES REGEX "^CONFIG_")
    foreach(LINE ${CONFIG_LINES})
        string(REGEX MATCH "^CONFIG_([^=]+)=y$" _ ${LINE})
        if(CMAKE_MATCH_1)
            list(APPEND CONFIG_DEFINES "CONFIG_${CMAKE_MATCH_1}")
            continue()
        endif()
        string(REGEX MATCH "^CONFIG_([^=]+)=n$" _ ${LINE})
        if(CMAKE_MATCH_1)
            continue()
        endif()
        string(REGEX MATCH "^CONFIG_([^=]+)=(.+)$" _ ${LINE})
        if(CMAKE_MATCH_1 AND CMAKE_MATCH_2)
            list(APPEND CONFIG_DEFINES "CONFIG_${CMAKE_MATCH_1}=${CMAKE_MATCH_2}")
        endif()
    endforeach()
    target_compile_definitions(test PRIVATE ${CONFIG_DEFINES})
    message(STATUS "sdkconfig: ${CONFIG_DEFINES}")
endif()

# === Include dirs ===
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
