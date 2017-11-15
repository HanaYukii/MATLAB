%0516316 呂爾軒
function result = main(fn)
P=parse(fn);%偶數項為operator 基數項為兩個數字 以空白隔開
A=sscanf(P{1,1},'%d');%讀第一項
ans_top=A(1);%存目前分子
ans_bot=A(2);%存目前分母
[ans_top,ans_bot]=simplify(ans_top,ans_bot);
opera='';
plus='+';
for i=(2:size(P,1))
    if (mod(i,2)==0) %讀operator
        opera=P{i,1};
    else
        A=sscanf(P{i,1},'%d'); %用sscanf讀分子分母
        top=A(1);
        bot=A(2);
        if(strcmp(opera,'+')==1) %plus
            [ans_top,ans_bot]=add(ans_top,ans_bot,top,bot);
        else %subtract
            [ans_top,ans_bot]=subtract(ans_top,ans_bot,top,bot);
        end
        [ans_top,ans_bot]=simplify(ans_top,ans_bot);
    end
end
fprintf('%d/%d\n',ans_top,ans_bot);
end

function gcd=my_gcd(num1,num2)
    if(num2==0)
        gcd=num1;
    else
        gcd=my_gcd(num2,mod(num1,num2));
    end
end

function [n1,n2]=simplify(num1,num2)
    n1=num1/my_gcd(num1,num2);
    n2=num2/my_gcd(num1,num2);
end

function [top,bot]=subtract(num1_top,num1_bot,num2_top,num2_bot)
    g=my_gcd(num1_bot,num2_bot);
    bot=num1_bot*num2_bot/g;
    top=num1_top*num2_bot/g-num2_top*num1_bot/g;
end

function [top,bot]=add(num1_top,num1_bot,num2_top,num2_bot)
    g=my_gcd(num1_bot,num2_bot);
    bot=num1_bot*num2_bot/g;
    top=num1_top*num2_bot/g+num2_top*num1_bot/g;
end

function A=parse(fn)
    file=fopen(fn,'r');
    A=textscan(file,'%s');
    B = regexprep(A{1,1},'[/]',' ') ;%把/替換成空白
    de=' ';
    add='+';
    minus='-';

    for i=(1:size(B,1))
        if(isempty(findstr(B{i,1},de)) && isempty(findstr(B{i, 1}, add)) && isempty(findstr(B{i, 1}, minus))) %沒+沒-沒空格 即為沒分母的整數 在後面加空格和1
            B{i, 1}=strcat(B{i, 1},' 1');
        end
    end
    A=B;
 end

