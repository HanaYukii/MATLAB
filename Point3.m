classdef Point3
    properties
        x=0;
        y=0;
        z=0;
    end
    methods
        function obj = Point3(arr1,arr2,arr3)
            if nargin == 0
                obj.x=0 ;
                obj.y=0;
                obj.z=0;
            else
                obj(1:(numel(arr1))) = Point3() ;
                for ii = 1 : numel(arr1)
                    obj(ii).x= arr1(ii);
                    obj(ii).y= arr2(ii);
                    obj(ii).z= arr3(ii); 
                end
                obj = reshape(obj, size(arr1));
            end
        end
        function obj = plus(arr1, arr2)
            if size(arr1)~=size(arr2)
            for ii=1:numel(arr1)
                obj(ii)=Point3();
                obj(ii).x=arr1(ii).x+arr2.x;
                obj(ii).y=arr1(ii).y+arr2.y;
                obj(ii).z=arr1(ii).z+arr2.z;
            end
            obj=reshape(obj,size(arr1));
            else
            for ii=1:numel(arr1)
                obj(ii)=Point3();
                obj(ii).x=arr1(ii).x+arr2(ii).x;
                obj(ii).y=arr1(ii).y+arr2(ii).y;
                obj(ii).z=arr1(ii).z+arr2(ii).z;
            obj=reshape(obj,size(arr1));
            end
            end
        end
        function obj = minus(arr1, arr2)
            if size(arr1)~=size(arr2)
            for ii=1:numel(arr1)
                obj(ii)=Point3();
                obj(ii).x=arr1(ii).x-arr2.x;
                obj(ii).y=arr1(ii).y-arr2.y;
                obj(ii).z=arr1(ii).z-arr2.z;
            end
            obj=reshape(obj,size(arr1));
            else
            for ii=1:numel(arr1)
                obj(ii)=Point3();
                obj(ii).x=arr1(ii).x-arr2(ii).x;
                obj(ii).y=arr1(ii).y-arr2(ii).y;
                obj(ii).z=arr1(ii).z-arr2(ii).z;
            obj=reshape(obj,size(arr1));
            end
            end
        end
        function disp(num) 
                 for ii = 1 : size(num,1)
                      for jj = 1 : size(num,2)
                             fprintf(' (%d,%d,%d) ',num(ii,jj).x,num(ii,jj).y,num(ii,jj).z);
                      end
                      fprintf('\n');
                 end
        end
        function obj = eq(arr1, arr2)
            ans=zeros(size(arr1))
            if size(arr1)~=size(arr2)
            for ii=1:numel(arr1)
                if(arr1(ii).x==arr2.x && arr1(ii).y==arr2.y && arr1(ii).z==arr2.z)
                    ans(ii)=1;
                end
            end
            else
                for ii=1:numel(arr1)
                    if(arr1(ii).x==arr2(ii).x && arr1(ii).y==arr2(ii).y && arr1(ii).z==arr2(ii).z)
                        ans(ii)=1;
                    end
                end
            end
            obj=ans;
        end
        function obj = sum(arr1)
            ans=zeros(size(arr1,1));
            for ii = numel(size(arr1))
                
        end
    end
end