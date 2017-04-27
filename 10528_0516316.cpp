#include<bits/stdc++.h>
using namespace std;
int main()
{
    int times;
    cin>>times;
    while(times--)
    {
        int num;
        cin>>num;
        int flag=0,flag2=0;
        int ct=0,cv=0;
        unsigned long long sum=1;
        unsigned long long add;
        for(int i=0;i<num;i++)
        {
            scanf("%llu",&add);
            if(add==0)
            {
                flag2=1;
            }
            if(flag2)
                continue;
            sum*=add;
            if(sum>=10000)
                flag=1;
            if(flag)
            {
                while(sum%5==0)
                {
                    sum/=5;
                    cv++;
                }
                while(sum%2==0)
                {
                    sum/=2;
                    ct++;
                }
                sum%=10000;
            }

        }

        if(ct>cv)
        {

            ct-=cv;
            cv=0;

            while(ct--)
            {
                sum*=2;
                sum%=10000;

            }

        }
        else if(cv>ct)
        {
            cv-=ct;
            ct=0;

            while(cv--)
            {
                sum*=5;
                sum%=10000;
            }
        }
        if(flag2)
           printf("0000\n");
        else
            printf("%04d\n",sum);
    }
}
