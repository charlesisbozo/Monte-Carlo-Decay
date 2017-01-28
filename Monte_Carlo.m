%% Initialization
N = 1000;                             %Number of atoms
TimeStep = 10;                       %Timestep in years
RunTime = 500000;                     %Total runtime in years
RunSteps = ceil(RunTime/TimeStep);    %How many steps

State = ones(N,1);                             %Initialization of the state vector
Record = zeros(RunSteps,5);
Lambda = log(2)./[250000;80000;1620;0.4/365];  %Calculating the decay constants
Threashold = 1-exp(-Lambda*TimeStep);          %Threashold for decay

%% Main Program
fprintf(['Total Years:  ',num2str(RunTime,'%08.f'),'\n','Current Year: ','000000000'])
for LoopIndex = 1:RunSteps
    fprintf(sprintf('\b\b\b\b\b\b\b\b\b%08.f\n',LoopIndex*TimeStep))
    RandomVector = rand(N,1);
    State = sort(State + RandomVector,N,Threashold);
    Record(LoopIndex,:) = [sum(State==1),sum(State==2),sum(State==3),sum(State==4),sum(State==5)];
    %plot(Record)
    pause(0.000001)
end
plot(Record)
legend('U-234','Th-230','Ra-226','Rn-222','Pb-206')

%% Each Decay Step
function State = sort(UnsortedVector,n,Threashold) 
    State = zeros(n,1);
    for LoopIndex = 1:n
        if     UnsortedVector(LoopIndex) > 5 - Threashold(4)
            State(LoopIndex) = 5;
        elseif UnsortedVector(LoopIndex) > 4 - Threashold(3)
            State(LoopIndex) = 4;
        elseif UnsortedVector(LoopIndex) > 3 - Threashold(2)
            State(LoopIndex) = 3;
        elseif UnsortedVector(LoopIndex) > 2 - Threashold(1)
            State(LoopIndex) = 2;
        else
            State(LoopIndex) = floor(UnsortedVector(LoopIndex));
        end
    end
end