function error = rod_beam_test(num_nodes)
    %{
     Approximates the solution to u'' - u' - u = 0, u'(0)=0, u'(1)=1 
     w'' - w' - w = 0 w(0)=u(1) w'(1)=1 using finite element methods
     with hat basis functions on the domain [0,1]x[0,1]. Then compares the 
     approximation to the exact solution by plotting them together and
     by calculating the maximum error between the two.

     @param    num_nodes    The number of nodes on u's domain to use in the
                            approximation. 

     @return    error    The maximum error between the exact values of u
                         and w and the approximations of u and w.
     %}

    h = 1/(num_nodes - 1);
    x = h:h:1;
    y = 0:h:1;

    % Find exact value of u
    gold = (sqrt(5)+1)/2;
    pyrite = -(sqrt(5)-1)/2;
    c2 = 1/(pyrite*exp(pyrite)-gold*exp(gold));
    c1 = -c2;
    u_exact = c1.*exp(gold.*x)+c2.*exp(pyrite.*x);
    
    % Find exact value of w
    u1 = u_exact(num_nodes-1);
    d2 = (1-gold*u1*exp(gold))/(pyrite*exp(pyrite)-gold*exp(gold));
    d1 = u1-d2;
    w_exact = d1.*exp(gold.*y)+d2.*exp(pyrite.*y);
    
    plot(x,u_exact,'b',y,w_exact,'g',y,u1.*ones(num_nodes),'y');
    error = "n/a";