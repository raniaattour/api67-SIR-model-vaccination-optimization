//TD3 SUITE

//Vérification du gradient

exec('ressort.sce', -1);

u = rand(1, N);
tic
[J, DJ, X] = cost(u, 0);
d = zeros(1, N);

for i = 1:N
    u(i) = u(i) + 1e-6;
    [J1, DJ_temp, X_temp] = cost(u, 0); // Capturer J1 correctement avec les sorties nécessaires
    d(i) = (J1 - J) / 1e-6;
    u(i) = u(i) - 1e-6;
end


//à noter : au lieu d'avoir un facteur 2 on a un facteur n donc plus on fait de discrétisations moins c'est coûteux

//Number of Iterations....: 22
