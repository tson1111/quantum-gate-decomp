function [U_decomp, V_decomp] = local_decomp(G)
    % Decomposition of local parts.
    % Verification: kron(U_decomp, V_decomp) == G

    G_reorder = [G(1,1) G(1,2) G(2,1) G(2,2); G(1,3) G(1,4) G(2,3) G(2,4); G(3,1) G(3,2) G(4,1) G(4,2); G(3,3) G(3,4) G(4,3) G(4,4)];
    [U_single, S_single, V_single] = svd(G_reorder);
    U_tmp = U_single(:, 1)*sqrt(S_single(1,1));
    V_tmp = V_single(:, 1)*sqrt(S_single(1,1));
    U_decomp = [U_tmp(1) U_tmp(2); U_tmp(3) U_tmp(4)];
    V_decomp = conj([V_tmp(1) V_tmp(2); V_tmp(3) V_tmp(4)]);

end