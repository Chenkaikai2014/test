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
#include <stdio.h>
#include <string>
#include <string.h>
#include <vector>
#include <algorithm>


using namespace std;
int cmp(const pair<unsigned int, std::string>& x, const pair<unsigned int,std::string>&y)
{
	    return x.first> y.first;
}

int main(int argc, char *argv[])
{
	FILE *p = fopen(argv[1], "r");
	if (p != NULL)
	{
		std::vector< pair<unsigned int ,std::string> > maps;
		char buf[1024] = {0};
		char bufString[1024] = {0};
		while(fgets(buf, 1023, p))
		{
			unsigned int x = 0,y = 0;
			sscanf(buf, "%x-%x ", &x,&y);
			unsigned int use = y - x;
			memset(bufString, 0,  1024);
			snprintf(bufString,sizeof(bufString),"%3d Mb\t%8d Kb\t%s", use/(1024*1024), use/1024, buf);
			maps.push_back(make_pair(use,std::string(bufString)));
			memset(buf, 0,  1024);
		}
		sort(maps.begin(),maps.end(),cmp);
		for (unsigned int i = 0; i < maps.size(); ++i)
		{
			printf("%s",maps[i].second.c_str());
		}

		fclose(p);
	}
	else
	{
		printf("%s open failed\n", argv[1]);
	}
	return 0;
}	// ----------  end of function main  ----------
