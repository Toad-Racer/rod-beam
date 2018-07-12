function matrices = assemble_rod_matrices(const)
    %{
     Creates the mass, stiffness, and semi-stiffness matrices for the rod
     using hat basis functions with a given element length and 
     number of nodes.

     @param    const    A struct with fields hy and num_nodes containing,
                        respectively, the length of each element in the
                        rod's domain and the number of nodes on the rod's
                        domain (counting nodes at y=0 and y=Ly as well as
                        all interior nodes).

     @return    matrices    A struct with fields Kd, Md, and Sd containing
                            a sparse representation of, respectively, the 
                            stiffness, mass, and semi-stiffness matrices.
    %}
    h = const.hy;
    n = const.num_nodes;
    matrices.Kd = assemble_FEM_matrix(-1/h, 2/h, -1/h, 1/h, 1/h, n);
    matrices.Md = assemble_FEM_matrix(h/6, 2*h/3, h/6, h/3, h/3, n);
    matrices.Sd = assemble_FEM_matrix(1/2, 0, -1/2, -1/2, 1/2, n);
    