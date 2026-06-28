cmake_minimum_required(VERSION 3.10)
project(test)

set(SOURCES
    src/main.c
    src/module1/module1_com.c
    src/module2/module2_com.c
    src/module1/module1_1.c
    src/module2/module2_1.c
)

add_executable(test ${SOURCES})
target_include_directories(test PRIVATE
    src/include
    src/module1
    src/module2
)
set_target_properties(test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin"
)
