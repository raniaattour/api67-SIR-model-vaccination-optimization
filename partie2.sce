//PROJET N°2 - KHOULA Asma et ATTOUR Rania

//2 Optimisation d’un taux de vaccination constant dans le temps

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

//modèle SIR avec u constante 
function dydt=sir_vaccination_const(t, y, u)
    S = y(1);
    I = y(2);
    R = y(3);
    dSdt = -alpha * S * I - u * S;
    dIdt = alpha * S * I - beta * I;
    dRdt = beta * I + u * S;
    dydt = [dSdt; dIdt; dRdt];
endfunction

//recherche de u minimisant J(u)
function [J,DJ] = cost_const(u,flag)
    
    [t, y, info] = cvode(sir_vaccination_const, t, y0, sensPar = u);
    
    // extraction des sensibilités
    dS_du = info.s(1, :, :); 
    dI_du = info.s(2, :, :);
    dR_du = info.s(3, :, :);
    
    J = c * T * u^2 + y(2, $); 
        
    DJ = 2 * u * c * T + dI_du($);
    
endfunction

//initialisations 
t = linspace(0, T, N+1);
y0 = [S0; I0; R0];
u = 0.5; // consantante à définir

//résolution
problem = struct();
problem.f = cost_const;
problem.x0 = u;
problem.x_upper = 0.9;
problem.tol = 1e-4;

//représentation
clf;
uopt = ipopt(problem);
plot(t, uopt);

