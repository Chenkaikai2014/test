#这个文件定义了项目的公共编译属性，统一编译或者每个库单独编译的时候，该文件都可以使用,
#一般在各个模块中include本文件来控制编译过程。包括:
#1、平台
#2、是否编译静态库、动态库或者两者都编译
#3、Debug or Release 版本
#4、编译器选项

# 变量说明
# CROSS_PLATFORM 为自定义的变量，可以设置，X86, DM368, HI3520A等各个平台标识。
# CONF_LIBRARY 为自定义的变量，可以设置，static，share，static_share，分别对应静态库，动态库，两者兼具。

########### cross platform setup ##########

if(CROSS_PLATFORM STREQUAL X86)
	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT")
	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()
	message(STATUS "===> Cross Platform : X86")
	#message(STATUS "allRules.cmake path : >>> ${PROJECT_SOURCE_DIR}")
elseif(CROSS_PLATFORM STREQUAL DM368)
	set(CMAKE_FIND_ROOT_PATH "/opt/toolchains/davinci/v5t_le")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/toolchains/davinci/v5t_le/bin/arm_v5t_le-gcc")
	set(CMAKE_CXX_COMPILER "/opt/toolchains/davinci/v5t_le/bin/arm_v5t_le-g++")
	set(CMAKE_ASM_COMPILER "/opt/toolchains/davinci/v5t_le/bin/arm_v5t_le-gcc")
	set(CMAKE_CROSS "/opt/toolchains/davinci/v5t_le/bin/arm_v5t_le-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
	
	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : DM368")

elseif(CROSS_PLATFORM STREQUAL DM81XX)
	set(CMAKE_FIND_ROOT_PATH "/opt/toolchains/arm-arago-linux-gnueabi")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/toolchains/arm-arago-linux-gnueabi/bin/arm-arago-linux-gnueabi-gcc")
	set(CMAKE_CXX_COMPILER "/opt/toolchains/arm-arago-linux-gnueabi/bin/arm-arago-linux-gnueabi-g++")
	set(CMAKE_ASM_COMPILER "/opt/toolchains/arm-arago-linux-gnueabi/bin/arm-arago-linux-gnueabi-gcc")
	set(CMAKE_CROSS "/opt/toolchains/arm-arago-linux-gnueabi/bin/arm-arago-linux-gnueabi-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
	
	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : DM8147")
elseif(CROSS_PLATFORM STREQUAL HI3520A)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : Hi3520A")

elseif(CROSS_PLATFORM STREQUAL HI3518C)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv200-linux/bin/arm-hisiv200-linux-gnueabi-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
	
	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : Hi3518C")
	
elseif(CROSS_PLATFORM STREQUAL HI3518C-UC)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux-nptl/arm-hisiv100-linux")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux-nptl/arm-hisiv100-linux/target/bin/arm-hisiv100nptl-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux-nptl/arm-hisiv100-linux/target/bin/arm-hisiv100nptl-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux-nptl/arm-hisiv100-linux/target/bin/arm-hisiv100nptl-linux-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux-nptl/arm-hisiv100-linux/target/bin/arm-hisiv100nptl-linux-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : Hi3518C-UC")
elseif(CROSS_PLATFORM STREQUAL HI3516A)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv400-linux")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target/bin/arm-hisiv400-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target/bin/arm-hisiv400-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target/bin/arm-hisiv400-linux-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target/bin/arm-hisiv400-linux-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -mcpu=cortex-a7 -mfloat-abi=softfp -mfpu=neon-vfpv4 -mno-unaligned-access -fno-aggressive-loop-optimizations -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -mcpu=cortex-a7 -mfloat-abi=softfp -mfpu=neon-vfpv4 -mno-unaligned-access -fno-aggressive-loop-optimizations -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
	
	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : HI3516A")
elseif(CROSS_PLATFORM STREQUAL AMBARELLA)
	set(CMAKE_FIND_ROOT_PATH "/opt/arm-none-gnueabi-4.6.1/bin")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/arm-none-gnueabi-4.6.1/bin/arm-none-linux-gnueabi-4.6.1-gcc")
	set(CMAKE_CXX_COMPILER "/opt/arm-none-gnueabi-4.6.1/bin/arm-none-linux-gnueabi-4.6.1-g++")
	set(CMAKE_ASM_COMPILER "/opt/arm-none-gnueabi-4.6.1/bin/arm-none-linux-gnueabi-4.6.1-gcc")
	set(CMAKE_CROSS "/opt/arm-none-gnueabi-4.6.1/bin/arm-none-linux-gnueabi-4.6.1-")

	# arm没有浮点协处理器，必须采用-msoft-float打开软浮点支持
	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : Ambarella")
elseif(CROSS_PLATFORM STREQUAL MOZART)
	set(CMAKE_FIND_ROOT_PATH "/opt/vtcs_toolchain/arm-eabi-uclibc/usr/arm-buildroot-linux-uclibcgnueabi/sysroot /opt/vtcs_toolchain/arm-eabi-uclibc/usr/arm-buildroot-linux-uclibcgnueabi")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/vtcs_toolchain/arm-eabi-uclibc/usr/bin/arm-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/vtcs_toolchain/arm-eabi-uclibc/usr/bin/arm-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/vtcs_toolchain/arm-eabi-uclibc/usr/bin/arm-linux-gcc")
	set(CMAKE_CROSS "/opt/vtcs_toolchain/arm-eabi-uclibc/usr/bin/arm-linux-")

	# arm没有浮点协处理器，必须采用-msoft-float打开软浮点支持
	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : Mozart")
elseif(CROSS_PLATFORM STREQUAL GM8136)
	set(CMAKE_FIND_ROOT_PATH "/opt/toolchain_gnueabi-4.4.0_ARMv5TE/usr/bin")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/toolchain_gnueabi-4.4.0_ARMv5TE/usr/bin/arm-unknown-linux-uclibcgnueabi-gcc")
	set(CMAKE_CXX_COMPILER "/opt/toolchain_gnueabi-4.4.0_ARMv5TE/usr/bin/arm-unknown-linux-uclibcgnueabi-g++")
	set(CMAKE_ASM_COMPILER "/opt/toolchain_gnueabi-4.4.0_ARMv5TE/usr/bin/arm-unknown-linux-uclibcgnueabi-gcc")
	set(CMAKE_CROSS "/opt/toolchain_gnueabi-4.4.0_ARMv5TE/usr/bin/arm-unknown-linux-uclibcgnueabi-")

	# arm没有浮点协处理器，必须采用-msoft-float打开软浮点支持
	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : GM8136")
elseif(CROSS_PLATFORM STREQUAL GK7107)
	set(CMAKE_FIND_ROOT_PATH "/opt/goke-arm1176-gcc4.6.1/usr/bin")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/goke-arm1176-gcc4.6.1/usr/bin/arm-goke-linux-gnueabi-gcc")
	set(CMAKE_CXX_COMPILER "/opt/goke-arm1176-gcc4.6.1/usr/bin/arm-goke-linux-gnueabi-g++")
	set(CMAKE_ASM_COMPILER "/opt/goke-arm1176-gcc4.6.1/usr/bin/arm-goke-linux-gnueabi-gcc")
	set(CMAKE_CROSS "/opt/goke-arm1176-gcc4.6.1/usr/bin/arm-goke-linux-gnueabi-")

	# arm没有浮点协处理器，必须采用-msoft-float打开软浮点支持
	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : GK7107")
elseif(CROSS_PLATFORM STREQUAL HI3518EV200)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv300-linux")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : HI3518EV200")	
elseif(CROSS_PLATFORM STREQUAL HI3516CV200)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv300-linux")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin/arm-hisiv300-linux-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -msoft-float -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : HI3516CV200")	
elseif(CROSS_PLATFORM STREQUAL HI3516CV300)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv500-linux")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -mno-unaligned-access -fno-aggressive-loop-optimizations -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -mno-unaligned-access -fno-aggressive-loop-optimizations -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : HI3516CV300")	
elseif(CROSS_PLATFORM STREQUAL HI3519)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv600-linux")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv600-linux/target/bin/arm-hisiv600-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv600-linux/target/bin/arm-hisiv600-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv600-linux/target/bin/arm-hisiv600-linux-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv600-linux/target/bin/arm-hisiv600-linux-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -mcpu=cortex-a17.cortex-a7  -mfloat-abi=softfp -mfpu=neon-vfpv4 -ffunction-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -mcpu=cortex-a17.cortex-a7  -mfloat-abi=softfp -mfpu=neon-vfpv4 -ffunction-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : HI3519")	
elseif(CROSS_PLATFORM STREQUAL HI3519V101)
	set(CMAKE_FIND_ROOT_PATH "/opt/hisi-linux/x86-arm/arm-hisiv500-linux")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-gcc")
	set(CMAKE_CXX_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-g++")
	set(CMAKE_ASM_COMPILER "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-gcc")
	set(CMAKE_CROSS "/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin/arm-hisiv500-linux-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -mcpu=cortex-a17.cortex-a7  -mfloat-abi=softfp -mfpu=neon-vfpv4 -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -mcpu=cortex-a17.cortex-a7  -mfloat-abi=softfp -mfpu=neon-vfpv4 -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-gc-sections -mno-unaligned-access -fno-aggressive-loop-optimizations")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : HI3519V101")	
elseif(CROSS_PLATFORM STREQUAL Q3420P)
	set(CMAKE_FIND_ROOT_PATH "/opt/uclibc-4.7.3/")
	set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
	set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
	set(CMAKE_C_COMPILER "/opt/uclibc-4.7.3/bin/arm-buildroot-linux-uclibcgnueabihf-gcc")
	set(CMAKE_CXX_COMPILER "/opt/uclibc-4.7.3/bin/arm-buildroot-linux-uclibcgnueabihf-g++")
	set(CMAKE_ASM_COMPILER "/opt/uclibc-4.7.3/bin/arm-buildroot-linux-uclibcgnueabihf-gcc")
	set(CMAKE_CROSS "/opt/uclibc-4.7.3/bin/arm-buildroot-linux-uclibcgnueabihf-")

	set(CMAKE_C_FLAGS "-Wall -O2 -Os -D_REENTRANT -ffunction-sections -fdata-sections")
	set(CMAKE_CXX_FLAGS "-Wall -O2 -Os -D_REENTRANT -ffunction-sections -fdata-sections")
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")

	if (NOT CONF_LIBRARY)
		set(CONF_LIBRARY "static")
	endif ()

	message(STATUS "===> Cross Platform : Q3420P")	
else()
	message(FATAL_ERROR "Don't set CROSS_PLATFORM")
endif(CROSS_PLATFORM STREQUAL X86)

########### other ##########

# CONF_LIBRARY = static share static_share
if (NOT CONF_LIBRARY)
	set(CONF_LIBRARY "static")
endif (NOT CONF_LIBRARY)

#库文件输出地址
if (NOT LIBRARY_OUTPUT_PATH)
	set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/Bin)
endif (NOT LIBRARY_OUTPUT_PATH)
