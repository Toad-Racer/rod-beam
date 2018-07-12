function const = set_constants(num_nodes, ht)
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
    const = struct('alpha_d', 1, 'alpha_b', 0, 'eta_d', 1, 'kappa_th', 1/2,  ...
        'zeta_d', 1/2, 'beta', -1/2, 'rho', 1, 'gap', 0.2, 'num_nodes',   ...
        num_nodes, 'Ly', 1, 'hy', 1/(num_nodes-1), 'hx', 1/(num_nodes-1), ...
        'ht', ht);
    
    % main matrices
    const = merge_structs(const, assemble_rod_matrices(const), ...
        assemble_beam_matrices(const));
    
    % coefficent matrices (time-dependent terms excluded)
    const = merge_structs(const, coefficient_matrices(const));