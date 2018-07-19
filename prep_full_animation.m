function lines = prep_full_animation(initial_data, const)
    f = figure(11);
    clf('reset');
    f.OuterPosition = [100 100 800 600];
    
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