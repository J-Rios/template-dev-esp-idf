# Project Main CMake File
# Note: Keep next lines in this exact order for CMake to work correctly

# CMake Setup
cmake_minimum_required(VERSION 3.22)

# Path to CMake
include($ENV{IDF_PATH}/tools/cmake/project.cmake)

# "Trim" the build (minimal set of components, main, dependencies)
#idf_build_set_property(MINIMAL_BUILD ON)

# Project Name
project(template_dev_esp_idf)
