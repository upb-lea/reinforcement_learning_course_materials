clc
clear all
close all

%% General Settings

% Discount factor
gamma = 0.9; 

% Perform standard scaling on all features [true/false(default)]
opt.scaling = false;

%% Read and prepare data

% Read csv data
T = readtable('DummyPolicy_History.csv');

% Extract plain state vector at index k [n x 2]
x_k = [T.pos_k T.vel_k];

% Extract plain state vector at index k+1 [n x 2]
x_k1 = [T.pos_k_1 T.vel_k_1];

% Extract reward vector [n x 1]
r = [T.reward];

% Extract done flag and convert to binary 
done = strcmp(T.done,'True');


%% Formulate and solve OLS problem 

% Copy
x_k_feat = FeatureEng(x_k, opt);
x_k1_feat = FeatureEng(x_k1, opt);

% Override x_k1_feat feature vector such that it is zero when terminating the episode
x_k1_feat(done == 1,:) = 0;

% Regressor matrix according to TD(0) update
Xi = x_k_feat - gamma*x_k1_feat;

% Target vector
y = r;

% Calculate parameter vector based on OLS solution
w_OLS = Xi \ y;

%% Visual inspection of OLS solution

% Prepare canvas grid (interpolation points)
interp_steps = 100;
pos_vec = linspace(-1.2, 0.5, interp_steps);%linspace(min(T.pos_k), max(T.pos_k), interp_steps);
vel_vec = linspace(-0.07, 0.07, interp_steps);
[dx, dy] = meshgrid(pos_vec, vel_vec);

% Get features for canvas grid
Xi_plot = FeatureEng([dx(:) dy(:)], opt);

% Estimate value for cavas grid
v_hat = Xi_plot*w_OLS;

% Rearrange values in matrix form for surf plot
F = scatteredInterpolant(dx(:), dy(:),v_hat);
v_hat_mat = F(dx,dy);

% Execute plotting
figure('Name','OLS');
surf(dx,dy,v_hat_mat);
hold on;
plot3(x_k(:,1), x_k(:,2), FeatureEng([x_k(:,1) x_k(:,2)], opt)*w_OLS, 'o', 'Color', 'r');
xlabel('Position');
ylabel('Velocity');
zlabel('v');
title('OLS');

%% Formulate and solve RLS problem 

% RLS parameter & init
lambda = 0.99;
w0 = zeros(length(Xi(1,:)),1);
P0 = eye(length(Xi(1,:)))*1;

% Call RLS solver with 'RLS(Xi, y, lambda, w0, P0)'
w_RLS =  RLS(Xi, y, lambda, w0, P0);


%% Visual inspection of RLS solution

% Estimate value for cavas grid
v_hat = Xi_plot*w_RLS;

% Rearrange values in matrix form for surf plot
F = scatteredInterpolant(dx(:), dy(:),v_hat);
v_hat_mat = F(dx,dy);

% Execute plotting
figure('Name','RLS');
surf(dx,dy,v_hat_mat);
hold on;
plot3(x_k(:,1), x_k(:,2), FeatureEng([x_k(:,1) x_k(:,2)], opt)*w_RLS, 'o', 'Color', 'r');
xlabel('Position');
ylabel('Velocity');
zlabel('v');
title(['RLS with \lambda=' num2str(lambda)]);

%% RLS Function

function w = RLS(Xi, y, lambda, w0, P0)

    %Initialize P & w
    P = P0;
    w = w0;
    
    for ii=1:length(Xi(:,1))
        % Get regressor vector of i-th step (column vector)
        xi = Xi(ii,:);

        %Core RLS code
        c = P*xi'/(lambda+xi*P*xi');
        w = w + c*(y(ii) - xi*w);
        P = (eye(length(Xi(1,:))) - c*xi)*P/lambda;
    end
end


%% Feature Engineering Function

%x(:,1) = Position
%x(:,2) = Speed

function Xi = FeatureEng(x, opt)

    % Formulate feature engineered regressor matrix
    Xi = [x(:,1) x(:,2) x(:,2).^2 sin(3*x(:,1))];
    
    % Check if standard scaling is required
    if exist('opt','var') && isstruct(opt)
        if isfield(opt,'scaling') && opt.scaling
            for ii = 1:length(Xi(1,:))
            Xi(:,ii) = (Xi(:,ii)-mean(Xi(:,ii)))/std(Xi(:,ii));
            end
        end
    end
    
    % Add basic regressor xi = 1 
    Xi = [Xi ones(length(x(:,1)),1)];
 
end

    