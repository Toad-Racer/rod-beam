function approx_x = newtons_method(x0, epsilon, F, JF)
    error_bound = NaN;
    approx_x = x0;
    iterations = 0;

    while isnan(error_bound) || abs(error_bound) > epsilon
        [L, U] = lu(JF(approx_x));
        prev_approx_x = approx_x;
        approx_x = prev_approx_x - U\(L\F(prev_approx_x));
        
        error_bound = norm(approx_x - prev_approx_x, 2);
        iterations = iterations+1;
    end

    %disp(iterations);
        