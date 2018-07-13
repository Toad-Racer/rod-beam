function output_data(data, const, plot_fn, log_fns)
    if log_fns ~= false
        disp('---------------');
        for msg = keys(log_fns)
            disp(msg);
            fn = log_fns(cell2mat(msg));
            disp(fn(data, const));
        end
    end
    
    plot_fn(data, const);
