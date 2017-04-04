#include<list>
#include<iostream>
#include <algorithm>
using namespace std;
int main()
{
    int times;
    while(cin>>times)
    {
        while(times--)
        {
            int first,num;
            cin>>first>>num;
            list<int> number;
            for(int i=0; i<num; i++)
            {
                int add;
                cin>>add;
                number.push_back(add);
            }
            int po=first;
            list<int>::iterator it;
            it=number.begin();
            advance(it,first-1);
            while(number.size()!=1)
            {
                int k=*it;
                po+=k;
                if(po>number.size())
                    po-=number.size();
                number.erase(it);
                advance(it,k-1);

            }
            it=number.begin();
            cout<<number.size()<<endl;
            for (it = number.begin(); it != number.end(); it++)
            {
                cout<<*it<<endl;
            }
        }
    }
}
