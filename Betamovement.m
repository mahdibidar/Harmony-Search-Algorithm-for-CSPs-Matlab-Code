function [s3] = Betamovement( s1,s2,beta )
n=numel(s1);
s3=s1;
for i=1:n
    if ~(isequal(s1(1,i),s2(1,i)))
        b=rand();
        if b>beta
            s3(1,i)=s2(1,i);
        end
    end
end
end

