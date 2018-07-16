function output_data(data, const, plot_fn, log_fns)
    %{
     Calls the configurable output functions. See get_config.m for more
     details.

     @param    data     A struct with fields u, phi, theta, w, ut, theta_t,
                        and wt each containing the state of their 
                        respective functions at a particular time-step.
     @param    const    A struct with fields for each constant relevant to
                        the simulation. See get_constants.m for a full
                        list.
    %}
    if log_fns ~= false
        disp('---------------');
        for msg = keys(log_fns)
            disp(msg);
            fn = log_fns(cell2mat(msg));
            disp(fn(data, const));
        end
    end
    
    plot_fn(data, const);
