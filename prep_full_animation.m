function lines = prep_full_animation(initial_data, const)
    %{
     Creates and initializes the figure the animation will play in.

     @param    initial_data    A struct with fields for all the initial
                               data of the system. See get_initial_data.m
                               for more details. This parameter is
                               currently unused, but could potentially be 
                               used to scale things appropriately. 
     @param    const           A struct containing all constants relevant
                               to the simulation. See get_constants.m for
                               more details.

     @return    lines    A struct containing references to all the animated
                         line objects in the figure. These can be used by
                         another function to update the figure.
                         
    %}
    f1 = figure(11);
    clf('reset');
    f1.OuterPosition = [100 100 800 600];
    
    % Rod and Beam
    subplot(3, 3, [1 2 4 5 7 8]);
    title('Rod and beam');
    axis([0, 1.1, -0.2, 1.03*const.Ly+const.gap]);
    lines.beam = animatedline('LineStyle', 'none', 'Marker', '.');
    lines.rod_b = animatedline('LineStyle', 'none', 'Marker', '+');
    % Draw rigid obstacle
    obs_pos = const.gap + const.Ly;
    line(linspace(0.91, 1.09, 100), linspace(obs_pos, obs_pos, 100));
    
    % Beam's velocity
    subplot(3, 3, 3);
    title('Beam''s velocity');
    lines.beam_velo = animatedline;
     
    % Rod's velocity
    subplot(3, 3, 6);
    title('Rod''s velocity');
    lines.rod_velo = animatedline;
    
    % Rod's temperature
    subplot(3, 3, 9);
    title('Rod''s temperature distribution');
    lines.rod_temp = animatedline;
    
    figure(13);
    clf('reset');
    
    % Stress on Rod's top
    subplot(2, 1, 1);
    title('Stress on Rod''s Top');
    axis([0, const.T, -inf, inf]);
    lines.sigma_dt = animatedline('Color', 'r');
    
    % Total energy
    subplot(2, 1, 2);
    title('Energy in System');
    axis([0, const.T, -inf, inf]);
    lines.energy = animatedline('Color', 'r');