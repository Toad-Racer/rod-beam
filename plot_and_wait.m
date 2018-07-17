function plot_and_wait(data, const)
    %{
     Plots the current state of the simulation and then waits for user input.

     @param    data     A struct with fields u, phi, and ut each
                        containing the state of their respective functions
                        at a particular time-step.
     @param    const    A struct with the fields hy and Ly.
    %}
    plot_data(data, const);
    waitforbuttonpress;