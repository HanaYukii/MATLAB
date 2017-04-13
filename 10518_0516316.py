fac=[]
fac.append(1)
fac.append(1)
for _ in range (2,64):
    fac.append(fac[_-1]*_)
times=int(input())
for _ in range(1,times+1):
     [len,nth]=map(int,input().split())
     
     series=list(range(1,len+1))
     ans=[]
     nth-=1
     for k in range (1,len):
         n=(nth)//fac[len-k]
         a=series[n]
         ans.append(a)
         series.remove(a)
         nth%=fac[len-k]
     ans.append(series[0])
     print('(',end='')
     for i in range (0,len-1):
         print("%d,"%ans[i],end='')
     print('%d)'%ans[len-1],end='')
     print('')
     


