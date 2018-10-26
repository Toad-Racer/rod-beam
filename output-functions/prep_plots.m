function lines = prep_plots(initial_data, const)
    close all;
    
    % Rod's velocity  
    figure();
    title("Rod's Velocity");
    lines.ut = animatedline();
    
    %Rod's temperature
    figure();
    title("Rod's Temperature");
    lines.phi = animatedline();
    
    % Beam's displacement
    figure();
    title("Beam's Displacement");
    lines.w = animatedline();
    
    % Beam's velocity
    figure();
    title("Beam's Velocity");
    lines.wt = animatedline();
    
    % Beam's angle
    figure();
    title("Beam's Angle");
    lines.theta = animatedline();
    
    % Beam's angular velocity
    figure();
    title("Beam's Angular Velocity");
    lines.theta_t = animatedline();
    
    