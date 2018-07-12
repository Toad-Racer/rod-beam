function loads = loading_vectors(current_data, const)
    %{
     Constructs the rod's loading vector for the current time step as
     specified in the manuscript.

     @param    current_data    A struct with fields for each of the system's
                               functions (u, ut, phi, theta, theta_t, w, 
                               and wt) containing their values for the 
                               current time step.
     @param    const           A struct with fields for all the constants
                               relevant to the simulation. See set_constants.m
                               for a full list.
     @return    f    The system's loading vector for the current time step as
                     specified in the manuscript (though without stress terms).
    %}
    % loads for u. vector of size n+1. Missing stress terms
    loads.f1 = (1/const.ht^2*const.Md-(1/2-const.alpha_d/const.ht)*const.Kd)*current_data.u ...
         + 1/const.ht*const.Md*current_data.ut + const.eta_d/2*const.Sd(:, 2:end)*current_data.phi;
    % loads for phi. vector of size n. q is considered to be 0
    loads.f2 = ((1/const.ht-const.zeta_d/2)*const.Md(2:end, 2:end)... 
         -const.kappa_th/2*const.Kd(2:end, 2:end))*current_data.phi ...
         + const.eta_d/(2*const.ht)*const.Sd(:, 2:end)'*current_data.u ...
         - const.eta_d/2*const.Sd(:, 2:end)'*current_data.ut;
     
     % loads for theta. vector of size n
     loads.f3 = ((1/const.ht^2+const.alpha_b/const.ht)*const.Mb ... 
         + const.alpha_b/const.ht*const.Kb)*current_data.theta ... 
         + 1/const.ht*const.Mb*current_data.theta_t ...
         - const.alpha_b/const.ht*const.Sb'*current_data.w;
     % loads for w. vector of size n. Missing stress term
     loads.f4 = (1/const.ht^2*const.Mb+const.alpha_b/const.ht*const.Kb)*current_data.w ...
         + 1/const.ht*const.Mb*current_data.wt ...
         - const.alpha_b/const.ht*const.Sb*current_data.theta ...
         - N(current_data.w, const);
 