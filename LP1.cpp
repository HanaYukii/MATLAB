#include <iostream>
#include <vector>
#include "lp_solver.h"
using namespace std;

int main()
{

    vector<vector<double> > A;
    A.resize(18);
    for(int i=0; i<18; ++i)
    {
        A[i].resize(10);
    }
    for(int i=0; i<10; i++)
    {
        for(int j=0; j<18; j++)
        {
            A[j][i]=0;
        }
    }
    A[0][0] = 150, A[0][1] = 150, A[0][6] = 75, A[0][7] = 75;
    A[1][2] = 200, A[1][3] = 200, A[1][6] = 100, A[1][7] = 100, A[1][8] = 120, A[1][9] = 120;
    A[2][4] = 150, A[2][5] = 150, A[2][8] = 80,  A[2][9] = 80;
    A[3][0] = 1,A[4][2] = 1,A[5][4] = 1,A[6][6] = 1,A[7][8] = 1;
    for(int i=0; i<10; i++)
    {
        A[8+i][i]=-1;
    }
    vector<double> y;
    y.resize(10);

    vector<double> b;
    b.resize(18);
    for(int i=0; i<18; i++)
    {
        b[i]=0;
    }
    for(int i=0; i<8; i++)
    {
        cin>>b[i];
    }

    vector<double> c;
    c.resize(10);
    for(int i=0; i<10; i++)
    {
        cin>>c[i];
    }

    double z = lp_solver(GLP_MAX, c, A, y, b);

    cout << z << endl;
    for(int i=0; i<5; ++i)
    {
        cout << y[i*2]+y[i*2+1] << ' ';
    }
    cout << endl;
    return 0;
}
