function lines = prep_plots_together(initial_data, const)
    f1 = figure(11);
    clf('reset');
    f1.OuterPosition = [50 50 700 600];
    
    % Rod's velocity
    subplot(3, 2, 1)
    title("$$u_t$$", 'Interpreter', 'Latex', 'fontsize', 16);
    lines.ut = animatedline();
    
    %Rod's temperature
    subplot(3, 2, 2)
    title("$$\phi$$", 'Interpreter', 'Latex', 'fontsize', 16);
    lines.phi = animatedline();
    
    % Beam's displacement
    subplot(3, 2, 3)
    title("$$w$$", 'Interpreter', 'Latex', 'fontsize', 16);
    lines.w = animatedline();
    
    % Beam's velocity
    subplot(3, 2, 4)
    title("$$w_t$$", 'Interpreter', 'Latex', 'fontsize', 16);
    lines.wt = animatedline();
    
    % Beam's angle
    subplot(3, 2, 5)
    title("$$\theta$$", 'Interpreter', 'Latex', 'fontsize', 16);
    lines.theta = animatedline();
    
    % Beam's angular velocity
    subplot(3, 2, 6)
    title("$$\theta_t$$", 'Interpreter', 'Latex', 'fontsize', 16);
    lines.theta_t = animatedline();
    
    