function output_data(sim)
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
    if sim.log_fns ~= false
        disp('---------------');
        for msg = keys(sim.log_fns)
            disp(msg);
            fn = sim.log_fns(cell2mat(msg));
            disp(fn(sim.data, sim.const));
        end
    end

    sim.plot_fn(sim.data, sim.const);

    if sim.wait_for_input
        waitforbuttonpress;
    end
