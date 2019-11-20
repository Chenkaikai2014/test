//
//	"$Id:$"
// 
//	Copyright (c)2014-2024, ZheJiang ZhiNuo Technology Stock CO.LTD.
//  All Rights Reserved.
// 
//	Description:
// 
//	Revisions:	Year-Month-Day		SVN-Author		Modification
//				12/04/2018			chenkaikai		Create
//


#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <pthread.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/syscall.h> 
#include <string.h>
#include <sys/prctl.h>
#include "ThreadMemCheck.h"

pthread_mutex_t wrap_mutex = PTHREAD_MUTEX_INITIALIZER;
#ifdef __cplusplus
extern "C" {
#endif
static int g_test_thread = -1;
static bool s_memset = false;
static char s_fileName[128] = {0};
static int s_file_count = 0;
static int s_file_max_size = 1024 * 1024 * 512;
static char s_filePatch[128] = {0};
static int s_check_size = 1024;
static int s_check_start = 0;
static int s_fifo_file = -1;
static int s_is_open  = 0;

static void openNextFile()
{
	if (s_fifo_file != -1)
	{
		close(s_fifo_file);
		s_fifo_file = -1;
	}

	s_is_open = 0;
	snprintf(s_fileName,sizeof(s_fileName),"%sthread_memcheck_log_%d.txt",s_filePatch,s_file_count);
	s_fifo_file = open(s_fileName, O_WRONLY|O_TRUNC|O_CREAT, 0777);
	if (s_fifo_file != -1)
	{
		s_is_open = 1;
		s_file_count++;
	}
	else
	{
		printf("thread_memcheck fifo(%s) open faild\n", s_fileName);
	}
	return;
}
static char procName[32] = {0};
void thread_memcheck_config(threadCheckConfig *cfig)
{
	if (cfig != NULL )
	{
		strncpy(s_filePatch,cfig->filePatch,sizeof(s_filePatch));
		s_check_size = cfig->checkSize;
		s_check_start = cfig->start;
		strncpy(procName,cfig->procName,sizeof(procName));
		openNextFile();
	}
}

void thread_memcheck_start(int threadId)
{
	s_check_start = 1;
	g_test_thread = threadId;
}
void thread_memcheck_stop(void)
{
	s_check_start = 0;
}


extern void *__real_malloc(size_t);
extern void __real_free(void *ptr);
extern void *__real_calloc(size_t nmemb, size_t size);
extern void *__real_realloc(void *ptr, size_t size);
static void mem_writeFile(const char *buf,int len)
{
	int ret = 0;
	static int file_size = 0;
	pthread_mutex_lock(&wrap_mutex);
	while (ret != len)
	{
		int size = write(s_fifo_file, (char *)buf + ret, len - ret);
		ret += size;
	}
	file_size += len;
	if (file_size >= s_file_max_size)
	{
		openNextFile();
		file_size = 0;
	}
	pthread_mutex_unlock(&wrap_mutex);
}

static void malloc_record(void *p, size_t c)
{
	if (!s_check_start || !s_is_open || c < s_check_size)
	{
		return;
	}

	char buf[128] = {0};
	char cThreadName[32] = {0};
	prctl(PR_GET_NAME,(unsigned long)cThreadName);
	if (strcmp(cThreadName,procName) == 0)
	{
		memset(cThreadName,0,sizeof(cThreadName));
		snprintf(cThreadName,sizeof(cThreadName),"%d",(int)syscall(SYS_gettid));
	}
	sprintf(buf, "M:%p S:%zu P:%s\n", p, c,cThreadName);
	if (g_test_thread != -1)
	{
		if (g_test_thread == (int)syscall(SYS_gettid))
		{
			mem_writeFile(buf,strlen(buf));
		}
	}
	else
	{
		mem_writeFile(buf,strlen(buf));
	}
}

static void free_record(void *p)
{
	if (!s_check_start || !s_is_open)
	{
		return;
	}

	if (p)
	{
		char buf[128] = {0};
		sprintf(buf, "F:%p\n", p);
		mem_writeFile(buf,strlen(buf));
	}
}

void *__wrap_calloc(size_t nmemb, size_t size)
{
	void *p = __real_calloc(nmemb, size);
	if (s_memset)
		memset(p,0,size);
	malloc_record(p, nmemb*size);
	return p;
}

void *__wrap_realloc(void *ptr, size_t size)
{
	void *p = __real_realloc(ptr, size);
	if (s_memset)
		memset(p,0,size);
	free_record(ptr);
	malloc_record(p, size);
	return p;
}
void *__wrap_malloc(size_t c)
{

	void *p = NULL;
	p = __real_malloc(c);
	if (s_memset)
		memset(p,0,c);
	malloc_record(p, c);
	return p;
}

void __wrap_free(void *ptr)
{
	__real_free(ptr);
	free_record(ptr);
	return;
}
#ifdef __cplusplus
}
#endif

void * operator new (size_t size){
    return __wrap_malloc(size);
}
 
void * operator new [](size_t size){
    return operator new(size);
}
 
void operator delete (void * pointer){
    if(0 != pointer){
        __wrap_free(pointer);
    }   
}
 
void operator delete[](void * pointer){
           operator delete(pointer);
}

