#include<iostream>
#include<vector>
using namespace std;
int main()
{
    int times;
    cin>>times;
    unsigned long long nth;
    int len;
    unsigned long long fac[21];
    fac[0]=1;
    fac[1]=1;
    for(int i=2; i<=20; i++)
    {
            fac[i]=fac[i-1]*i;
    }
    while(times--)
    {
        cin>>len>>nth;
        nth-=1;
        int series[len+1]={0};
        for(int i=1; i<=len; i++)
            series[i]=i;

        int ans[len]={0};
        int now=0;
        if(len>21)
        {
            for(int i=len; i>21; i--)
            {
                ans[now++]=series[1];
                for(int k=1;k<len;k++)
                series[k]=series[k+1];
            }
        }
        int k=len;
        if(len>21)
            k=21;
        for(int i=k; i>=1; i--)
        {
            long long n=nth/fac[i-1];
            ans[now++]=series[1+n];
            for(int k=1+n;k<len;k++)
                series[k]=series[k+1];
            nth%=fac[i-1];
        }
        cout<<'(';
        for(int i=0;i<len;i++)
        {
            if(i!=len-1)
            cout<<ans[i]<<',';
        }
        cout<<ans[len-1]<<')'<<endl;


    }
}

