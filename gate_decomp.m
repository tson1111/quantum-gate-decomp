function [R_a1, R_b1, R_a2, R_b2, R_b3, R_a4, R_b4] = gate_decomp(U)
    % This function gives the decompostion of arbitrary 2-qubit gate.
    % Final decompostion result:
    %  =====      ======  =======  ======  ======          =======  ======
    % -|   |-   --|R_a1|--|     |--|R_a2|--|    |----------|     |--|R_a4|--
    %  | U |  =>  ======  |CNOT2|  ======  |CNOT|  ======  |CNOT2|  ======
    % -|   |-   --|R_b1|--|     |--|R_b2|--|    |--|R_b3|--|     |--|R_b4|--
    %  =====      ======  =======  ======  ======  ======  =======  ======
    %

    % useful matrices
    M = [1 0 0 1i; 0 1i 1 0; 0 1i -1 0; 1 0 0 -1i]/sqrt(2);
    pauli_x = [0 1; 1 0];
    pauli_y = [0 -i; i 0];
    pauli_z = [1 0; 0 -1];
    CNOT = [1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0];
    CNOT2 = [1 0 0 0; 0 0 0 1; 0 0 1 0; 0 1 0 0];
    
    [V1, theta, X] = kc_decomp(U);
    h = theta(1:3);
    [R_a1, R_b1, R_a2, R_b2, R_b3, R_a4, R_b4] = non_local_decomp(h);
    [U_A, U_B] = local_decomp(M*V1*M');
    [V_A, V_B] = local_decomp(M*X'*M');
    R_a4 = U_A*R_a4;
    R_b4 = U_B*R_b4;
    R_a1 = R_a1*V_A;
    R_b1 = R_b1*V_B*expm(1i*theta(4)*eye(2));
    
    end