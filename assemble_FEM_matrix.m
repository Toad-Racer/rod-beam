function FEM_matrix = assemble_FEM_matrix(sub_diag, main_diag, super_diag, ... 
                                          first_entry, last_entry, matrix_size)
    %{
     Creates a square sparse matrix of a given size with given values on the 
     sub, main and super diagonals. Can be used to create mass, stiffness,  
     and semi-stiffness matrices encountered in finite element methods.

                                          
     @param    sub_diag       The value to be assigned to all entries of
                              the sub-diagonal.
     @param    main_diag      The value to be assigned to the middle entries 
                              of the main-diagonal. 
     @param    super_diag     The value to be assigned to all entries of
                              the super-diagonal. 
     @param    first_entry    The value to be assigned to the first entry 
                              of the main diagonal.
     @param    last_entry     The value to be assigned to the last entry 
                              of the main diagonal. 
     @param    matrix_size    The number of rows/columns in the matrix.  

                                          
     @return    FEM_matrix    A square sparse matrix of the given size with
                              the given values on its sub, main, and super
                              diagonals.
    %}
    diagonals = zeros(matrix_size, 3);
    for i = 1:matrix_size-1
        diagonals(i, 1)   = sub_diag;
        diagonals(i, 2)   = main_diag;
        diagonals(i+1, 3) = super_diag;
    end
    diagonals(1, 2) = first_entry;
    diagonals(matrix_size, 2) = last_entry;
    
    FEM_matrix = spdiags(diagonals, [-1, 0, 1], matrix_size, matrix_size);
                                     