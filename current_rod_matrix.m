function rod_matrix = current_rod_matrix(current_data, const)
     rod_matrix = [const.B11, const.B12; const.B21, const.B22];
     rod_matrix(end, end) = rod_matrix(end, end) + K(current_data.r);