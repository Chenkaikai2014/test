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
///内存检测配置文件，128字节
typedef struct threadCheckConfig
{
	const char 		*filePatch;		///< 存放统计信息的文件路径
	int				checkSize;		///< 最小内存检测，单位为字节
	unsigned char	start; 			///< 1:马上开始所有线程的检测 0：依赖start接口开启检测
	unsigned char	reverd[3];		///< 保留
	const char 		*procName;		///< 进程名称
	int				reverd1[28];	///< 保留
}threadCheckConfig;

void thread_memcheck_config(threadCheckConfig *cfig);

/// 开启线程内存检测
///	\param[in] threadId 开启检测的线程id，-1：开启所有线程
void thread_memcheck_start(int threadId);

/// 关闭线程内存检测
void thread_memcheck_stop(void);


#ifdef __cplusplus
}
#endif

#endif
