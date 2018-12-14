function lines = prep_transient(initial_data, const, visibility)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = initial_data.u + y';

    % Beam and rod
    f1 = figure;
    f1.OuterPosition = [50 50 500 600];
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
    % Rod's velocity
    subplot(5, 1, 1);
    title('Velocity of the rod');
    lines.ut = animatedline;
    % Beam's velocity
    subplot(5, 1, 2);
    title('Velocity of the beam');
    lines.wt = animatedline;
    % Angular velocity
    subplot(5, 1, 3);
    title('Angular Velocity');
    lines.theta_t = animatedline;
    % Beam's displacement
    subplot(5, 1, 4);
    title('Displacement of the beam')
    lines.w = animatedline;
    % Beam's displacement
    subplot(5, 1, 5);
    title('Bending angle of the beam')
    lines.theta = animatedline;

    set(f1, 'Visible', visibility);
    set(f2, 'Visible', visibility);
    lines.figs = [f1; f2];
