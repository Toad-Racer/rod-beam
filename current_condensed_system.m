function system = current_condensed_system(current_data, const)
    system = const.condensed_rod_system;
    
    % apply adjustments to heat exchange term
    system.matrix(3, 3) = K(current_data.r)+system.matrix(3, 3);
%     system.matrix(3, 3) = K(current_data.r)*const.B22(end, end);
%     adj = system.load_adjustments(3);
%     for i = keys(adj)
%         i = cell2mat(i);
%         system.matrix(3, 3) = system.matrix(3, 3)-adj(i)*system.matrix(i, 3);
%     end
    
    % eliminate heat exchange term
    [system.matrix, load_adjustment] = eliminate_column(system.matrix, 3);
    system.load_adjustments = conj_adjustments(system.load_adjustments, load_adjustment, 3);
    [system.matrix, load_adjustment] = eliminate_column(system.matrix, 2);
    system.load_adjustments = conj_adjustments(system.load_adjustments, load_adjustment, 2);
    
    initial_loads = [current_data.f1; current_data.f2];
    initial_loads = swap_rows(initial_loads, 2, const.num_nodes);
    initial_loads = swap_rows(initial_loads, 3, length(initial_loads));
    
    system.loads = apply_load_adjustments(initial_loads, system.load_adjustments);
    
    