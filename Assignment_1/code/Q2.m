%   Q2.m
close all
clear

question = 'c';
N = 256;
gau1 = make2DGaussian(N, 25);
gau2 = make2DGaussian(N, 27.5);
DOG = gau1 - gau2;

switch question
    case 'a'
        for (kx = 1:100)
            Y = filter2(DOG,mk2Dcosine(256,kx,0));
            RMS_Y(kx) = rms(Y(:));
        end
        plot(1:100,RMS_Y)
        title('RMS/Spatial Frequency')
        xlabel('Spatial Frequency')
        ylabel('RMS')
        
    case 'b'
        for i = 1:50
            DOG = make2DGaussian(N,i) - make2DGaussian(N,   i*1.1);
            output = makeImageSquare(N);
            figure
            imagesc(filter2(DOG,output(:,:,1)))
            colormap(gray(N)),colorbar  
        end
    case 'c'
        for part = 1:5
            DOG_R = gau1 - gau2;
            DOG_G = gau2 - gau1;
            switch part
                case 1 
                    %Red Square, White BackGround
                    output = .99*ones(N, N, 3);
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   1) = 1; 
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   2) = 0;
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   3) = 0;
                    figure
                    imagesc(output)
                    Y_R = filter2(DOG_R,output(:,:,1));
                    Y_G = filter2(DOG_G,output(:,:,2));
                    output = (Y_R + Y_G)/2;
                case 2
                    %Red Square,Green Background
                    output(1: N, 1:N, 1) = 0;
                    output(3*N/4 + 1 : N, 3*N/4 + 1: N, 1) = 0; 
                    output(1: N, 1:N, 2) = 1;
                    output(3*N/4 + 1 : N, 3*N/4 + 1: N, 2) = 1; 
                    output(1: N, 1:N, 3) = 0;
                    output(3*N/4 + 1 : N, 3*N/4 + 1: N, 3) = 0; 

                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   1) = 1 ; 
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   2) = 0 ;
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   3) = 0 ;

                    figure
                    imagesc(output)
                    Y_R = filter2(DOG_R,output(:,:,1));
                    Y_G = filter2(DOG_G,output(:,:,2));
                    output = (Y_R + Y_G)/2;
                case 3 
                    %Green Square, White Background
                    output = .99*ones(N, N, 3);
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   1) = 0 ; 
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   2) = 1 ;
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   3) = 0 ;
                    figure
                    imagesc(output)
                    Y_R = filter2(DOG_R,output(:,:,1));
                    Y_G = filter2(DOG_G,output(:,:,2));
                    output = (Y_R + Y_G)/2;
                case 4   
                    %Green Square, Red Background
                    output(1: N, 1:N, 1) = 1;
                    output(3*N/4 + 1 : N, 3*N/4 + 1: N, 1) = 1; 
                    output(1: N, 1:N, 2) = 0;
                    output(3*N/4 + 1 : N, 3*N/4 + 1: N, 2) = 0; 
                    output(1: N, 1:N, 3) = 0;
                    output(3*N/4 + 1 : N, 3*N/4 + 1: N, 3) = 0; 

                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   1) = 0 ; 
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   2) = 1 ;
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   3) = 0 ;
                    figure
                    imagesc(output)
                    Y_R = filter2(DOG_R,output(:,:,1));
                    Y_G = filter2(DOG_G,output(:,:,2));
                    output = (Y_R + Y_G)/2;
                case 5
                    %White Square, Black Background
                    output = 0.01*ones(N, N, 3);
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   1) = 1 ; 
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   2) = 1 ;
                    output(N/4 +1 : 3*N/4 , N/4 +1 : 3*N/4,   3) = 1 ;
                    figure
                    imagesc(output)
                    Y_R = filter2(DOG_R,output(:,:,1));
                    Y_G = filter2(DOG_G,output(:,:,2));
                    output = (Y_R + Y_G)/2;
            end
            figure
            imagesc(output)
            colormap(gray(256)),colorbar
        end
end      