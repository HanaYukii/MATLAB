function gcd=my_gcd(num1,num2)
if(num2==0)
    gcd=num1;
else
    gcd=my_gcd(num2,mod(num1,num2));
end