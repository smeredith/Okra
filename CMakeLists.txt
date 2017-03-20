CMAKE_MINIMUM_REQUIRED(VERSION 3.2.2)

set( CMAKE_CXX_STANDARD 14 )
enable_testing ()
include_directories(AFTER ${CMAKE_CURRENT_SOURCE_DIR})
FILE(GLOB_RECURSE ALL_SOURCE_FILES
    "Tests/*.cpp"
    )

# all_tests
FILE(WRITE ${CMAKE_BINARY_DIR}/all_tests.cpp "#define OKRA_MAIN\n#include \"okra.h\"")
ADD_EXECUTABLE(all_tests ${ALL_SOURCE_FILES} ${CMAKE_BINARY_DIR}/all_tests.cpp)
ADD_TEST(all_tests all_tests)
IF (WIN32)
ELSE()
    target_link_libraries(all_tests stdc++fs )
ENDIF()

FOREACH(file ${ALL_SOURCE_FILES})
    FILE(RELATIVE_PATH executablefile ${CMAKE_CURRENT_SOURCE_DIR}/Tests ${file})
    # https://cmake.org/cmake/help/v3.0/policy/CMP0037.html
    STRING(REPLACE ".cpp" "" executablefile ${executablefile} )
    STRING(REPLACE "/" "__" executablefile ${executablefile} )
    STRING(REGEX REPLACE "[^A-Za-z0-9_.+-]" "_" executablefile ${executablefile} )
    ADD_EXECUTABLE(${executablefile} ${file})
    ADD_TEST(${executablefile} ${executablefile})
    TARGET_COMPILE_DEFINITIONS(${executablefile} PRIVATE OKRA_MAIN=1)
    IF (WIN32)
    ELSE()
        target_link_libraries(${executablefile} stdc++fs )
    ENDIF()
ENDFOREACH(file)
