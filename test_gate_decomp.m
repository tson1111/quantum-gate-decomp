function test_gate_decomp(N)
    % Test two-qubit gate decompostion implementation.
    % Input parameter N specifies number of test cases.
    CNOT = [1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0];
    CNOT2 = [1 0 0 0; 0 0 0 1; 0 0 1 0; 0 1 0 0];

    for a = 1:N
        % generate random unitary matrix
        [x, y, z] = svd(rand(4,4));
        x = x*exp(rand(1)*i*pi); 

        % get decompostion result
        [R_a1, R_b1, R_a2, R_b2, R_b3, R_a4, R_b4] = gate_decomp(x); 

        % combine all gates
        res = kron(R_a4, R_b4)*CNOT2*kron(eye(2), R_b3)*CNOT*kron(R_a2, R_b2)*CNOT2*kron(R_a1, R_b1);
        if norm(res - x) > 1e-9
            disp(x)
            error("Decomposition Error!")
        end
    end
    disp("All test passed.")
    
end