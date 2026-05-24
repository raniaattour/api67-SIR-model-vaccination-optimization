//PROJET N°2 - KHOULA Asma et ATTOUR Rania

//3 Optimisation de la vaccination pour tout t

//données du problème
T = 12;
alpha = 0.0025;
beta = 0.111;
S0 = 800;
I0 = 10;
R0 = 0; 
c = 1; // coût de la vaccination
N = 1000; 
h = T / N;

//modèle SIR avec u fo,nction de t 
function dydt=sir_vaccination(t, y, u)
    S = y(1);
    I = y(2);
    dSdt = -alpha * S * I - u * S;
    dIdt = alpha * S * I - beta * I;
    dydt = [dSdt; dIdt];
endfunction

function [J,DJ,X] = cost(u,flag)
    X = zeros(2, N+1);
    X(:,1) = y0;
    J = 0
    for i = 1:N
        X(:, i+1) = X(:, i) + h * sir_vaccination(t(i), X(:, i), u(i));
        J = J + c * h * u(i)^2;
    end
    
    S = X(1, :);
    I = X(2, :);
    J = J +I($); //I(T)

    lambda = zeros(2, N);
    lambda(:, N-1) = [0; -1];
    
    for i = N-1:-1:2
        Ai = [-alpha * I(i) - u(i), -alpha * S(i); alpha * I(i), alpha * S(i) - beta];

        lambda(:, i-1) = lambda(:, i) + h * (Ai' * lambda(:, i));
    end
    
    //maintenant on peut calculer le gradient en utilisant l'état adjoint lambda
    DJ = zeros(1, N);
    for i = 1:N
        DJ(i) = 2 * h * c * u(i) - lambda(:, i)' * h * [-S(i); 0];
    end 

endfunction

//initialisations
t = linspace(0, T, N);
y0 = [S0; I0];
u = ones(1,N) * 0.5; //initialisation du vecteur u

//résolution
problem = struct();
problem.f = cost;
problem.x0 = u;
problem.x_upper=ones(N, 1)*0.9;
problem.tol = 1e-4;
uopt = ipopt(problem);

//représentation
clf;
uopt = ipopt(problem);
plot(t, uopt);
