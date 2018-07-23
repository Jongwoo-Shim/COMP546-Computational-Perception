function I = makeImageSquare(N);
    I = .5*ones(N, N, 3);
%    
    for j = 1:3
        I(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   j) =  .99*ones(N/2,N/2) ; 
    end