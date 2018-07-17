function partially_inverted_system = partially_invert_rod_system(prev_data, const)
    %{
     Efficiently solves for f_star = K^(-1)*f and two columns of K^(-1)
     where K is the rod_matrix for the previous time-step.

     @param    prev_data       A struct with fields for the primary and
                               derived data of the previous time step. See
                               add_derived_data.m for a full list.
     @param    const           A struct with all constants relevant to the 
                               simulation. See get_constants.m for a full
                               list.

     @return    partially_inverted_system    A struct containing fields f,
                                             b, and t respectively containg
                                             the vectors f_star, the first
                                             column of K^(-1), and the
                                             num_nodes column of K(-1).
    %}
    f = [prev_data.f1; prev_data.f2]; % Rod's loading vector
    I = speye(length(f));
    partial_inversion = prev_data.rod_matrix\[f, I(:, 1), I(:, const.num_nodes)];
    partially_inverted_system.f = partial_inversion(:, 1);
    partially_inverted_system.b = partial_inversion(:, 2);
    partially_inverted_system.t = partial_inversion(:, 3);