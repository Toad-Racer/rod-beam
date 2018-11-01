function lines = prep_transient(initial_data, const, visibility)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = initial_data.u + y';

    % Beam and rod
    f1 = figure;
    f1.OuterPosition = [50 50 500 600];
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

    % Velocities
    f2 = figure;
    f2.OuterPosition = [550 50 350 600];
    clf('reset');
    % Rod's velocity
    subplot(4, 1, 1);
    title('Rod''s Velocity');
    lines.ut = animatedline;
    % Beam's velocity
    subplot(4, 1, 2);
    title('Beam''s Velocity');
    lines.wt = animatedline;
    % Angular velocity
    subplot(4, 1, 3);
    title('Angular Velocity');
    lines.theta_t = animatedline;
    % Beam's displacement
    subplot(4, 1, 4);
    title('Beam''s Displacement')
    lines.w = animatedline;

    set(f1, 'Visible', visibility);
    set(f2, 'Visible', visibility);
    lines.figs = [f1, f2];
