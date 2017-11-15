function [word, count] = my_word_count(fn)
    data = textread(fn,'%s');
    data = lower(data);
    data = regexprep(data, '[.,]','');
    data1 = unique(data , 'stable');
    data1 = string(data1);
    for i = 1 : size(data1)
        x = strcmp(data1(i),data);
        A(i) = sum(x);
        fprintf('%-15s%d\n', data1(i), A(i));
    end
end
