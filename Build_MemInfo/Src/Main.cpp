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

#include "Infra/File.h"
#include "Infra/Time.h"
#include "Infra/System.h"
#include <stdio.h>
#include <string>
#include <stdio.h>
#include <string>
#include <string.h>
#include <set>
#include <map>
#include <vector>
#include <algorithm>

using namespace std;

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
	if (argc != 2)
	{
		return;
	}
	char *fileName = argv[1];
	thread_name.clear();
	FILE *p = fopen(fileName, "r");
	if (!p)
	{
		return;
	}
	char buf[1024] = {0};
	while(fgets(buf, 1023, p))
	{
		char name[64] = {0};
		unsigned int thread_id = 0;
		sscanf(buf, "%s %d", &name, &thread_id);
		if (strlen(name) == 0)
		{
			break;
		}
		thread_name[thread_id] = name;
	}

	fclose(p);
}

int main(int argc, char *argv[])
{
	std::map<unsigned int,std::string> thread_name;
	getThread_name(argc, argv, thread_name);
	
//		CTime::sleep(1000);
	FILE *p = fopen("./memCheck.txt", "r");
	std::map<unsigned int, memInfo> malloc;
	std::map<unsigned int,unsigned int> first_info;
	bool bFirst = true;
	int relCount = 0;
	if (p != NULL)
	{
		//M:0x2d25da0 S:32 P:13029
		//F:0x2d17890
		int readNum = 0;
		//while(1)
		{
			char buf[1024] = {0};
			readNum = 0;
			while(fgets(buf, 1023, p))
			{
				readNum++;
				if (strstr(buf, "M:") != 0)
				{
					unsigned int  m = 0, size = 0,id = 0;
					sscanf(buf, "M:%p S:%u P:%u\n", &m, &size, &id);
					memInfo info;
					info.size = size;
					info.id = id;
					malloc[m] = info;
				}
				else if (strstr(buf, "F:") != 0)
				{
					//free:0xe86560
					unsigned int m = 0;
					sscanf(buf, "F:%p\n", &m);
					malloc.erase(m);
				}
				memset(buf, 0,  1024);
			}

			if (relCount++ == 3)
			{
				relCount = 0;
				getThread_name(argc, argv, thread_name);
			}
			CTime::sleep(1000 * 5);
			Hunter::Infra::systemCall("clear");
			std::map<unsigned int,unsigned int> info;
			int totalsize = 0;
			for (std::map<unsigned int, memInfo>::iterator it = malloc.begin(); it != malloc.end(); it++)
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

			printf("Total\t%d M threadNum %d readNum %d relCount %d\n", (totalsize)/(1024*1024), thread.size(), readNum, relCount);
			for(int i = 0;i < thread.size();i++)
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
