cmake_minimum_required(VERSION 2.8)

if (NOT PROJECT_NAME)
	project(sonia C CXX ASM)
elseif (${PROJECT_NAME} STREQUAL sonia)
	project(sonia C CXX ASM)
endif(NOT PROJECT_NAME)
message(STATUS "Project name : --- ${PROJECT_NAME}")

message(STATUS "Current dir : --- ${CMAKE_CURRENT_SOURCE_DIR}")

set(CMAKE_BUILD_TYPE Debug)

#-----------------------------------------------------------------------------
# 配置平台参数
if (NOT CROSS_PLATFORM)
	set(CROSS_PLATFORM X86)
endif(NOT CROSS_PLATFORM)

set(PROJECT_COMPILE c_static_cpp_static)


# 包含平台通用编译规则，为了那些跨平台代码，采用公共且唯一的allRules.cmake。
# allRules.cmake 暂时放置在Libs目录下
if (EXISTS ${PROJECT_SOURCE_DIR}/allRules.cmake)
	include(${PROJECT_SOURCE_DIR}/allRules.cmake)
elseif (EXISTS ${PROJECT_SOURCE_DIR}/../allRules.cmake)
	include(${PROJECT_SOURCE_DIR}/../allRules.cmake)
elseif (EXISTS ${PROJECT_SOURCE_DIR}/Rules/allRules.cmake)
	include(${PROJECT_SOURCE_DIR}/Rules/allRules.cmake)
else ()
	message(FATAL_ERROR "Can't include allRules.cmake")
endif ()

execute_process(COMMAND sh ../linklib.sh Platform/${CROSS_PLATFORM})

set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/Platform/${CROSS_PLATFORM})
message(STATUS "link libs path : ${LIBRARY_OUTPUT_PATH}")
add_subdirectory(./Src)
