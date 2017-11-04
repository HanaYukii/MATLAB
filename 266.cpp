#include<bits/stdc++.h>
using namespace std;

int main()
{
    int t;
    cin>>t;
    while(t--)
    {
        int len , mod;
        cin>>len>>mod;
        char s[len];
        scanf("%s",s);
        long long cnt=0;
        long long now=0;
        for(int i=0;i<len;i++)
        {
            now*=10;
            now+=s[i]-'0';
            if(now%mod==0)
            {
                now=0;
                cnt++;
            }
        }
        if(now!=0)
            cnt=1;
        cout<<cnt<<endl;
    }
}
