function [ff,NCC] = Fitness( s,var,NT,NC,NCC)
ff=0;
%%%NC:Number of Constraint
for i=1:NC
    p=var{i,1};
    %%%NT: Number of tuples
    for j=2:NT+1
        NCC=NCC+1;
        if isequal(var{i,j},[s(p(1,1)) s(p(1,2))])
            ff=ff+1;
            
        end
    end
end

end

