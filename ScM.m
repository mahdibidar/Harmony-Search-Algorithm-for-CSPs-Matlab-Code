function [s] = ScM(s)
ss=s;
n=numel(s);
nn=floor(n/2);
n1=randi([1,nn],1,1);
n2=randi([nn+1,n],1,1);
m=n2-n1+1;
c=1;
for i=n1:n2
    q1(c)=s(i);
    c=c+1;
end
q2=randperm(m);
c=n1;
for i=1:m
    s(c)=q1(q2(i));
    c=c+1;
end
end

