function const = get_constants(config)
    %{
     Creates a struct containing fields for all constants relevant to the 
     simulation. This struct can be passed to any function in this project
     with a parameter called 'const'.

     @param    config       A struct with a 'const' field containing all
                            configurable constants. See get_config.m for a
                            full list.

     @return    const    A struct containing the fields alpha_d, alpha_b,
                         eta_d, kappa_th, zeta_d, beta, rho, gap, num_nodes, 
                         Ly, hy, hx, ht, Kd, Md, Sd, Kb, Mb, Sb, B11, B12,
                         B21, B22, B33, B34, B43, B44, and jac_term.
                         
    %}
    % scaler constants
    const = config.const;
    const = merge_structs(const, struct('hy', 1/(const.num_nodes-1), ...
        'hx', 1/(const.num_nodes-1)));
    
    % main matrices
    const = merge_structs(const, assemble_rod_matrices(const), ...
        assemble_beam_matrices(const));
    
    % coefficent matrices (time-dependent terms excluded)
    const = merge_structs(const, coefficient_matrices(const));
    
    % Precompute constant term of jacobian for efficiency
    const.jac_term = -const.B43*const.B33\const.B34 + const.B44 ...
        + 1/2*const.beta*const.Kb;