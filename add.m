function [top,bot]=add(num1_top,num1_bot,num2_top,num2_bot)
g=my_gcd(num1_bot,num2_bot);
bot=num1_bot*num2_bot/g;
top=num1_top*num2_bot/g+num2_top*num1_bot/g;
