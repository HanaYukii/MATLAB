#include<bits/stdc++.h>
using namespace std;
long long now[1000005];
long long goal[1000005];
long long dp[1000005];
vector<int> g[1000005];
int cnt;
long long read()
{
    char cha;
    long long x=0;
    while(cha=getchar())
        if(cha!=' '&&cha!='\n') break;
    x=x*10+cha-48;
    while(cha=getchar())
    {
        if(cha==' '||cha=='\n') break;
        x=x*10+cha-48;
    }
    return x;
}
void BFS(int idx,int pre)
{
    if(g[idx].size()==1)
    {
        int root=idx,root1=g[idx][0];
        long long amount=goal[idx]-now[idx];
        dp[root]=max(dp[root],abs(amount));
        dp[root1]=max(dp[root1],abs(amount));
        now[root]=goal[root];
        now[root1]-=amount;
        g[root].pop_back();
        int f;
        for(int i=0; i<g[root1].size(); i++)
        {
            if(g[root1][i]==root)
            {
                f=i;
                break;
            }
        }
        g[root1][f]=g[root1][g[root1].size()-1];
        g[root1].pop_back();
        if(g[root1].size())
            BFS(root1,root);
    }
    else
    {
        for(int i=0; i<g[idx].size(); i++)
        {
            if(g[idx][i]==pre)
                continue;
            BFS(g[idx][i],idx);
        }
    }
}

int main()
{
    int n;
    cin>>n;
    for(int i=1; i<=n; i++)
    {
        now[i]=read();
    }
    for(int i=1; i<=n; i++)
    {
        goal[i]=read();
    }
    for(int i=1; i<n; i++)
    {
        int add1,add2;
        scanf("%d %d",&add1,&add2);
        g[add1].push_back(add2);
        g[add2].push_back(add1);
    }
    BFS(1,0);

    long long maxx=0;

    for(int i=1; i<=n; i++)
    {
        maxx=max(maxx,dp[i]);
    }
    printf("%lld\n",maxx);
}
