function lines = prep_figures(initial_data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    rod_pos = initial_data.u + y';
    
    % Stress on Rod's top
    f1 = figure(11);
    f1.OuterPosition = [50 50 500 250];
    clf('reset');
    title('Stress on Rod''s Top');
    axis([0, const.T, -inf, inf]);
    lines.sigma_dt = animatedline('Color', 'r');
    
    % Energy
    f2 = figure(12);
    f2.OuterPosition = [50 300 500 250];
    clf('reset');
    title('Energy in System');
    axis([0, const.T, -inf, inf]);
    lines.energy = animatedline('Color', 'r');
    lines.accounted_energy = animatedline('LineStyle', '--');
    
    % Tip of rod
    f3 = figure(13);
    f3.OuterPosition = [50 550 500 250];
    clf('reset');
    title('Tip of Rod');
    axis([0, const.T, -inf, 2*const.gap]);
    lines.tip = animatedline('Color', 'b');
    
    % Stress in joint
    f4 = figure(14);
    f4.OuterPosition = [550 50 500 250];
    clf('reset');
    title('Stress in Joint');
    axis([0, const.T, -inf, inf]);
    lines.sigma_db = animatedline('Color', 'r');
    
    % Beam and rod
    f5 = figure(15);
    f5.OuterPosition = [550 300 500 500];
    clf('reset');
    title('Rod and Beam');
    lines.beam = scatter(x, initial_data.w, 'black', 'filled');
    hold on;
    lines.rod = scatter(1+(0*y), rod_pos, 25, [0; initial_data.phi], 'filled');
    colormap('jet');
    colorbar;
    caxis([0 initial_data.phi(end)]);
    axis([0, 1.2, initial_data.u(1)-0.1, 1+5*const.gap]);
    
    % Rod's temperature
    f6 = figure(16);
    f6.OuterPosition = [1050 50 500 250];
    clf('reset');
    title('Rod''s temperature distribution');
    lines.rod_temp = animatedline;

    