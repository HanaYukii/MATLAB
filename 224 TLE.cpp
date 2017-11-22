#include<bits/stdc++.h>
using namespace std;
long long now[1000005];
long long goal[1000005];
long long dp[1000005];
vector<int> g[1000005];
int main()
{
    int n;
    cin>>n;
    for(int i=1;i<=n;i++)
    {
        cin>>now[i];
    }
    for(int i=1;i<=n;i++)
    {
        cin>>goal[i];
    }
    for(int i=1;i<n;i++)
    {
        int add1,add2;
        cin>>add1>>add2;
        g[add1].push_back(add2);
        g[add2].push_back(add1);
    }
    int cnt=0;
    int pos=1;
    while(cnt<n-1)
    {
        if(g[pos].size()==1)
        {
            int root=pos;
            int root1=g[pos][0];
            long long amount=goal[root]-now[root];
            ag:;
            /*cout<<root<<' '<<root1<<endl;*/
            dp[root]=max(dp[root],abs(amount));
            dp[root1]=max(dp[root1],abs(amount));
            now[root]=goal[root];
            now[root1]-=amount;
            g[root].pop_back();
            int fi;
            for(int i=0;i<g[root1].size();i++)
            {
                if(g[root1][i]==root)
                {
                    fi=i;
                    break;
                }
            }
            g[root1][fi]=g[root1][g[root1].size()-1];
            g[root1].pop_back();

            /*for(int k=0;k<g[root].size();k++)
                cout<<g[root][k]<<' ';*/
            cnt++;
            if(g[root1].size()==1)
            {
                root=root1;
                root1=g[root][0];
                amount=goal[root]-now[root];
                goto ag;
            }
        }
        else
        {
            pos++;
        }
        if(pos==n+1)
            pos=1;

    }
    long long maxx=0;
    /*for(int i=1;i<=n;i++)
        cout<<dp[i]<<' ';
    cout<<endl;*/
    for(int i=1;i<=n;i++)
    {
        maxx=max(maxx,dp[i]);
    }
    cout<<maxx<<endl;
}
