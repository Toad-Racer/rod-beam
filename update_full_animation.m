function update_full_animation(lines, data, const)
    %{
     Updates the animation to reflect the current state of the simulation.

     @param    lines    A struct containing references to all the animated
                        line objects in the figure.                 
     @param    data     A struct with fields for all the data of the system. 
                        See add_derived_data.m for more details.
     @param    const    A struct containing all constants relevant to the 
                        simulation. See get_constants.m for more details.
    %}
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = data.u + y';

    % Joint
    clearpoints(lines.beam);
    clearpoints(lines.rod_b);
    addpoints(lines.beam, x, full(data.w));
    filtered_rod = nonzeros(rod_animation_mask(const).*rod_pos);
    addpoints(lines.rod_b, ones(1, length(filtered_rod)), filtered_rod);
    
    update_secondary_plots(lines, data, const);
    
    drawnow;
   
    
    