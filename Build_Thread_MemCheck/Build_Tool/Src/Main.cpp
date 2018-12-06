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

#include <stdio.h>
#include <string>
#include <sys/wait.h>
#include <errno.h>
#include <stdio.h>
#include <string>
#include <string.h>
#include <set>
#include <map>
#include <vector>
#include <algorithm>
#include <unistd.h>

using namespace std;

void thread_sleep(void)
{
    struct timeval sleep_timet;
    sleep_timet.tv_sec = 5;
    sleep_timet.tv_usec = 0;
    select(0, NULL, NULL, NULL, &sleep_timet);
}

typedef struct memInfo{
	unsigned int size;
	unsigned int id;
}memInfo;

int cmp(const pair<unsigned int, unsigned int>& x, const pair<unsigned int,unsigned int>&y)
{
	return x.second > y.second;
}

void getThread_name(int argc, char *argv[], std::map<unsigned int, std::string> &thread_name)
{
	char *fileName = argv[1];
	thread_name.clear();
	FILE *p = fopen(fileName, "r");
	if (!p)
	{
		printf("getThread_name open failed %s\n", fileName);
		return;
	}
	char buf[1024] = {0};
	while(fgets(buf, 1023, p))
	{
		char name[64] = {0};
		unsigned int thread_id = 0;
		sscanf(buf, "%s %d", name, &thread_id);
		if (strlen(name) == 0)
		{
			break;
		}
		thread_name[thread_id] = name;
	}

	fclose(p);
}

void clear_print()
{
    int status = -1; 
    pid_t pid = vfork();

    if (pid < 0)
    {   
        status = -1; 
    }   
    else if (pid == 0)
    {   
        execl("/bin/sh", "sh", "-c", "clear", (char*)0);
        _exit(127);
    }   
    else
    {   
        while (waitpid(pid, &status, 0) < 0)
        {   
            if (errno != EINTR)
            {   
                status = -1; 
                break;
            }   
        }   
    }   

    return;
}

static int s_file_count = 0;
static char s_filePatch[128] = {0};
char fileName[128] = {0};

void openNextFile(FILE **file)
{
	snprintf(fileName,sizeof(fileName),"%sthread_memcheck_log_%d.txt",s_filePatch,s_file_count);
	FILE *p = fopen(fileName, "r");
	*file = p;
	if (p)
	{
		s_file_count++;
	}
}

int main(int argc, char *argv[])
{
	std::map<unsigned int,std::string> thread_name;
	getThread_name(argc, argv, thread_name);	

	strncpy(s_filePatch,argv[2],sizeof(s_filePatch));
	
	FILE *p = NULL;
	openNextFile(&p);
	std::map<void *, memInfo> malloc;
	std::map<unsigned int,unsigned int> first_info;
	bool bFirst = true;
	int relCount = 0;
	int eof_count = 0;
	if (p != NULL)
	{
		int readNum = 0;
		while(1)
		{
			char buf[1024] = {0};
			int read_file_size = 0;
			while(fgets(buf, 1023, p))
			{
				readNum++;
				if (strstr(buf, "M:") != 0)
				{
					unsigned int  size = 0,id = 0;
					void *m = NULL;
					sscanf(buf, "M:%p S:%u P:%u\n", &m, &size, &id);
					memInfo info;
					info.size = size;
					info.id = id;
					malloc[m] = info;
				}
				else if (strstr(buf, "F:") != 0)
				{
					void *m = 0;
					sscanf(buf, "F:%p\n", &m);
					malloc.erase(m);
				}
				read_file_size = strlen(buf);
				eof_count = 0;
				memset(buf, 0,  1024);
			}

			if (feof(p))
			{
				eof_count++;
			}
			if (eof_count >= 3)
			{
				if (p)
				{
					fclose(p);
				}
				p = NULL;
				openNextFile(&p);
			}

			if (relCount++ == 3)
			{
				relCount = 0;
				getThread_name(argc, argv, thread_name);
			}
			thread_sleep();
			clear_print();
			std::map<unsigned int,unsigned int> info;
			int totalsize = 0;
			for (std::map<void *, memInfo>::iterator it = malloc.begin(); it != malloc.end(); it++)
			{
				memInfo &value = it->second;
				totalsize += value.size;
				if (info.find(value.id) != info.end())
				{
					info[value.id] = info[value.id] + value.size;
				}
				else
				{
					info[value.id] = value.size;
				}
			}
			if (bFirst)
			{
				first_info = info;
				bFirst = false;
			}

			vector< pair<unsigned int,unsigned int> > thread;
			for (std::map<unsigned int,unsigned int>::iterator it = info.begin(); it != info.end(); it++)
			{
				thread.push_back(make_pair(it->first,it->second));
			}

			sort(thread.begin(),thread.end(), cmp);

			printf("Total\t%d M threadNum %zu readNum %d relCount %d file:%s\n", (totalsize)/(1024*1024), thread.size(), readNum, relCount,fileName);
			for(size_t i = 0;i < thread.size();i++)
			{
				std::map<unsigned int,unsigned int>::iterator iter_first = first_info.find(thread[i].first);
				int diff = 0;
				if (iter_first == first_info.end())
				{
					first_info[thread[i].first] = thread[i].second;
				}
				else
				{
					diff = (int)(thread[i].second) - (int)(iter_first->second);
				}

				if ((thread[i].second)/1024 > 0)
				{
					std::string name;
					if (thread_name.find(thread[i].first) != thread_name.end())
					{
						name = thread_name[thread[i].first];
					}
					printf("%u\t\t%d K \t%d M\t DIFF %d K\t%d M %s\n", thread[i].first, (thread[i].second)/1024, (thread[i].second)/(1024*1024), diff/1024, diff/(1024*1024),  name.c_str());
				}
			}
		}

		fclose(p);
	}
	return 0;
}	// ----------  end of function main  ----------
