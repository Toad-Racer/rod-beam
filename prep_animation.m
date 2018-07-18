function lines = prep_animation(initial_data, const)
    f = figure;
    f.OuterPosition = [100 100 800 600];
    
    % Joint
    subplot(3, 3, [1 4 7]);
    title('Joint of rod and beam');
    axis([0, 1.1, -0.01, 0.05]);
    lines.beam = animatedline('LineStyle', 'none', 'Marker', 'd', 'Color', 'g');
    lines.rod_b = animatedline('LineStyle', 'none', 'Marker', 'd', 'Color', 'r');
    
    % Rod's top
    subplot(3, 3, [2, 5, 8]);
    title("Rod's top");
    axis([0.9, 1.1, 0.94, 1.003+const.gap]);
    lines.rod_t = animatedline('LineStyle', 'none', 'Marker', 'd', 'Color', 'r');
    % Draw rigid obstacle
    obs_pos = const.gap + const.Ly;
    line(linspace(0.97, 1.03, 100), linspace(obs_pos, obs_pos, 100), ...
        'LineStyle', 'none', 'Marker', 'd');
    
    % Beam's velocity
    subplot(3, 3, 3);
    title("Beam's velocity");
    lines.beam_velo = animatedline;
     
    % Rod's velocity
    subplot(3, 3, 6);
    title("Rod's velocity");
    lines.rod_velo = animatedline;
    
    % Rod's temperature
    subplot(3, 3, 9);
    title("Rod's temperature distribution");
    lines.rod_temp = animatedline;
    
    