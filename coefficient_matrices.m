function mats = coefficient_matrices(const)
    % Rod matrices
    mats.B11 = 1/const.ht^2*const.Md + (1/2 + const.alpha_d/const.ht)*const.Kd; % (n+1)x(n+1) matrix
    mats.B12 = -const.eta_d/2*const.Sd(:, 2:end); % (n+1)xn matrix
    mats.B21 = const.eta_d/(2*const.ht)*const.Sd(:, 2:end)'; % nx(n+1) matrix   
    % K(r^k)*I is left off because it is time step dependent. See
    % current_rod_matrix.m for its application.
    mats.B22 = (1/const.ht+const.zeta_d/2)*const.Md(2:end, 2:end) ...
        + const.kappa_th/2*const.Kd(2:end, 2:end); % nxn matrix
    
    % Beam matrices (all nxn)
    mats.B33 = (1/const.ht^2+const.alpha_b/const.ht+1)*const.Mb ...
        + (1+const.alpha_b/const.ht)*const.Kb;
    mats.B34 = -(1+const.alpha_b/const.ht)*const.Sb';
    mats.B43 = -(1+const.alpha_b/const.ht)*const.Sb;
    mats.B44 = (1/const.ht^2)*const.Mb ... 
        + (1+const.alpha_b/const.ht)*const.Kb; % without the nonlinear term