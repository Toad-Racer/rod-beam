function lines = prep_animation(initial_data, const)
    f1 = figure(11);
    clf('reset');
    f1.OuterPosition = [50 50 900 600];
    
    % Joint
    subplot(3, 4, [1 5 9]);
    title('Joint of rod and beam');
    axis([0, 1.1, -1.1*max(abs(initial_data.w)), 2*max(abs(initial_data.w))]);
    lines.beam = animatedline('LineStyle', 'none', 'Marker', '.');
    lines.rod_b = animatedline('LineStyle', 'none', 'Marker', '+');
    
    % Rod's top
    subplot(3, 4, [2, 6, 10]);
    title('Rod''s top');
    axis([0.9, 1.1, 0.98, 1.002+const.gap]);
    lines.rod_t = animatedline('LineStyle', 'none', 'Marker', '+');
    % Draw rigid obstacle
    obs_pos = const.gap + const.Ly;
    line(linspace(0.91, 1.09, 100), linspace(obs_pos, obs_pos, 100));
    
    lines = merge_structs(lines, prep_secondary_plots(f1, initial_data, const));
    
    