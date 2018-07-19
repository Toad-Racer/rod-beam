function plot_and_wait(plot_fn, plot_state, data, const)
    %{
     Plots the current state of the simulation using a given plot_fn and
     then waits for user input.

     @param    plot_fn    The plot function to use.
     @param    data       A struct with fields u, phi, and ut each
                          containing the state of their respective functions
                          at a particular time-step.
     @param    const      A struct with the fields hy and Ly.
    %}
    plot_fn(plot_state, data, const);
    waitforbuttonpress;