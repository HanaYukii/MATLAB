function A=parse(fn)
file=fopen(fn,'r');
A=textscan(file,'%s');
B = regexprep(A{1,1},'[/]',' ') ;
adjust=' /1';
de=' ';
add='+';
minus='-';

for i=(1:size(B,1))
    if(isempty(findstr(B{i,1},de)) && isempty(findstr(B{i, 1}, add)) && isempty(findstr(B{i, 1}, minus)))
        B{i, 1}=strcat(B{i, 1},' 1');
    end
end
A=B;
