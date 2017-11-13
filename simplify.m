function [n1,n2]=simplify(num1,num2)
n1=num1/my_gcd(num1,num2);
n2=num2/my_gcd(num1,num2);