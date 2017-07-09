#include<bits/stdc++.h>
using namespace std;
const int maxn = 100005;

int num, nth;
int a[maxn];
int sum[maxn + 1];
int s[maxn + 1];
int t[maxn + 1];
long long merge_sort(int low,int high,int det)
{
    if(low>=high)
        return 0;
    long long cnt=0;
    int m=(low+high)/2;
    cnt+=merge_sort(low,m,det);
    cnt+=merge_sort(m+1,high,det);
    int pos=m+1;
    for(int i=low;i<=m;i++)
    {
        while(pos<=high&&s[pos]-s[i]<det)
            pos++;
        cnt+=high-pos+1;
    }
    int idx = low, i = low, j = m + 1;
    while (i <= m && j <= high) {
        if (s[i] < s[j]) t[idx++] = s[i++];
        else t[idx++] = s[j++];
    }
    while (i <= m) t[idx++] = s[i++];
    while (j <= high) t[idx++] = s[j++];
    memcpy(s + low, t + low, sizeof(int) * (high - low + 1));
    return cnt;

}

int main()
{
    cin.tie(0);
    ios_base::sync_with_stdio(0);
    int times;
    cin>>times;
    while(times--)
    {
        cin>>num>>nth;
        sum[0]=0;
        int add;
        for(int i=0;i<num;i++)
        {
            cin>>add;
            sum[i+1]=sum[i]+add;
        }
        memcpy(s,sum,sizeof(sum));
        long long h=merge_sort(0,num,nth+1);
        memcpy(s,sum,sizeof(sum));
        long long l=merge_sort(0,num,-nth);
        cout<<l-h<<endl;
    }
}
