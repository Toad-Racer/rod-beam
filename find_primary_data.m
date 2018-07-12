function primary_data = find_primary_data(prev_data, const)
    %{
     Solves for the rod's primary data (u and phi) at the current time step.
     Since this simulation currently ignores contact and the beam, the 
     linear system is simply solved using mldivide. 

     @param    prev_data       A struct with fields for the primary and
                               derived data of the previous time step. See
                               add_derived_data.m for a full list.
     @param    const           A struct with the field num_nodes containg
                               the number of nodes on the rod's domain
                               (counting nodes at y=0 and y=Ly as well as
                               all interior nodes).
     @return    data    A struct containing the system's primary data 
                        (u, phi, theta, and w) at the current time-step.
                        Can be passed to any function in this project with
                        a primary_data parameter.
    %}
%     % add stresses to loading vector
%     prev_data.f1(1) = prev_data.f1(1) + prev_data.sigma_db;
%     prev_data.f1(end) = prev_data.f1(end) + prev_data.sigma_dt;
%     
%     % solve for primary data
%     u = current_rod_matrix(prev_data, const)\[prev_data.f1; prev_data.f2];
    

    rod_system = current_condensed_system(prev_data, const);
    primary_data = find_beam_data(prev_data, const, [rod_system.matrix(1, 1), -rod_system.loads(1)]);
    sigma_db = rod_system.matrix(1, 1)*primary_data.w(end)-rod_system.loads(1);
    u = rod_system.matrix\(rod_system.loads+[sigma_db; zeros(length(rod_system.loads)-1, 1)]);
    u = swap_rows(u, 2, const.num_nodes);
    u = swap_rows(u, 3, length(u));

    
    % split primary data into vectors for u and phi
    primary_data.u = u(1:const.num_nodes);
    primary_data.phi = u(const.num_nodes+1:end);

%     primary_data = merge_structs(primary_data, ...
%         find_beam_data(prev_data, const, prev_data.sigma_db));