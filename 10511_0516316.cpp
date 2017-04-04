#include<iostream>
using namespace std;

int main()
{
    int num,i;
    while(cin>>num&&num!=0)
    {
        int f[num+1]= {0},g[num+1]= {0},h[num+1]= {0},check[num+1]= {0},flag=0,cnt=0,m=1;

        for(i=1;i<=num;i++)
        {
            int add;
            cin>>add;
            if(add<=num&&flag==0)
            {
                if(check[add]==0)
                {
                    check[add]=m;
                    m++;
                    f[i]=add;
                    g[i]=check[add];
                    h[cnt]=add;
                    cnt++;
                }
                else
                {
                    f[i]=add;
                    g[i]=check[add];
                }
            }
        }
        for(i=0;i<cnt;i++)
        {
            if(h[i]!=f[h[i]])
            {
                flag=1;
            }
        }
        cout<<(flag==1?"no":"yes")<<endl;
    }
}
