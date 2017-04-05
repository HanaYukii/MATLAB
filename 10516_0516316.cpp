#include <stdio.h>
#include<stdlib.h>
int b[131073],n,s[100001];
int low_bit(int a)
{
    return (a&-a);
}
void update(int a)
{
    while(a<=n)
    {
        b[a]--;
        a+=low_bit(a);
    }
}
int sum (int k)
{
    int ans = 0;
    for (int i = k; i > 0; i -= low_bit(i))
        ans += b[i];
    return ans;
}
int bs(int num)
{
    int low=0;
    int high=n;
    int ans=0;
    while(1)
    {
        int mid=(high+low)/2;
        int k=sum(mid);
        if(k>num)
        {
            high=mid;
        }
        else if(k<num)
        {
            low=mid;
        }
        else if(k==num)
        {
            ans=mid;
            high=mid;
        }
        if(high-low<=1)
            break;
    }
    return ans;
}

int main()
{
    int times;
    scanf("%d",&times);
    while(times--)
    {
        int  k, t,i, pos, step;
        scanf("%d %d",&t,&k);
        for(n=1; n<=t; n<<=1);
        for(i=1; i<=t; i++)
            scanf("%d",&s[i]);
        for(i=1; i<=n; i++)
        {
            b[i]=low_bit(i);
            if(i>t)
            {
                b[i]-=(i-b[i])>=t?b[i]:(i-t);
            }
        }
        pos=k+1;
        step=1;

        for(;t;t--)
        {
            pos=(pos+step-1)%t;
            if(!pos)
                pos=t;
            int k=bs(pos);
            step=s[k];
            update(k);

        }

        printf("%d\n",step);
    }
    return 0;
}
