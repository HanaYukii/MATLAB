P=parse('format.txt');
A=sscanf(P{1,1},'%d');
ans_top=A(1);
ans_bot=A(2);
[ans_top,ans_bot]=simplify(ans_top,ans_bot);
opera='';
plus='+';
for i=(2:size(P,1))
    if (mod(i,2)==0)
        opera=P{i,1};
    else
        A=sscanf(P{i,1},'%d');
        top=A(1);
        bot=A(2);
        if(strcmp(opera,'+')==1)
            [ans_top,ans_bot]=add(ans_top,ans_bot,top,bot);
        else
            [ans_top,ans_bot]=subtract(ans_top,ans_bot,top,bot);
        end
        [ans_top,ans_bot]=simplify(ans_top,ans_bot);
    end
end
fprintf('%d/%d',ans_top,ans_bot);