function [f, g]=J(x, flag)
    //x(1) deltaH
    //x(2) deltaS
    ex =exp(x(1)./(R*T)+x(2)/R)
    e = ex - P;
    f = sum(e.^2);
    g = 2*[sum(ex.*e/R./T);sum(ex.*e/R)];
endfunction

R = 8.314;
Z = -273.15;
P = [3.51 9.64 22.95 47.21];
T = Z+[-4.75 19.93 49.88 80.04]

//à tester :
//J([1 1])
//(J([1;1+1e-6]) - J([1;1]))/ 1e-6

problem=struct();
problem.f=J;
problem.x0=[1;1];
x = ipopt(problem);
