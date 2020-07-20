%calc_forest_example: Calculating exemplary numbers for forest example in Markov framework for RL lecture
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Oliver Wallscheid
% email: wallscheid@lea.upb.de
% March 2020; Last revision: 05-March-2020
%------------- BEGIN CODE --------------
clear all;

%% General model parameters
gamma = 0.8; %discount factor
alpha = 0.2; %disaster probability

%% Markov Decision Process Example:  ('fifty-fifty' policy)

%State-value given the policy
P_pe = [0 (1-alpha)/2 0 (1+alpha)/2; 0 0 (1-alpha)/2 (1+alpha)/2; 0 0 (1-alpha)/2 (1+alpha)/2; 0 0 0 1]; %Transistion matrix
r_pe = [0.5; 1; 2; 0]; %reward vector
v_pe = (eye(length(r_pe)) - gamma*P_pe)\r_pe; %Solving linear eq. for state-values

%% Iterative Policy Evaluation

v_ii = [0; 0; 0; 0];
for ii=2:15
    v_ii(:,ii) = r_pe + gamma*P_pe* v_ii(:,ii-1);
end


%% Iterative Policy Evaluation with "in place" updates

v_ip = [0; 0; 0; 0];
for ii=2:5
    v_ip(:,ii) = v_ip(:,ii-1);
    v_ip(4,ii) = 0; %In-place Update state x=4
    v_ip(3,ii) = 0.5*(3+gamma*v_ip(4,ii)) + 0.5*(1+gamma*(1-alpha)*v_ip(3,ii) + gamma*alpha*v_ip(4,ii)); %In-place Update state x=3  
    v_ip(2,ii) = 0.5*(2+gamma*v_ip(4,ii)) + 0.5*gamma*((1-alpha)*v_ip(3,ii) + alpha*v_ip(4,ii)); %In-place Update state x=2 
    v_ip(1,ii) = 0.5*(1+gamma*v_ip(4,ii)) + 0.5*gamma*((1-alpha)*v_ip(2,ii) + alpha*v_ip(4,ii)); %In-place Update state x=1  
    
end

%% Policy Iteration with full policy evaluation steps

%Model for cutting
P_cut = [0 0 0 1; 0 0 0 1; 0 0 0 1; 0 0 0 1]; %Transistion matrix
r_cut = [1; 2; 3; 0]; %reward vector

%Model for waiting
P_wait = [0 1-alpha 0 alpha; 0 0 1-alpha alpha; 0 0 1-alpha alpha; 0 0 0 1]; %Transistion matrix
r_wait = [0; 0; 1; 0]; %reward vector

%Initial policy (fifty-fity)
u_pi = [1; 1; 1; 1]; %0=cut, 1 = wait;

for ii = 1:5
    %Calculate reward and transistion probability for current policy
    P_pi(:,:,ii) = u_pi(:,ii).*P_wait + (1-u_pi(:,ii)).*P_cut;
    r_pi(:,ii) = u_pi(:,ii).*r_wait + (1-u_pi(:,ii)).*r_cut;
    
    %Policy evaluation step
    v_pi(:,ii) = (eye(length(r_pi(:,ii))) - gamma*P_pi(:,:,ii))\r_pi(:,ii); %Solving linear eq. for state-values
    
    %Policy improvement step
    [buf, u_pi(1,ii+1)] = max([r_cut(1)+gamma*P_cut(1,4)*v_pi(4,ii) r_wait(1)+gamma*P_wait(1,2)*v_pi(2,ii)]); %evaluate arg max to state x = 1
    u_pi(1,ii+1) = u_pi(1,ii+1)-1; % shift action to [0,1]
    [buf, u_pi(2,ii+1)] = max([r_cut(2)+gamma*P_cut(2,4)*v_pi(4,ii) r_wait(2)+gamma*P_wait(2,3)*v_pi(3,ii)]); %evaluate arg max to state x = 2
    u_pi(2,ii+1) = u_pi(2,ii+1)-1; % shift action to [0,1]
    [buf, u_pi(3,ii+1)] = max([r_cut(3)+gamma*P_cut(3,4)*v_pi(4,ii) r_wait(3)+gamma*P_wait(3,3)*v_pi(3,ii)]); %evaluate arg max to state x = 3
    u_pi(3,ii+1) = u_pi(3,ii+1)-1; % shift action to [0,1]
    u_pi(4,ii+1) = 0.5; % dummy action for state x=4 (no impact to the rest of the model)
    
end

%% Value iteration

v_ve = [0; 0; 0; 0];
for ii=2:5
    v_ve(:,ii) = v_ve(:,ii-1);
    v_ve(4,ii) = 0; %Value iteration for x =4 
    v_ve(3,ii) = max([r_cut(3)+gamma*P_cut(3,4)*v_ve(4,ii) r_wait(3)+gamma*P_wait(3,3)*v_ve(3,ii)]); %Value iteration for x =3 
    v_ve(2,ii) = max([r_cut(2)+gamma*P_cut(2,4)*v_ve(4,ii) r_wait(2)+gamma*P_wait(2,3)*v_ve(3,ii)]); %Value iteration for x =2 
    v_ve(1,ii) = max([r_cut(1)+gamma*P_cut(1,4)*v_ve(4,ii) r_wait(1)+gamma*P_wait(1,2)*v_ve(2,ii)]); %Value iteration for x =1  
    
end