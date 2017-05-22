num=[1]
for _ in range (10000):
    num.append(0)
    
for i in range(1,10001):
     for j in range(i,10001):
            num[j] += num[j - i]

while 1:
    try:
        n=int(input())
        print(num[n])
    except EOFError:
        break
