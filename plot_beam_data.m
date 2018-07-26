function plot_beam_data(lines, data, const)
    x = const.hx:const.hx:1;
    
    clearpoints(lines.w);
    addpoints(lines.w, x, full(data.w));
    clearpoints(lines.wt);
    addpoints(lines.wt, x, full(data.wt));
    
    drawnow;