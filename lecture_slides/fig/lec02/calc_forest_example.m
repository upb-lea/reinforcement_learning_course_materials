%calc_forest_example: Calculating exemplary numbers for forest example in Markov framework for RL lecture
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Oliver Wallscheid
% email: wallscheid@lea.upb.de
% Feb 20202; Last revision: 18-Feb-2020
%------------- BEGIN CODE --------------

%% General model parameters
gamma = 0.8; %discount factor
alpha = 0.2; %disaster probability

%% Markov Reward Process Example

P = [0 1-alpha 0 alpha; 0 0 1-alpha alpha; 0 0 1-alpha alpha; 0 0 0 1]; %Transistion matrix
r = [1; 2; 3; 0]; %reward vector
v = (eye(length(r)) - gamma*P)\r; %Solving linear eq. for state-values

%% Markov Decision Process Example:  ('fifty-fifty' policy)

%State-value given the policy
P_pi = [0 (1-alpha)/2 0 (1+alpha)/2; 0 0 (1-alpha)/2 (1+alpha)/2; 0 0 (1-alpha)/2 (1+alpha)/2; 0 0 0 1]; %Transistion matrix
r_pi = [0.5; 1; 2; 0]; %reward vector
v_pi = (eye(length(r_pi)) - gamma*P_pi)\r_pi; %Solving linear eq. for state-values

%Action-value for cutting
P_cut = [0 0 0 1; 0 0 0 1; 0 0 0 1; 0 0 0 1]; %Transistion matrix
r_cut = [1; 2; 3; 0]; %reward vector
q_cut = (eye(length(r_cut)) - gamma*P_cut)\r_cut; %Solving linear eq. for action-values

%Action-value for waiting
P_wait = [0 1-alpha 0 alpha; 0 0 1-alpha alpha; 0 0 1-alpha alpha; 0 0 0 1]; %Transistion matrix
r_wait = [0; 0; 1; 0]; %reward vector
q_wait = (eye(length(r_wait)) - gamma*P_wait)\r_wait; %Solving linear eq. for action-values

%% Markov Decision Process Example:  Optimal policy


fun = @(x)MDP_State_Value(x,gamma,alpha);
v0_opt = [1,1,1];
v_opt = fminsearch(fun,v0_opt);

fun = @(x)MDP_Action_Value(x,gamma,alpha);
q0_opt = [1,1,1];
q_opt = fminsearch(fun,q0_opt);

function f = MDP_State_Value(x, gamma, alpha)
    % x(1) = v*(x=1), x(2) = v*(x=2), x(3) = v*(x=3)
    f1 = x(1) - max([gamma*(1-alpha)*x(2) 1]);
    f2 = x(2) - max([gamma*(1-alpha)*x(3) 2]);
    f3 = x(3) - max([1+gamma*(1-alpha)*x(3) 3]);
    
    f = f1^2+f2^2+f3^2;
end

function f = MDP_Action_Value(x, gamma, alpha)
    %x(1) = q*(x=1, u=w), x(2) = q*(x=2, u=w), x(3) = q*(x=3, u=w) 
    f1 = x(3) - 1- gamma*(1-alpha)*max([3 x(3)]);
    f2 = x(2) - gamma*(1-alpha)*max([3 1+gamma*(1-alpha)*x(3)]);
    f3 = x(1) - gamma*(1-alpha)*max([2 gamma*(1-alpha)*max([3 1+gamma*(1-alpha)*x(3)])]);
    
    f = f1^2+f2^2+f3^2;
end
