#include<iostream>
#include<stack>
#include<cstdio>
#include<cstring>
#define mod 1000000007
using namespace std;



int main()
{
    char inp[2200];
    while(scanf("%s",inp)==1)
    {
        stack<char> op;
        stack<long long> number;
        int i;
        long long a,b;
        op.push('(');
        for(i=0; i<strlen(inp); i++)
        {
            if(inp[i]>='0'&&inp[i]<='9')
            {
                number.push(inp[i]-'0');
            }
            else
            {
                if(inp[i]==')')
                {
                    while(op.top()!='(')
                    {
                        a=number.top();
                        number.pop();
                        b=number.top();
                        number.pop();
                        long long k;
                        if(op.top()=='*')
                        {
                            k=a*b%mod;
                        }
                        if(op.top()=='+')
                        {
                            k=(a+b)%mod;
                        }
                        op.pop();
                        number.push(k);
                    }
                    op.pop();
                }
                else
                {
                    if(inp[i]=='+')
                    {
                        while(op.top()!='(')
                        {
                            a=number.top();
                            number.pop();
                            b=number.top();
                            number.pop();
                            long long k;
                            if(op.top()=='*')
                            {
                                k=a*b%mod;
                            }
                            if(op.top()=='+')
                            {
                                k=(a+b)%mod;
                            }
                            op.pop();
                            number.push(k);
                        }
                    }
                    op.push(inp[i]);
                }
            }
        }
        while(op.top()!='(')
        {
            a=number.top();
            number.pop();
            b=number.top();
            number.pop();
            long long k;
            if(op.top()=='*')
            {
                k=a*b%mod;
            }
            if(op.top()=='+')
            {
                k=(a+b)%mod;
            }
            op.pop();
            number.push(k);
        }
        printf("%lld\n",number.top());

    }
}

