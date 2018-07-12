function system = condense_rod_system(const)
    system.matrix = full([const.B11, const.B12; const.B21, const.B22]);
    system.load_adjustments = containers.Map('KeyType', 'int32', 'ValueType', 'any');

    system.matrix = swap_rows_cols(system.matrix, 2, const.num_nodes);
    system.matrix = swap_rows_cols(system.matrix, 3, (length(system.matrix)));

    target_columns = length(system.matrix):-1:4;
    for col_i = target_columns
        [system.matrix, load_adjustment] = eliminate_column(system.matrix, col_i);
        system.load_adjustments = conj_adjustments(system.load_adjustments, load_adjustment, col_i);
    end
    
    
    %condensed_matrix = swap_rows_cols(condensed_matrix, 2, const.num_nodes);
    %condensed_matrix = swap_rows_cols(condensed_matrix, 3, (length(condensed_matrix)));
        