function lines = prep_transient(initial_data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = initial_data.u + y';
    
    % Beam and rod
    f5 = figure(15);
    f5.OuterPosition = [50 50 600 600];
    clf('reset');
    title('Rod and Beam');
    lines.beam = scatter(x, initial_data.w, 25, 'black', 'filled');
    hold on;
    lines.rod = scatter(1+(0*y), rod_pos, 25, [0; initial_data.phi], 'filled');
    colormap('jet');
    bar = colorbar;
    bar.Label.String = 'Temperature';
    caxis([0 initial_data.phi(end)]);
    axis([0, 1.2, initial_data.u(1)-0.1, 1+5*const.gap]);
    
    % Rod's top
    axes('Position', [0.515 0.45 0.1 0.4]);
    lines.rod_t = scatter(1+(0*y), rod_pos, 25, [0; initial_data.phi], 'filled');
    colormap('jet');
    caxis([0 initial_data.phi(end)]);
    axis([0.9, 1.1, 0.98, 1.002+const.gap]);
    % Draw rigid obstacle
    obs_pos = const.gap + const.Ly;
    line(linspace(0.91, 1.09, 100), linspace(obs_pos, obs_pos, 100));
    title('Rod''s top');
    
    % Joint
    axes('Position', [0.2 0.25 0.4 0.1]);
    lines.beam_j = scatter(x, initial_data.w, 25, 'black', 'filled');
    hold on;
    lines.rod_j = scatter(1+(0*y), rod_pos, 25, [0; initial_data.phi], 'filled');
    colormap('jet');
    caxis([0 initial_data.phi(end)]);
    axis([0, 1.1, -0.011, 0.001]);
    title('Joint');
    
    
    % Velocities
    
    f6 = figure(16);
    f6.OuterPosition = [650 50 300 600];
    clf('reset');
    % Rod's velocity
    subplot(3, 1, 1);
    title('Rod''s Velocity');
    lines.ut = animatedline;
    % Beam's velocity
    subplot(3, 1, 2);
    title('Beam''s Velocity');
    lines.wt = animatedline;
    % Angular velocity
    subplot(3, 1, 3);
    title('Angular Velocity');
    lines.theta_t = animatedline;

    