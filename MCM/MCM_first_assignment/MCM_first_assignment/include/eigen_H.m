function [h] = eigen_H(R)
    [eigVec, eigVal] = eig(R);
    D = diag(eigVal);
    ind = -1;
    for i = 1:length(D)
        if(abs(D(i) - 1) < 10^-3)
            ind = i;
        end
    end
    h = eigVec(:,ind);
    h = h/norm(h);

    %corretto segno di h
    %eig(R) può ritornare sia l' autovettore positivo che negativo: 
    % Rh = h ma anche R(-h) = -h con entrambi autovalore 1.
    %Per convenzione eig ritorna sempre h quindi, per tenere la conveznione
    %di rotazione positiva usata in RotToAngleAxis dobbiamo tenere conto
    %delle direzione nel vettore h
    
    %calcolo l'h con RotToAngleAxis supponendo una rotazione positiva
    [h_rod, ~] = RotToAngleAxis(R);

    %confronto per capire l'orientamento corretto di h
    if dot(h, h_rod) < 0
        h = -h;
    end
    
end