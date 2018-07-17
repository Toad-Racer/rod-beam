function mats = coefficient_matrices(const)
    %{
     Constructs the matrices B11, ..., B44 in the block matrix on the left
     hand side of the recurrence relation defined in the manuscript. Time
     dependent terms are left out, see find_beam_data.m and
     current_rod_matrix.m for their addition.

     @param    const           A struct with fields for each of the scaler
                               coefficents and main matrices relevant to 
                               the simulation.

     @return    mats    A struct containing the matrices B11, B12, B21, B22,
                        B33, B34, B43, and B44 as defined in the manuscript
                        (but without time-dependent terms).
    %}
    % Rod matrices (each has different dimensions)
    mats.B11 = 1/const.ht^2*const.Md + ...
        (const.Ed/2 + const.alpha_d/const.ht)*const.Kd; % (n+1)x(n+1) matrix
    mats.B12 = -const.eta_d/2*const.Sd(:, 2:end); % (n+1)xn matrix
    mats.B21 = const.eta_d/(2*const.ht)*const.Sd(:, 2:end)'; % nx(n+1) matrix   
    % K(r^k)*I is left off because it is time step dependent. See
    % current_rod_matrix.m for its addition.
    mats.B22 = (1/const.ht+const.zeta_d/2)*const.Md(2:end, 2:end) ...
        + const.kappa_th/2*const.Kd(2:end, 2:end); % nxn matrix
    
    % Beam matrices (all nxn)
    mats.B33 = (1/const.ht^2+const.alpha_b/const.ht+const.G)*const.Mb ...
        + (const.Eb+const.alpha_b/const.ht)*const.Kb;
    mats.B34 = -(const.G+const.alpha_b/const.ht)*const.Sb';
    mats.B43 = -(const.G+const.alpha_b/const.ht)*const.Sb;
    % N^(k+1) is left off because it is time step dependent. See
    % find_beam_data.m for its addition.
    mats.B44 = (1/const.ht^2)*const.Mb ... 
        + (const.G+const.alpha_b/const.ht)*const.Kb;