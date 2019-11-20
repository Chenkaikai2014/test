#!/bin/sh
killall Hunter
rm -rf thread_memcheck_log_*
./Hunter &
./memcheck_tool 
