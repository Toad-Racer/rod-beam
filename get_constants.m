function const = get_constants(config)
    %{
     Creates a struct containing fields for all constants relevant to the 
     simulation. This struct can be passed to any function in this project
     with a parameter called 'const'.

     @param    num_nodes       the number of nodes on each spatial domain
                               (counting nodes at x=0 and x=Lx as well as
                               all interior nodes).
     @param    ht              Time-step size.

     @return    const    A struct containing the fields alpha_d, alpha_b,
                         eta_d, kappa_th, zeta_d, beta, rho, gap, num_nodes, 
                         Ly, hy, hx, ht, Kd, Md, Sd, Kb, Mb, Sb, and rod_matrix.
                         
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
    
    const.jac_term = -const.B43*const.B33\const.B34 + const.B44 ...
        + 1/2*const.beta*const.Kb;