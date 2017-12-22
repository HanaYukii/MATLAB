classdef BigInt
    properties
        digits='0';
    end
    methods
        function obj = BigInt(num)
            if nargin == 0
                obj.digits = '0' ;
            elseif nargin == 1 && ischar(num)
                obj.digits = num ;
                
            elseif nargin == 1 && isscalar(num) && ~iscell(num)
                obj.digits = num2str(num) ;
                
            elseif nargin == 1 && iscell(num)
                for ii = 1 : numel(num)
                    obj(ii)= BigInt(num{ii}) ;
                end
                obj = reshape(obj, size(num));
                
            else
                obj(1:numel(num)) = BigInt() ;
                for ii = 1 : numel(num)
                    obj(ii)= BigInt(num(ii)) ;
                end
                obj = reshape(obj, size(num));
            end
        end
        function obj = plus(str1, str2)
            if ~isa(str1, 'BigInt')
                str1 = BigInt(str1) ;
            elseif ~isa(str2, 'BigInt')
                str2 = BigInt(str2) ;
            end
            
            if size(str1) == size(str2)
                for ii = 1 : numel(str1)
                    n = max( length(str1(ii).digits), length(str2(ii).digits) ) + 1 ;
                    num1 = [zeros(1,n-length(str1(ii).digits)) str1(ii).digits-'0'] ;
                    num2 = [zeros(1,n-length(str2(ii).digits)) str2(ii).digits-'0'] ;
                    num1 = num1 + num2 ;
                    k = find(num1 >= 10) ;
                    while ~isempty(k)
                        num1(k) = num1(k) - 10 ;
                        num1(k-1) = num1(k-1) + 1 ;
                        k = find(num1 >= 10) ;
                    end
                    num1 = num1(find(num1>0 , 1, 'first') : end) ;
                    num1 = char(num1 +'0') ;
                    obj(ii) = BigInt(num1) ;
                end
                obj = reshape(obj, size(str1));
                
            elseif size(str1) == [1, 1]
                for ii = 1 : numel(str2)
                    n = max( length(str1.digits), length(str2(ii).digits) ) + 1 ;
                    num1 = [zeros(1,n-length(str1.digits)) str1.digits-'0'] ;
                    num2 = [zeros(1,n-length(str2(ii).digits)) str2(ii).digits-'0'] ;
                    num1 = num1 + num2 ;
                    k = find(num1 >= 10) ;
                    while ~isempty(k)
                        num1(k) = num1(k) - 10 ;
                        num1(k-1) = num1(k-1) + 1 ;
                        k = find(num1 >= 10) ;
                    end
                    num1 = num1(find(num1>0 , 1, 'first') : end) ;
                    num1 = char(num1 +'0') ;
                    obj(ii) = BigInt(num1) ;
                end
                obj = reshape(obj, size(str2));
                
                elseif size(str2) == [1, 1]
                for ii = 1 : numel(str1)
                    n = max( length(str1(ii).digits), length(str2.digits) ) + 1 ;
                    num1 = [zeros(1,n-length(str1(ii).digits)) str1(ii).digits-'0'] ;
                    num2 = [zeros(1,n-length(str2.digits)) str2.digits-'0'] ;
                    num1 = num1 + num2 ;
                    k = find(num1 >= 10) ;
                    while ~isempty(k)
                        num1(k) = num1(k) - 10 ;
                        num1(k-1) = num1(k-1) + 1 ;
                        k = find(num1 >= 10) ;
                    end
                    num1 = num1(find(num1>0 , 1, 'first') : end) ;
                    num1 = char(num1 +'0') ;
                    obj(ii) = BigInt(num1) ;
                end
                obj = reshape(obj, size(str1));
            end
        end
        function obj = times(str1, str2)
            if ~isa(str2, 'BigInt')
                str2 = BigInt(str2);
            end
            if size(str1) == size(str2)
                for ii = 1 : numel(str1)
                str1(ii).digits = str1(ii).digits - '0' ;
                str2(ii).digits = str2(ii).digits - '0' ;
                num1 = conv(str1(ii).digits, str2(ii).digits) ;
                num1=[0 num1]; 
                k = find(num1 >= 10) ;
                while ~isempty(k)
                        num1(k) = num1(k) - 10 ;
                        num1(k-1) = num1(k-1) + 1 ;
                        k = find(num1 >= 10) ;
                    end
                    num1 = num1(find(num1>0 , 1, 'first') : end) ;
                    num1 = char(num1 +'0') ;
                obj(ii) = BigInt(num1) ;
                end
               obj = reshape(obj, size(str1)) ;
            else
                error ('Matrix size does not equal.') ;
            end
        end
        function obj = eq(str1, str2)
            if numel(str2)==1
                str2=repmat(str2,size(str1,1),size(str1,2));
            end
            if ~isa(str1, 'BigInt')
                str1 = BigInt(str1) ;
            elseif ~isa(str2, 'BigInt')
                str2 = BigInt(str2) ;
            end
            ans=zeros(size(str1));  
                for ii = 1 : numel(str1)
                       if strcmp(str1(ii).digits, str2(ii).digits)
                           ans(ii)=1;
                       end
                end
            obj = reshape(ans, size(str2));
        end
        function obj= make_str(str)
            obj=BigInt(str);
        end
        function disp(num) 
            N=ndims(num);
            P=cell(1,N);
                 for ii = 1 : numel(num)
                        fprintf('(');
                        [P{:}]=ind2sub(size(num),ii);
                        for jj=1:N
                             fprintf('%d',P{jj});
                             if jj~=N
                                fprintf(',',P{jj});
                             end
                        end
                        fprintf(')    ');
                        fprintf('%s\n',num(ii).digits);
            end
        end
    end
end
