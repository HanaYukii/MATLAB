#include<stdio.h>
int ans_map[500][9][9];
int solution = 0;
void backtracking( int n, int x[], int y[], int slash1[], int slash2[] )
{
    int i;
    if( n == 10 )
    {
        solution++;
        for( i = 1 ; i <= 9 ; i++ )
        {
            ans_map[solution][x[i]][i]=1;
        }
        return;
    }
    for( i = 1 ; i <= 9 ; i++ )
    {
        if( !y[i] && !slash1[i+n] && !slash2[i-n+9] )
        {
            x[n] = i;
            y[i] = 1;
            slash1[i+n] = 1;
            slash2[i-n+9] = 1;
            backtracking( n+1, x, y, slash1, slash2 );
            x[n] = 0;
            y[i] = 0;
            slash1[i+n] = 0;
            slash2[i-n+9] = 0;
        }
    }
}

int main()
{

    int x[15] = {0}, y[15] = {0}, slash1[20] = {0}, slash2[20] = {0};
    solution = 0;
    backtracking( 1, x, y, slash1, slash2 );
    int times;
    while( scanf( "%d", &times ) != EOF )
    {
        while(times--)
        {
            int px,py;
            scanf("%d %d",&px,&py);
            int ans=0;
            for(int i=1;i<=solution;i++)
            {
                if(ans_map[i][px][py]!=0)
                    ans++;
            }
            printf("%d\n",ans);
        }
    }
    return 0;
}
