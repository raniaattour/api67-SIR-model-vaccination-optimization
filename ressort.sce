//TD3

//données du problème
k = 1;
m = 2;
X0 = [1;1];
T = 5;
h = 0.01;
t = 0:h:T;
N = T/h;
A = [0 1; -k/m 0];
B = [0 ; 1/m];
Q = diag([2 1]);
r = 0.1;
u = zeros(1,N);
    
    function [J,DJ,X] = cost(u,flag)
    X = zeros(2, N+1);
    X(:,1) = X0;
    J = 0;
    for k = 1:N
        J = J + 0.5 * h * (X(:, k)' * Q * X(:, k) + r * u(k)^2);
        X(:, k+1) = X(:, k) + h * (A * X(:, k) + B * u(k));
    end
    
    //question 3 :
    lambda = zeros(2, N);
    //lambda(:, N) = vecteur nul MAIS ça ne sert à rien de le mettre car déjà initialisé à 0
    
    for i = N:-1:2
        lambda(:, i-1) = lambda(:, i) + h * (A' * lambda(:, i) - Q * X(:, i));
    end
    
    //maintenant on peut calculer le gradient en utilisant l'état adjoint lambda
    DJ = h * (r * u' - B' * lambda);
endfunction

//pour tester :
//u(1)= u(1) + 1e-6
//[J, DJ]=cost(u)
//(J1-J)/1e-6
//DJ(1)

problem = struct();
problem.f = cost;
problem.x0 = u;

uopt = ipopt(problem);

[J,DJ,X] = cost(uopt,0);

clf;
plot(t, X);
