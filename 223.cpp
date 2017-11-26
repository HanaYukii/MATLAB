#include<bits/stdc++.h>
using namespace std;
int inc[100001];

int LIS(vector<int> &v)
{
    vector <int> ve;
    ve.push_back(v[0]);
    inc[0]=1;
    for(int i=1;i<v.size();i++)
    {
        if(v[i]>ve.back())
            ve.push_back(v[i]);
        else
            *lower_bound(ve.begin(),ve.end(),v[i])=v[i];
        inc[i]=lower_bound(ve.begin(),ve.end(),v[i])-ve.begin()+1;
    }
    return ve.size();
}
int main()
{
    int m,n;
    scanf("%d %d",&m,&n);
    int cont[m+1]={0};
    int cont2[m+1]={0};
    for(int i=0; i<m; i++)
    {
        int add;
        add=input();
        cont[add]=i;
    }
    for(int t=0; t<n; t++)
    {
        vector<int> ans;
        vector<int> cont2;
        ans.clear();
        for(int i=0; i<m; i++)
        {
            int add;
            add=input();
            cont2.push_back(add);
            ans.push_back(cont[add]);
        }
        int len=LIS(ans);
        int now=len;
        int output[len];
        for(int j=m-1;j>=0;j--)
        {
            if(inc[j]==now)
            {
                output[--now]=cont2[j];
            }
        }
        for(int i=0;i<len;i++)
        {
            printf("%d ",output[i]);
        }
        puts("");
    }

}
