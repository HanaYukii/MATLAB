#include<map>
#include<iostream>
#include<cstdio>
using namespace std;
int main()
{
    int num;
    while(cin>>num)
    {
        if(num==0)
            break;
        long long add,sum[num+1],ans=0;
        sum[0]=0;
        for(int i=1; i<=num; i++)
        {
            cin>>add;
            sum[i]=sum[i-1]+add;

        }
        map<long long ,long long> op;
        for(int i=0; i<=num; i++)
        {
            op[sum[i]]++;
        }
        for (auto it = op.begin(); it != op.end(); ++it)
        {
            ans+=(it->second)*(it->second-1)/2;
        }

        cout<<ans<<endl;
    }
}
