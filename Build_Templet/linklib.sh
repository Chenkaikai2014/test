#!/bin/sh
tmp="../"
flag='"'
patch=$tmp$1
if [ -f $patch ];then
	cd $patch
	sed -i '/lib.*\.a/d' ../../Src/CMakeLists.txt
	file_name='.*\.a'
	for file in $(find -regex $file_name)
	do
		libName=$flag${file#./}$flag
		sed -i "/set.*app_libs/a$libName" ../../Src/CMakeLists.txt
	done
	cd -
fi
