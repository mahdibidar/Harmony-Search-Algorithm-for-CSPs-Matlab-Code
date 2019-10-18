function [ SM ] = Sim( s1,s2 )
SM=0;
n=numel(s1);
for i=1:n
    if ~isequal(s1(1,i),s2(1,i))
        SM=SM+1;
    end
end

end

