#include<iostream>
using namespace std;
#define maxn 32700
int s1[maxn],s2[maxn],ans[2*maxn];
void karatsuba(int s1[],int s2[],int pos_start,int pos_end)
{
    if(pos_start==pos_end)
    {

    }
}
int main()
{
    int times;
    cin>>times;
    while(times--)
    {
        int num;cin>>num;

        for(int i=num-1;i>=0;i--)
            cin>>s1[i];
        for(int i=num-1;i>=0;i--)
            cin>>s2[i];
            karatsuba(s1,s2,0,num-1);
        for(i=2*num-1;i>=0;i--)
            cout<<ans[i]<<' ';
            cout<<endl;
    }
}
