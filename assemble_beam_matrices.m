function matrices = assemble_beam_matrices(const)
    %{
     Creates the mass, stiffness, and semi-stiffness matrices for the beam
     using hat basis functions with a given element length and
     number of nodes.
     

     @param    const    A struct with fields hx and num_nodes containing,
                        respectively, the length of each element in the
                        beam's domain and the number of nodes on the beam's
                        domain (counting nodes at x=0 and x=Lx=1 as well as
                        all interior nodes).

     @return    matrices    A struct with fields Kb, Mb, and Sb containing
                            a sparse representation of, respectively, the 
                            stiffness, mass, and semi-stiffness matrices.
    %}
    h = const.hx;
    n = const.num_nodes;
    matrices.Kb = assemble_FEM_matrix(-1/h, 2/h, -1/h, 2/h, 1/h, n-1);
    matrices.Mb = assemble_FEM_matrix(h/6, 2*h/3, h/6, 2*h/3, h/3, n-1);
    matrices.Sb = assemble_FEM_matrix(1/2, 0, -1/2, 0, 1/2, n-1);