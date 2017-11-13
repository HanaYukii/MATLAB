function A=mylab7(fn,sort_mode)
    file=fopen(fn,'r');
    A=textscan(file,'%s');
    B = regexprep(A{1,1},'[^A-Za-z ]','') ; 
    C = regexprep(B,'(^|\.)\s*.','${lower($0)}') ; 
    D=C;
    for i=1:size(D,1)-1
        for j=i+1:size(D,1)
            if strcmp(D(i),D(j))
                D(j) = regexprep(D(j) , '[a-zA-Z_0-9]' , '') ;
            end
        end
    end
    index = cellfun('length' , D) ;
    D(index==0)=[];
    for i=1:size(D,1)
        E(i)=0;
        for j=1:size(C,1)
            if strcmp(D(i),C(j))
                E(i)=E(i)+1;
            end
        end
    end
    word=D;
    count=E;
    for i = 1 : length(word)
            len(i) =  size(word{i},2);
    end
    for i = 1 : length(word)
        F(i)=struct('word',{word{i}},'len',{len(i)},'count',{count(i)});
        if strcmp(sort_mode,'word')
            [~,k] = sort({F.word});
            A = F(k);
        elseif strcmp(sort_mode,'len')
            [~,k] = sort([F.len]);
            A = F(k);
        elseif strcmp(sort_mode,'count')
            [~,k] = sort([F.count]);
            A = F(k);
        elseif strcmp(sort_mode,'none')
            A = F;
        end
    end
    if nargout==0
        for i = 1 : length(word)
            fprintf('%-15s%d    %d\n',A(i).word,A(i).count,A(i).len)
        end
    end
    
   
end