function approx_x = newtons_method(F, JF, x0, epsilon)
    %{
     Uses newton's method to approximate a zero of a given nonlinear system.

     @param    F           A (nonlinear) vector function of x whose zero you
                           want to approximate.
     @param    JF          A function of x for the jacobian of F.
     @param    x0          An initial guess for the zero of F.
     @param    epsilon     The maximum tolerable error bound.

     @return    approx_x    An epsilon close approximation of a zero of F.
    %}
    current_error_bound = NaN; % No error can be computed yet
    approx_x = x0;
    iterations = 0;

    while isnan(current_error_bound) || abs(current_error_bound) > epsilon
        [L, U] = lu(JF(approx_x));
        prev_approx_x = approx_x;
        approx_x = prev_approx_x - U\(L\F(prev_approx_x));
        
        current_error_bound = norm(approx_x - prev_approx_x, 2);
        iterations = iterations+1;
    end

    %disp(iterations);
        