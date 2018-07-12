function [condensed_matrix, load_adjustment] = eliminate_column(M, col_i)
    pivot = M(col_i, col_i);
    load_adjustment = containers.Map('KeyType', 'int32', 'ValueType', 'double');
    nonzero_rows = find(M(1:col_i-1, col_i))';

    for row_i = nonzero_rows   
        scale = M(row_i, col_i)/pivot;
        load_adjustment(row_i) = scale;
        M(row_i, :) = M(row_i, :)-scale*M(col_i, :);
    end
    
    condensed_matrix = M;