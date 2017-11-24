#include<bits/stdc++.h>
using namespace std;

int LIS(vector<int> &v)
{
    vector <int> ve;
    ve.push_back(v[0]);
    for(int i=1;i<v.size();i++)
    {
        if(v[i]>ve.back())
            ve.push_back(v[i]);
        else
            *lower_bound(ve.begin(),ve.end(),v[i])=v[i];
    }
    return ve.size();
}
int main()
{
    int m,n;
    cin>>m>>n;
    int cont[m+1]={0};
    for(int i=1; i<=m; i++)
    {
        int add;
        cin>>add;
        cont[add]=i;
    }
    for(int i=0; i<n; i++)
    {
        vector<int> ans;
        for(int i=1; i<=m; i++)
        {
            int add;
            cin>>add;
            ans.push_back(cont[add]);
        }
        cout<<LIS(ans)<<endl;
    }

}
