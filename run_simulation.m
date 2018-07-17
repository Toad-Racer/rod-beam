function run_simulation(num_nodes, ht, num_steps, output_fn)
    %{
     Runs a simulation of the rod without considering contact or the beam.
     On each time-step the state of the simulation will be plotted. The
     plot lines are color coded as follows: blue=rod_position, green=ut,
     red=phi. Click on the plot in order to advance the simulation. If the 
     rod comes in contact with the rigid body then the simulation will 
     throw an error.

     @param    num_nodes       The number of nodes on each spatial domain
                               (counting nodes at x=0 and x=Lx as well as
                               all interior nodes).
     @param    ht              Time-step size.
     @param    num_steps       The numer of time-steps to simulate.  
    %}
    [const, current_data, plot_fn, log_fns] = prep_simulation(num_nodes, ht);
    output_data(current_data, const, plot_fn, log_fns);
    for i = 1:num_steps
        current_data = step_simulation(current_data, const);
        output_data(current_data, const, plot_fn, log_fns);
    end
    