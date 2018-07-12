function matrix = swap_columns(M, j1, j2)
    matrix = M;
    temp = matrix(:, j1);
    matrix(:, j1) = matrix(:, j2);
    matrix(:, j2) = temp;