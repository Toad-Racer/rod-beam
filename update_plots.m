function subFrames = update_plots(lines, data, const)
    y = 0:const.hy:const.Ly;
    x = const.hx:const.hx:1;
    
    % Beam's displacement
    clearpoints(lines.w);
    clearpoints(lines.wt);
    addpoints(lines.w, x, full(data.w));
    addpoints(lines.wt, x, full(data.wt));   
    
    % Rod's velocity
    clearpoints(lines.ut);
    addpoints(lines.ut, y, full(data.ut));
    
    % Beam's angle
    clearpoints(lines.theta);
    clearpoints(lines.theta_t);
    addpoints(lines.theta, x, full(data.theta));
    addpoints(lines.theta_t, x, full(data.theta_t)); 
    
    % Rod's temperature
    clearpoints(lines.phi);
    addpoints(lines.phi, y(2:end), full(data.phi));
    
    figs = findobj('Type', 'figure');
    for i = 1:size(figs, 1)
        subFrames(i) = getframe(figs(i));
    end
    drawnow;