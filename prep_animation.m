function lines = prep_animation(initial_data, const)
    f1 = figure(11);
    clf('reset');
    f1.OuterPosition = [50 50 900 600];
    
    % Joint
    subplot(3, 3, [1 4 7]);
    title('Joint of rod and beam');
    axis([0, 1.1, -1.5*max(abs(initial_data.w)), 3*max(abs(initial_data.w))]);
    lines.beam = animatedline('LineStyle', 'none', 'Marker', '.');
    lines.rod_b = animatedline('LineStyle', 'none', 'Marker', '+');
    
    % Rod's top
    subplot(3, 3, [2, 5, 8]);
    title("Rod's top");
    axis([0.9, 1.1, 0.94, 1.003+const.gap]);
    lines.rod_t = animatedline('LineStyle', 'none', 'Marker', '+');
    % Draw rigid obstacle
    obs_pos = const.gap + const.Ly;
    line(linspace(0.91, 1.09, 100), linspace(obs_pos, obs_pos, 100));
    
    lines = merge_structs(lines, prep_secondary_plots(f1, initial_data, const));
    
    