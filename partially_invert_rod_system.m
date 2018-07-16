function partially_inverted_system = partially_invert_rod_system(prev_data, const)
    f = [prev_data.f1; prev_data.f2];
    I = speye(length(f));
    partial_inversion = prev_data.rod_matrix\[f, I(:, 1), I(:, const.num_nodes)];
    partially_inverted_system.f = partial_inversion(:, 1);
    partially_inverted_system.b = partial_inversion(:, 2);
    partially_inverted_system.t = partial_inversion(:, 3);