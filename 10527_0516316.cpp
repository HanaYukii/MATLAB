#include<iostream>
#include<cstdio>
using namespace std;
int main()
{
    int times;
    cin>>times;
    while(times--)
    {
        int n,q;
        cin>>n>>q;
        int fun[n+1][33];
        for(int i=1;i<=n;i++)
            scanf("%d",&fun[i][0]);
        for(int i=1;i<=32;i++)
        {
            for(int j=1;j<=n;j++)
            {
                fun[j][i]=fun[fun[j][i-1]][i-1];
            }
        }
        /*
        for(int i=0;i<=5;i++)
            {
            for(int j=1;j<=n;j++)
            {
            cout<<fun[j][i]<<' ';
            }
            cout<<endl;
            }
        */

        while(q--)
        {
            int now=0,f,p,flag=0,ans;
            cin>>p>>f;
            if(p==0)
            {
                cout<<f<<endl;
                continue;
            }

            while(p>0)
            {
                if(p%2==1)
                {
                    if(!flag)
                    {
                        flag=1;
                        ans=fun[f][now];
                    }
                    else
                    {
                        ans=fun[ans][now];
                    }
                }
                now++;
                p/=2;
            }
            cout<<ans<<endl;
        }
    }

}
