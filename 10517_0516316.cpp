#include <algorithm>
#include <cstdio>
#include <cstring>
#define maxn 100005
using namespace std;

long long tree[maxn], srt[maxn], cont[maxn];

long long read(int idx)
{
    long long sum = 0;
    while (idx > 0)
    {
        sum += tree[idx];
        idx -= (idx & -idx);
    }
    return sum;
}

void update(int idx,long long val)
{
    while (idx <= maxn)
    {
        tree[idx] += val;
        idx += (idx & -idx);
    }
}

int main()
{
    int times;
    scanf("%d",&times);
    while(times--)
    {
        memset(tree,0,sizeof(tree));
        int num;
        scanf("%d",&num);

        for(int i=0;i<num;++i)
        {
            scanf("%lld",&srt[i]);
            cont[i]=srt[i];
        }
        sort(cont,cont+num);
        for(int i = 0; i < num; ++i)
        {
            int tmp= int(lower_bound(cont,cont+num,srt[i])-cont);
            srt[i]=tmp+1;
        }

        long long inv_cnt= 0;
        for(int i =num- 1; i >= 0; --i)
        {
            long long x = read(srt[i]- 1);
            inv_cnt += x;
            update(srt[i], 1);
        }
        printf("%lld\n",inv_cnt);

    }
    return 0;
}
