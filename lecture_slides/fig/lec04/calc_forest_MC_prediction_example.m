%calc_forest_example: Calculating exemplary prediction  trajectories for Monte Carlo reinforcement learning applied to the forst tree example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Oliver Wallscheid
% email: wallscheid@lea.upb.de
% March 2020; Last revision: 20-March-2020
%------------- BEGIN CODE --------------
clear all;
close all;
save_plot = 1; %1 = plot saves to harddrive

alpha = 0.2; %Desaster faktor
gamma = 0.8; %Discount facot
num_episodes = 201; %number of simulated episodes
num_trials = 2000; %number of trials

%% Estimate value of initial state x0 = 1 for a number of trials
v_MC = [];
for tt = 1:num_trials

    v_MC(tt,1) = 0;
    for ii=2:num_episodes
        [x, u, r] = Forest_50_50(1, alpha);
        g = 0;
        for jj = length(r):-1:1
            g = gamma*g + r(jj);
        end
        v_MC(tt,ii) = v_MC(tt,ii-1) + 1/(ii)*(g - v_MC(tt,ii-1));
    end
end

%% Plot mean and confidence interval of v_MC estimate

for ii=1:length(v_MC(1,:))
    v_MC_mean(ii) = mean(v_MC(:,ii)); %mean of value estimate at each episode over num_trials
    v_MC_lower(ii) = v_MC_mean(ii)-std(v_MC(:,ii)); %5-percent percentile of value estimate at each episode over num_trials
    v_MC_upper(ii) = v_MC_mean(ii)+std(v_MC(:,ii)); %95-percent percentile of value estimate at each episode over num_trials
end



%% Graphical Output

fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 10; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 9; %width in cm
FigH = 6; %height in cm

fig.fh(end+1) = figure('NumberTitle', 'off', 'name', 'Plot mean and confidence interval of v_MC estimate', 'Resize', 'off', 'RendererMode', 'manual');
set(fig.fh(end),'PaperPositionMode','manual','PaperUnits','centimeters','Units','centimeters', 'PaperType', 'A4', 'Renderer', 'opengl');
set(fig.fh(end),'defaulttextinterpreter','latex',...
            'DefaultAxesFontSize',fig.PaperFontSize,...
            'DefaultTextFontSize',fig.PaperFontSize,...
            'DefaultTextFontName',fig.PaperFont,...
            'DefaultAxesFontName',fig.PaperFont,...
            'PaperSize',[FigW FigH],...
            'PaperPosition',[0,0,FigW,FigH],...
            'Position',[1,1,FigW,FigH]);
        
hold on;
grid on;
box on;
ciplot(v_MC_lower(2:end),v_MC_upper(2:end), 1:length(v_MC_upper(2:end)), [0.6 1 1]);
plot(v_MC_mean(2:end), 'r', 'LineWidth',2);
xlabel('Number of episodes');
ylabel('$\hat{v}_{\pi}(x=1)$');
fig.lg = legend('std.', 'mean');
set(fig.lg(end), 'Interpreter', 'Latex', 'Location', 'SouthEast');

 if save_plot ==1
        FigName = ['Forest_Tree_MC_Value_Prediction.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end

%% Simulation env. for forest tree MDP with 50-50 policy
function [x, u, r] = Forest_50_50(x0, alpha)
    %x0 = starting state
    %x = array of visited states
    %u = array of picked actions
    %r = array of recieved rewards

    x = x0;
    u = [];
    r = [];

    while x ~= 4
        u(end+1) = randi([0 1]); % 0= wait, 1 = cut
        switch x(end) %query current state
            case 1 
                if u(end)
                    x(end+1) = 4;
                    r(end+1) = 1;
                else
                     r(end+1) = 0;
                    if (rand(1) < alpha)
                       x(end+1) = 4;
                    else
                       x(end+1) = 2;
                    end
                end  
            case 2 
                if u(end)
                    x(end+1) = 4;
                    r(end+1) = 2;
                else
                     r(end+1) = 0;
                    if (rand(1) < alpha)
                       x(end+1) = 4;
                    else
                       x(end+1) = 3;
                    end
                end
            case 3 
                if u(end)
                    x(end+1) = 4;
                    r(end+1) = 3;
                else
                    r(end+1) = 1;
                    if (rand(1) < alpha)
                       x(end+1) = 4;
                    else
                       x(end+1) = 3;
                    end
                end
        end
    end
end

%% Plot confidence intervals
function ciplot(lower,upper,x,colour)
     
% ciplot(lower,upper)       
% ciplot(lower,upper,x)
% ciplot(lower,upper,x,colour)
%
% Plots a shaded region on a graph between specified lower and upper confidence intervals (L and U).
% l and u must be vectors of the same length.
% Uses the 'fill' function, not 'area'. Therefore multiple shaded plots
% can be overlayed without a problem. Make them transparent for total visibility.
% x data can be specified, otherwise plots against index values.
% colour can be specified (eg 'k'). Defaults to blue.
% Raymond Reynolds 24/11/06
    if length(lower)~=length(upper)
        error('lower and upper vectors must be same length')
    end
    if nargin<4
        colour='b';
    end
    if nargin<3
        x=1:length(lower);
    end
    % convert to row vectors so fliplr can work
    if find(size(x)==(max(size(x))))<2
    x=x'; end
    if find(size(lower)==(max(size(lower))))<2
    lower=lower'; end
    if find(size(upper)==(max(size(upper))))<2
    upper=upper'; end
    fill([x fliplr(x)],[upper fliplr(lower)],colour)
end