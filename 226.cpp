#include<bits/stdc++.h>
using namespace std;
int dp[1<<27];
int w[27][27][27];

int n,t,N;

int sol(int num)
{
    int ans=-10000000;
    int i,j,k,I,J,K;
    if(dp[num]>-10000000)return dp[num];
    if(num==N-1)return 0;
    for(i=0,I=1; I<N && 0==(I&~num); i++,I<<=1);
    for(j=i+1,J=(I<<1); J<N; J<<=1,j++)
    {
        if(0==(J&~num))continue;
        for(k=j+1,K=(J<<1); K<N; K<<=1,k++)
        {
            int temp;
            if(0==(K&~num))continue;
            temp=w[i][i][i]+w[j][j][j]+w[k][k][k]+w[i][j][k]+w[i][j][3*n]+w[i][k][3*n]+w[j][k][3*n]+sol(num|I|J|K);
            if(temp>ans)
            {
                ans=temp;
            }
        }
    }
    return dp[num]=ans;
}
void solve()
{
    int i;
    scanf("%d %d",&n,&t);
    N=(1<<(n*3));
    for(i=0; i<N; i++)
        dp[i]=-10000000;
    for(i=0; i<n*3; i++)
        scanf("%d",&w[i][i][i]);

    int cp;
    for(i=0; i<t; i++)
    {
        int type;
        scanf("%d",&type);

        if(type==3)
        {
            int n3[3];
            scanf("%d %d %d %d",&n3[0],&n3[1],&n3[2],&cp);
            sort(n3,n3+3);
            w[n3[0]][n3[1]][n3[2]]+=cp;

        }
        else
        {
            int n3[2];
            scanf("%d %d %d",&n3[0],&n3[1],&cp);
            sort(n3,n3+2);
            w[n3[0]][n3[1]][n*3]+=cp;
        }
    }
    printf("%d\n",sol(0));

}

int main()
{
    solve();
    return 0;
}
