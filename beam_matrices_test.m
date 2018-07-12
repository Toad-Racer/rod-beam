function error = beam_matrices_test(num_nodes)
    %{
     Approximates the solution to u'' - u' - u = 0, u(0)=0, u'(1)=1 using
     finite element methods with hat basis functions on the interval [0,1].
     Then compares the approximation to the exact solution by plotting them
     together and by calculating the maximum error between the two.

     @param    num_nodes    The number of nodes on u's domain to use in the
                            approximation. 

     @return    error    The maximum error between the exact value of u
                         and the approximation of u.
    %}
    h = 1/(num_nodes - 1);
    x = h:h:1;
    
    % Find exact value of u
    gold = (sqrt(5)+1)/2;
    pyrite = -(sqrt(5)-1)/2;
    c1 = -1/(pyrite*exp(pyrite)-gold*exp(gold));
    c2 = -c1;
    u_exact = c1.*exp(gold.*x)+c2.*exp(pyrite.*x);
    
    
    % Approximate u using fem
    mat = assemble_beam_matrices(struct('num_nodes', num_nodes, 'hx', h));
    
    b = zeros(num_nodes-1, 1);
    for i=1:num_nodes-2
       b(i,1) = 0;
    end
    b(num_nodes-1,1) = 1; 
   
   u_approx = (mat.Kb+mat.Sb'+mat.Mb)\b;
   

   % Compare the exact value and the approximation
   plot(x,u_exact,'r',x,u_approx,'b');
   error = max(abs(u_exact - u_approx'));