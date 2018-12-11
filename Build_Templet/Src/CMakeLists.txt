aux_source_directory(. Proj_source)
include_directories(../Include)

set(app_libs
	)

# 设置库和工程的目标文件输出路径。
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR})

# link_directories 要放在add_executable前面，否则无效。
link_directories(${LIBRARY_OUTPUT_PATH})

foreach(lib ${app_libs})
	set(all_libs ${all_libs} ${LIBRARY_OUTPUT_PATH}/${lib})
endforeach()

foreach(lib ${app_libs})
	set(all_libs ${all_libs} ${LIBRARY_OUTPUT_PATH}/${lib})
endforeach()

message(STATUS "link libs : ${all_libs}")

message(STATUS "link FLAGS : ${CMAKE_EXE_LINKER_FLAGS}")

add_executable(sonia ${Proj_source})

target_link_libraries(sonia ${all_libs})

target_link_libraries(sonia "-lpthread -lc -ldl -lrt")
