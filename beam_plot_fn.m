function plot_fn = beam_plot_fn()
    figure(11);
    clf('reset');
    title('Beam''s Displacement');
    lines.w = animatedline('Color', 'b');
    
    figure(13);
    clf('reset');
    title('Beam''s Velocity');
    lines.wt = animatedline('Color', 'g');
    
    plot_fn = @(data, const) plot_beam_data(lines, data, const);