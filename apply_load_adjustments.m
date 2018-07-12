function adjusted_f = apply_load_adjustments(initial_f, adjustments)
    adjusted_f = initial_f;
    k = keys(adjustments);
    for adj_i = length(adjustments):-1:1
        row_i = cell2mat(k(adj_i));
        adj  = adjustments(row_i);
        for i = keys(adj)
            i = cell2mat(i);
            adjusted_f(row_i) = adjusted_f(row_i)-adj(i)*adjusted_f(i);
        end
    end
    
        
        
    