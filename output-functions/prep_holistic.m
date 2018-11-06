function lines = prep_holistic(initial_data, const, visibility)
    % Stress on Rod's top
    f1 = figure;
    f1.OuterPosition = [50 50 500 250];
    title('Stress on Rod''s Top');
    axis([0, const.T, -inf, inf]);
    lines.sigma_dt = animatedline('Color', 'r');

    % Energy
    f2 = figure;
    f2.OuterPosition = [50 300 500 250];
    title('Energy in System');
    axis([0, const.T, -inf, inf]);
    lines.energy = animatedline('Color', 'r');

    % Tip of rod
    f3 = figure;
    f3.OuterPosition = [50 550 500 250];
    title('Tip of Rod');
    lines.tip = animatedline('Color', 'b');

    set(f1, 'Visible', visibility);
    set(f2, 'Visible', visibility);
    set(f3, 'Visible', visibility);
    lines.figs = [f1; f2; f3];