function run_simulation(num_nodes, ht, num_steps)
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
    sim = prep_simulation(num_nodes, ht, num_steps);
    output_data(sim);
    for i = 1:num_steps
        sim.data = step_simulation(sim.data, sim.const);
        output_data(sim);
    end
    