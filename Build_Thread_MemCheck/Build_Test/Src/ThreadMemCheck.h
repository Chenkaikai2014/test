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
#ifndef _THREAD_MEMCHECK_H__
#define _THREAD_MEMCHECK_H__

#ifdef __cplusplus
extern "C" {
#endif

void thread_memcheck_config(const char *filePatch,int checkSize,int start);

void thread_memcheck_start(void);

void thread_memcheck_stop(void);


#ifdef __cplusplus
}
#endif

#endif
