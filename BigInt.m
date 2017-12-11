classdef BigInt
    properties
        digits='0';
    end
    methods
        function obj=BigInt(num)
            if nargin==0
                obj.digits='0';
            elseif nargin==1 &&ischar(num)
                obj.digits=num;
            elseif nargin==1 &&isscalar(num)
                obj.digits=num2str(num);
            else 
                error('Input error') ;
            end
        end
        function obj=plus(str1,str2)
            n = max( length(str1.digits), length(str2.digits) ) + 1 ;
            num1 = [zeros(1,n-length(str1.digits)) str1.digits-'0'] ;
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
            obj = BigInt(num1) ;
        end
        function obj = times(str1, str2)
             if class(str1)=='double'
                str1=BigInt(str1);
             end
                str1.digits = str1.digits - '0' ;
                str2.digits = str2.digits - '0' ;
                num1 = conv(str1.digits, str2.digits) ;
                num2 = 0 ;
                    for jj = 0 : length(num1)-1
                        num2 = num2 + num1(end - jj) * 10^(jj) ; 
                    end
                obj = BigInt( num2 ) ;
        end
        function obj = eq(str1, str2)
            if str2num(str1.digits)==str2num(str2.digits)
                obj=BigInt(1);
            else
                obj=BigInt();
            end
        end
        function obj= make_str(str)
            obj=BigInt(str);
        end
        function disp(num)
            if class(num)~='BigInt'
                num=make_str(num);
            end
            fprintf('%s\n',num.digits) ;
        end
    end
end
