% This is a code for the nonlinear problem of heat exchange.
% There will more input data.

function []=Main_MEMS(h_t,h_x,h_y,L_x,L_y,alpha_b,beta,rho)

tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Set up initial data for beams and rods 
beam_nodes = L_x/h_x+1;
x = h_x:h_x:L_x;    
rod_nodes = L_y/h_y+1;
y = 0:h_y:L_y;

% For the temporary 
prev_sigma=1;

%%%%%%For Barber's %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% phi ??
% K??

%Inizitializing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For the rods
prev_u=zeros(rod_nodes,1);
prev_u_t=zeros(rod_nodes,1);
prev_phi=zeros(rod_nodes,1);

next_u=zeros(rod_nodes,1);
next_u_t=zeros(rod_nodes,1);
next_phi=zeros(rod_nodes,1);

% For the beams 
prev_theta=zeros(beam_nodes-1,1);
prev_theta_velo=zeros(beam_nodes-1,1);
prev_w=zeros(beam_nodes-1,1);
prev_w_velo=zeros(beam_nodes-1,1);

next_theta=zeros(beam_nodes-1,1);
next_theta_velo=zeros(beam_nodes-1,1);
next_w=zeros(beam_nodes-1,1);
next_w_velo=zeros(beam_nodes-1,1); % unnecessary preallocation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The intial data
prev_theta=0*x';
prev_theta_velo=zeros(beam_nodes-1,1);
prev_w=0.1*x';
prev_w_velo=zeros(beam_nodes-1,1);

% Initial data including Barber's condition%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%????????
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%Call all the matirces%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For the beam
mat = assemble_beam_matrices(struct('hx', h_x, 'num_nodes', L_x/h_x+1));
B_K = mat.Kb;
B_M = mat.Mb;
B_S = mat.Sb;
% Assemble matirces%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B_33=(1/h_t^2+alpha_b/h_t+1)*B_M+(1+alpha_b/h_t)*B_K;
B_34=-(1+alpha_b/h_t)*B_S';
B_43=-(1+alpha_b/h_t)*B_S;
B_44=(1/h_t^2)*B_M+(1+alpha_b/h_t)*B_K; % without the nonlinear term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For the given data
Beam_given_1=((1/h_t^2+alpha_b/h_t)*B_M+(alpha_b/h_t)*B_K); %for f^k 
Beam_given_2=(1/h_t^2)*B_M+(alpha_b/h_t)*B_K; % for g^k

%size(B_Kw;size(B_Mw);size(B_Sw);
%%%%%%%%%%%%%%%%%%%%%%%%%%Assemble matrices %%%%%%%%%%%%%%%%%%%%%%%
% For assembling matrices for rods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For assembling matrices for beams %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%B_33=(1/h_^2+alpha_b/h_t+1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Start compute the first time step approximations
%for i=1:T/h_t
   
    %%%%For Barber's codition%%%%%%%%%%%%%%%%
    %r^k and K?
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %1. Find u^k+1_0 : bottom of the rod
    % and u^k+1_n : the top.
    %2. Then solve u^k+1_n and then apply CCs.
    %3. Then find u^k+1_0 and then we can get w^k+1_0.
    %4. From the transmission  condition, we can solve the nonlinear
    %system, where \sigma_br will be on the last enery.
    %  Use the back substitituion to compute whole next step solutions.
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % For the nonlinear beam
    % For the given terms
    error=1;
    prev_app=prev_w;
    it_count=0;
    
    while abs(error) >10^-6
        
    f_prev=@(x,y,z) Beam_given_1*x+(1/h_t)*B_M*y-(alpha_b/h_t)*B_S'*z; % x=theta, y=theta_t, z=w
    
    g_prev=@(x,y,z) Beam_given_2*x+(1/h_t)*B_M*y-(alpha_b/h_t)*B_S*y...
             -(1/2)*(beta+rho*x'*B_K*x)*B_K*x+[zeros(length(x)-1,1);prev_sigma]; % x=w, y=w_t and y=theta_t?, z unused
    
    %For the nonlinear system
    % x is w^(k+1)
    Nonlinear_F = @(x) (B_44-(1/2)*(beta+rho*x'*B_K*x)*B_K)*x... % Should N be added instead of subtracted?
        -B_43*(B_33\(B_34*x))+B_43*(B_33\f_prev(prev_theta,prev_theta_velo,prev_w))... % combine mldivides?
        -g_prev(prev_w,prev_theta,prev_w_velo);
    
    Jac = @(x) (1/h_t^2)*B_M+(1+alpha_b/h_t)*B_K+2*(B_K*x)*(B_K*x)'+(x'*B_K*x)*B_K; % Missing terms? Sub B44
    % for the Netwon's iterative formula x is each step app.
    % x=ones(length(prev_w),1)
    %size(B_K);size(f_prev);size(g_prev);size(x)
    
    [L,U]=lu(Jac(prev_app));
     
    next_app=prev_app-U\(L\Nonlinear_F(prev_app));
    error = norm(next_app-prev_app,2)
    prev_app=next_app;
    it_count=it_count+1;
     
    end
    % next_app is approximation of next_w
    % For the angle
    next_theta=B_33\(f_prev(prev_theta,prev_theta_velo,prev_w)-B_34*next_app);
    
    next_theta_velo=(1/h_t)*(next_theta-prev_theta);
    next_w_velo=(1/h_t)*(next_app-prev_w);
    figure(1)
    plot(x,next_theta_velo);
    hold on
    plot(x,next_theta,'r');
    
    figure(2)
    plot(x,next_w_velo);
    hold on
    plot(x,next_w,'r'); % next_w hasn't been reassigned
         
end
 


