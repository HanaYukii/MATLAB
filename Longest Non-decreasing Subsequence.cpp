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
    int num;
    scanf("%d",&num);
    vector<int> v;
    for(int i=0;i<num;i++)
    {
        int add;
        scanf("%d",&add);
        v.push_back(add);
    }
    int ans=LIS(v);

    cout<<ans<<endl;
}
