function adjustments = conj_adjustments(initial_adjustments, new_adjustment, adj_i)
    adjustments = initial_adjustments;
    for i = keys(new_adjustment)
        i = cell2mat(i);
        try
            adj_map = adjustments(i);
        catch
            adj_map = containers.Map('KeyType', 'int32', 'ValueType', 'double');
        end
        adj_map(adj_i) = new_adjustment(i);
        adjustments(i) = adj_map;
    end