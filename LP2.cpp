#include <iostream>
#include "lp_solver.h"
using namespace std;

int main()
{
    int n,m;
    cin>>n>>m;

    int arr[n][m];
    for(int i=0; i<n; i++)
        for(int j=0; j<m; j++)
            cin>>arr[i][j];


    vector<vector<double> > A;
    A.resize(n*m+n+m+n+m);
    for(int i=0; i<n*m+n+m+n+m; ++i)
    {
        A[i].resize(m+n);
        for(int j=0; j<m+n; j++)
            A[i][j]=0;
    }
    for(int i=0; i<n*m; i++)
    {
        A[i][i/m]=-1;
    }
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<m; j++)
        {
            A[i*m+j][n+j]=-1;
        }
    }
    for(int i=n*m; i<n*m+n+m; i++)
    {
        A[i][i-n*m]=-1;
    }
    for(int i=n*m+n+m; i<n*m+n+m+n+m; i++)
    {
        A[i][i-n*m-n-m]=1;
    }
    vector<double> y;
    y.resize(n+m);
    vector<double> b;
    b.resize(n*m+n+m+n+m);
    for(int i=0; i<n; i++)
    {
        for(int j=0; j<m; j++)
        {
            b[i*m+j]=arr[i][j]*-1;
        }
    }
    for(int i=n*m; i<n*m+n+m; i++)
        b[i]=-1;
    for(int i=n*m+n+m; i<n*m+n+m+n+m; i++)
        b[i]=6;
    vector<double> c;
    c.resize(n+m);
    for(int i=0; i<n+m; i++)
        c[i]=-1;
    int z = lp_solver(GLP_MAX, c, A, y, b);
    cout << -z << endl;
}
