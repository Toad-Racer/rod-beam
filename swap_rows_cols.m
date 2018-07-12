function matrix = swap_rows_cols(M, i1, i2)
    matrix = M;
    
    temp = matrix(i1, :);
    matrix(i1, :) = matrix(i2, :);
    matrix(i2, :) = temp;
    
    temp = matrix(:, i1);
    matrix(:, i1) = matrix(:, i2);
    matrix(:, i2) = temp;