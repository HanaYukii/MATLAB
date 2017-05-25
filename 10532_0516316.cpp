#include<bits/stdc++.h>
using namespace std;
int t;
int seq[100000];
int incre[100000];
int decre[100000];
int bs(int num)
{
    int high = t;
    int low = 0;
    while(low!=high)
    {
        int mid=(low+high)/2;
        if(incre[mid]>num)
        {
            low=mid+1;
        }
        else
        {
            high=mid;
        }
    }
    incre[high]=num;
    return high+1;
}
int bs2(int num)
{
    int high = t;
    int low = 0;
    while(low!=high)
    {
        int mid=(low+high)/2;
        if(decre[mid]>num)
        {
            low=mid+1;
        }
        else
        {
            high=mid;
        }
    }
    decre[high]=num;
    return high+1;
}
int main()
{
    int n;
    scanf("%d",&n);
    while(n--)
    {
        scanf("%d",&t);
        for(int i=0; i<t; i++)
        {
            scanf("%d",&seq[i]);
            if(seq[i]==-2147483648)
                seq[i]++;
        }

        int inc_cnt[t]= {0};
        int dec_cnt[t]= {0};
        for(int i=0; i<t; i++)
        {
            decre[i]=-2147483648;
            incre[i]=-2147483648;
        }
        for(int i=t-1; i>=0; i--)
        {
            inc_cnt[i]=bs(seq[i]);
            /*for (int i=0;i<t;i++)
            {
            cout<<incre[i]<<' ';
            }
            cout<<endl;*/
        }
        for(int i=0; i<=(t-1)/2; i++)
        {
            int tmp=seq[i];
            seq[i]=seq[t-1-i];
            seq[t-1-i]=tmp;
        }
        for(int i=t-1; i>=0; i--)
        {
            dec_cnt[t-1-i]=bs2(seq[i]);
            /*for (int i=0;i<t;i++)
            {
            cout<<decre[i]<<' ';
            }
            cout<<endl;*/
        }
        /*for(int i=0; i<t; i++)
            cout<<inc_cnt[i]<<' '<<dec_cnt[i]<<endl;*/
        int ans=0;

        for(int i=0; i<t; i++)
        {
            if(dec_cnt[i]>1&&inc_cnt[i]>1)
            {
                ans=ans>dec_cnt[i]+inc_cnt[i]-1?ans:dec_cnt[i]+inc_cnt[i]-1;
            }
        }
        cout<<ans<<endl;
    }
}
