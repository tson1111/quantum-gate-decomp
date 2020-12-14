function [L, DX, DY, R] = simul_svd(X,Y)
    % Simultaneous svd of 2 matrices.
    % Verification:
    %   L, R \in SO(2)
    %   DX, DY are real diag
    %   L*DX*R'=X
    %   L*DY*R'=Y
    
    [dim_U, nvm]= size(X);
    [LX, DX, RX]=svd(X);
    
    DX_D = DX;
    G = LX'*Y*RX;
    [ P ,  qDs ] = rjd([DX,G], 1e-12); % used rjd implemented by others
    DY = qDs(1:dim_U, dim_U+1: 2*dim_U);
    R = RX*P;
    L = LX*P;
    
    
    if (det(L) < 0)
        L(:,1) = -L(:,1);
        DX(1,1) = -DX(1,1);
        DY(1,1) = -DY(1,1);
    end
    if (det(R) < 0)
        R(:,1) = -R(:,1);
        DX(1,1) = -DX(1,1);
        DY(1,1) = -DY(1,1);
    end
    