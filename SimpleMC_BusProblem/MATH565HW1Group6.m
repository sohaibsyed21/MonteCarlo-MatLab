function main
    %Question 1d).
    mean(monteCarloBuses(10^6))
    %Question 5
    [meanBusWait, out] = meanMC_CLT(@(n) monteCarloBuses(n), 1/60) %1/60 AbsTol for 1 second
end

function times = monteCarloBuses(n);
    rng(1,"twister"); %seed for consistent results
    arrival = rand(n,1)*15; %Pseudo-random arrival time in range [0,15]
    bus1 = rand(n,1)*3 - 1; %Psuedo-random bus1 time in range [-1,2]
    bus2 = rand(n,1)*3 + 14;%Pseudo-random bus2 time in range [14,17]
    bus3 = rand(n,1)*3 + 29;%Pseudo-random bus2 time in range [29,32]
    times = ((arrival-bus1<=0).*(bus1-arrival) + ... %when arrival is before bus1
        (arrival-bus1>0 & arrival-bus2<=0).*(bus2-arrival) + ... %when arrival is before bus2 and after bus1
        (arrival-bus2>0 & arrival-bus3<=0).*(bus3-arrival)); %when arrival is before bus3 and after bus2
end
