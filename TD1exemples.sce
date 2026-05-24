
// 1 Equations différentielles

// 1.1 Equations simples


//Question 1 :

function dydt = f(t, y)
    dydt = -y;
endfunction

//tspan = [0, 10]
//tspan = [0, 5, 10]
tspan = 0:0.1:10

y0 = 1;

//[t, y, info] = arkode(f, tspan, y0)
sol = arkode(f, tspan, y0) // se comporte comme un interpolateur (comme une fonction)

clf
//plot(t,y)


//Question 2 :

function dXdt = g(t, X)
    x =  X(1);
    y =  X(2);
    dXdt = [-y; x];
endfunction

tspan = [0 2*%pi]

X0 = [1; 0];

[t, X, info] = arkode(g, tspan, X0)
//sol = arkode(f, tspan, y0) // se comporte comme un interpolateur (comme une fonction)

clf
//plot(t, X); //ressemble à cos et sin
//plot(X(1, :),X(2, :));
isoview on 



//Question 3 :

// données : 
g = 9.81;
L = 1; //longueur du pendule en mètres
    
function dtXdt = pendul(t, X) 
    theta = X(1);
    omega = X(2);
    dtXdt =  [omega; -g/L * sin(theta)]; 
endfunction

function [eq, term, dir] = h(t, X)
    term = 0;
    dir = 1;
    eq = X(1)-X0(1);
endfunction


tspan = [0 10]

X0 = [3*%pi/4; 0];

[t, X, info] = cvode(pendul, tspan, X0, events = h) // events = h : il faut dire au solveur qu'il y a un évènement préciser par la fonction h 

clf
//plot(X(1, :),X(2, :));
plot(t, X);

//info.te pour avoir la val de variable de temps où s'est passé l'évènement
