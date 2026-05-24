//PROJET N°2 - KHOULA Asma et ATTOUR Rania

//1 Problème direct

//u(t) = 0

//données du problème
T = 12;
alpha = 0.0025;
beta = 0.111;
S0 = 800;
I0 = 10;
R0 = 0; 
c = 1; // coût de la vaccination
N = 100; 
h = T / N;

//simulation
function dydt = sir(t, y)
    S = y(1);
    I = y(2);
    R = y(3);
    dSdt = -alpha * S * I;
    dIdt = alpha * S * I - beta * I;
    dRdt = beta * I;
    dydt = [dSdt; dIdt; dRdt];
endfunction

//initialisations 
t = linspace(0, T, N+1);
y0 = [S0; I0; R0];

//résolution avec ode
y = ode(y0, 0, t, sir);

//représentation
clf;
plot(t, y(1, :)); //S(t)
plot(t, y(2, :), 'r'); //I(t)
plot(t, y(3, :), 'g'); //R(t)
legend('S(t)', 'I(t)', 'R(t)');
