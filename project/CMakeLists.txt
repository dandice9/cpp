set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

cmake_minimum_required(VERSION 3.18)

set(APP_NAME "cpp-app")
project("${APP_NAME}")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -std=c++20 -Wno-multichar")

file(
    GLOB
    SOURCES
    "src/**/*.cpp"
    "src/*.cpp"
)

# This command attempts to find the library, REQUIRED argument is optional
find_package(PostgreSQL REQUIRED)
find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
include_directories(${PostgreSQL_INCLUDE_DIRS})

add_executable("${APP_NAME}" ${SOURCES})

target_link_libraries("${APP_NAME}" PRIVATE ${PostgreSQL_LIBRARIES})
target_link_libraries("${APP_NAME}" ${Boost_LIBRARIES})