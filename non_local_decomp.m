function [R_a1, R_b1, R_a2, R_b2, R_b3, R_a4, R_b4] = non_local_decomp(h)
    % Decomposition of non-local parts.
    % Verification: 
    %   expm(1i*(h(1)*kron(pauli_x, pauli_x)+h(2)*kron(pauli_y, pauli_y)+h(3)*kron(pauli_z, pauli_z)))
    %   == kron(R_a4, R_b4)*CNOT2*kron(eye(2), R_b3)*CNOT*kron(R_a2, R_b2)*CNOT2*kron(R_a1, R_b1)

    % Useful Matrices
    Rx = @(k) [cos(k/2) -i*sin(k/2); -i*sin(k/2) cos(k/2)];
    Ry = @(k) [cos(k/2) -sin(k/2);sin(k/2) cos(k/2)];
    Rz = @(k) [exp(-1i*k/2) 0;0 exp(1i*k/2)];
    Ph = @(k) exp(1i*k)*eye(2);

    R_a1 = eye(2);
    R_b1 = Rz(-pi/2);
    R_a2 = Rz(pi/2 - 2*h(3));
    R_b2 = Ry(2*h(1) - pi/2);
    R_b3 = Ry(pi/2 - 2*h(2));
    R_a4 = Rz(pi/2);
    R_b4 = Ph(pi/4);
end