function lines = prep_holistic(initial_data, const)
    % Stress on Rod's top
    f1 = figure(11);
    f1.OuterPosition = [50 50 500 250];
    clf('reset');
    title('Stress on Rod''s Top');
    axis([0, const.T, -inf, inf]);
    lines.sigma_dt = animatedline('Color', 'r');

    % Energy
    f2 = figure(12);
    f2.OuterPosition = [50 300 500 250];
    clf('reset');
    title('Energy in System');
    axis([0, const.T, -inf, inf]);
    lines.energy = animatedline('Color', 'r');

    % Tip of rod
    f3 = figure(13);
    f3.OuterPosition = [50 550 500 250];
    clf('reset');
    title('Tip of Rod');
    axis([0, const.T, -inf, 2*const.gap]);
    lines.tip = animatedline('Color', 'b');
