//
//	"$Id:$"
// 
//	Copyright (c)2014-2024, ZheJiang ZhiNuo Technology Stock CO.LTD.
//  All Rights Reserved.
// 
//	Description:
// 
//	Revisions:	Year-Month-Day		SVN-Author		Modification
//				2017年01月12日		chenkaikai		Create
//
#include "ThreadMemCheck.h"
#include <pthread.h>
#include <sys/select.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/syscall.h> 
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

void thread_sleep(void)
{
	struct timeval sleep_timet;
	sleep_timet.tv_sec = 1;
	sleep_timet.tv_usec = 0;
	select(0, NULL, NULL, NULL, &sleep_timet);
}

void* pthread_func1(void *arg)
{
	void *buffer = malloc(1024 * 1024);
	if (buffer)
	{
		printf("malloc %d\n",(int)syscall(SYS_gettid));
	}
	while(1)
	{
		thread_sleep();
	}
	return NULL;
}

void* pthread_func2(void *arg)
{
	void *buffer = calloc(1024,512);
	if (buffer)
	{
		printf("calloc %d\n",(int)syscall(SYS_gettid));
	}
	while(1)
	{
		thread_sleep();
	}
	return NULL;
}

static const int s_count = 10;
void* pthread_func3(void *arg)
{
	printf("newAndDelete %d\n",(int)syscall(SYS_gettid));
	char *buffer[s_count];
	while(1)
	{
		for (int i = 0; i < s_count; ++i)
		{
			buffer[i] = new char [1024 * 4];
			thread_sleep();
		}

		for (int i = 0; i < s_count; ++i)
		{
			delete [] buffer[i];
			buffer[i] = NULL;
			thread_sleep();
		}
	}
	return NULL;
}

void* pthread_func4(void *arg)
{
	void *buffer = malloc(1024 * 1024);
	void *buffer_new = realloc(buffer,1024*1024*2);
	if (buffer_new)
	{
		printf("realloc %d\n",(int)syscall(SYS_gettid));
	}
	while(1)
	{
		thread_sleep();
	}
	return NULL;
}

void* pthread_func5(void *arg)
{
	void *buffer[s_count];
	memset(buffer,0,sizeof(buffer));
	printf("mallocAndFree %d\n",(int)syscall(SYS_gettid));
	while(1)
	{
		for (int i = 0; i < s_count; i++)
		{
			buffer[i] = malloc(1024);
			thread_sleep();
		}

		for (int i = 0; i < s_count; i++)
		{
			free(buffer[i]);
			thread_sleep();
		}
	}
	return NULL;
}

int main(int argc, char *argv[])
{
	const char *fileName = "./";
	thread_memcheck_config(fileName,0,1);
	pthread_t tid1,tid2,tid3,tid4,tid5;
	pthread_create(&tid1,NULL,pthread_func1,NULL);
	pthread_create(&tid2,NULL,pthread_func2,NULL);
	pthread_create(&tid3,NULL,pthread_func3,NULL);
	pthread_create(&tid4,NULL,pthread_func4,NULL);
	pthread_create(&tid5,NULL,pthread_func5,NULL);
	while(1)
	{
		fflush(stdout);
		thread_sleep();
	}

	return 0;
}	// ----------  end of function main  ----------
