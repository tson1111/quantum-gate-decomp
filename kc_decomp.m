function [V1, theta, X] = kc_decomp_new(U)
    % The canonical decomposition of arbitrary 2-qubit gate.
    % Verification: 
    %   M*V1*M'*expm(i*(kron(pauli_x, pauli_x)*theta(1)+kron(pauli_y, pauli_y)
    %   *theta(2)+kron(pauli_z,pauli_z)*theta(3)))*M*X'*M'
    %   *expm(1i*theta(4)*kron(eye(2), eye(2))) == x
    
    % Useful Matrices
    M = [1 0 0 i; 0 i 1 0; 0 i -1 0; 1 0 0 -i]/sqrt(2);
    minus_1 = [-1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];

    root4th = det(U)^(1/4);
    if(abs(root4th-1) > 1e-7)
        U = U/root4th;
    end 

    U_prime = (M')*U*M;
    U_R = (U_prime + conj(U_prime))/2;
    U_I = (U_prime - conj(U_prime))/2i;
    [V1, DX, DY, X] = simul_svd(U_R,U_I);
    D = DX + 1i*DY;
    fi = angle(diag(D));

    k0 = ( fi(1)+fi(2)+fi(3)+fi(4))/4;
    kx = ( fi(1)+fi(2)-fi(3)-fi(4))/4;
    ky = (-fi(1)+fi(2)-fi(3)+fi(4))/4;
    kz = ( fi(1)-fi(2)-fi(3)+fi(4))/4;
    
    theta = [kx ky kz k0+angle(root4th)];
    end