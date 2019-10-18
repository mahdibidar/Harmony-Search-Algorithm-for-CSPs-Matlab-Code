%%%% Harmony Search Algorithm for Constraint Satisfaction Problems
%Developer : Mahdi Bidar >>Phd Student of University Of Regina >>April.29.2019
% Supervisor : Dr Malek Mouhoub

%Time: running time of solving the problem
% BestSolution:is the best solution firefly algorithm discovered
%Nviolent:number of violented constraint
tic;
clc;

%% Problem Definition
flag=0;
nVar=100;             % Number of Deciison Variables
nc=0;
VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=1;         % Decision Variables Lower Bound
VarMax=Domain;         % Decision Variables Upper Bound

%% Harmony Search Parameters

MaxIt=100;     % Maximum Number of Iterations

HMS=20;         % Harmony Memory Size

nNew=20;        % Number of New Harmonies

HMCR=0.90;       % Harmony Memory Consideration Rate

PAR=0.90;        % Pitch Adjustment Rate

FW=0.00001*(VarMax-VarMin);    % Fret Width (Bandwidth)

FW_damp=0.995;              % Fret Width Damp Ratio
NCC=0;
icn=0;
%% Initialization

% Empty Harmony Structure
empty_harmony.Position=[];
empty_harmony.Cost=[];

% Initialize Harmony Memory
HM=repmat(empty_harmony,HMS,1);

% Create Initial Harmonies
for i=1:HMS
    HM(i).Position=randi([0 Domain],1,nVar);
    [HM(i).Cost,NCC]=Fitness( HM(i).Position,var,NT,NC,NCC);
end

% Sort Harmony Memory
[~, SortOrder]=sort([HM.Cost]);
HM=HM(SortOrder);

% Update Best Solution Ever Found
BestSol=HM(1);
    if BestSol.Cost==0&&flag==0
        time=toc;
        flag=1;
        icn=NCC;
    end

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

%% Harmony Search Main Loop

for it=1:MaxIt
    
    % Initialize Array for New Harmonies
    NEW=repmat(empty_harmony,nNew,1);
    
    % Create New Harmonies
    for k=1:nNew
        
        % Create New Harmony Position
        NEW(k).Position=randi([1 Domain],1,nVar);
        
        for j=1:nVar
            if rand<=HMCR
                % Use Harmony Memory
                i=randi([1 HMS]);
                NEW(k).Position(j)=HM(i).Position(j);
            end
            
            % Pitch Adjustment
            if rand<=PAR
                DELTA=FW*unifrnd(0,+1);    % Uniform
               % DELTA=FW*randn();            % Gaussian (Normal) 
               if rand<0.3
                NEW(k).Position(j)=ceil(NEW(k).Position(j)+DELTA);
               end
            end
        
        end
        
        % Apply Variable Limits
         NEW(k).Position=max(NEW(k).Position,VarMin);
         NEW(k).Position=min(NEW(k).Position,VarMax);

        % Evaluation
        [NEW(k).Cost,NCC]=Fitness( NEW(k).Position,var,NT,NC,NCC);
        
    end
    
    % Merge Harmony Memory and New Harmonies
    HM=[HM
        NEW]; %#ok
    
    % Sort Harmony Memory
    [~, SortOrder]=sort([HM.Cost]);
    HM=HM(SortOrder);
    
    % Truncate Extra Harmonies
    HM=HM(1:HMS);
    
    % Update Best Solution Ever Found
    BestSol=HM(1);
    if BestSol.Cost==0&&flag==0
        time=toc;
        flag=1;
        icn=NCC;
    end
     if BestSol.Cost==8 || BestSol.Cost==9
         DCSP=BestSol.Position;
     end
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Damp Fret Width
    FW=FW*FW_damp;
    
end

%% Results
time
icn
figure;
% plot(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
