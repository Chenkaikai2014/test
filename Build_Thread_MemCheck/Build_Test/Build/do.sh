#!/bin/sh
killall memcheck_test
rm -rf thread_memcheck_log_*
touch threadName.txt
./memcheck_test > ./threadName.txt &
./memcheck_tool ./threadName.txt ./
