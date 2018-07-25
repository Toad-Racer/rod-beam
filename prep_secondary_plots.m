function lines = prep_secondary_plots(main_figure, initial_data, const)
    figure(main_figure);
    
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
    
    % Energy
    subplot(2, 1, 2);
    title('Energy in System');
    axis([0, const.T, -inf, inf]);
    lines.energy = animatedline('Color', 'r');
    lines.accounted_energy = animatedline('LineStyle', '--');