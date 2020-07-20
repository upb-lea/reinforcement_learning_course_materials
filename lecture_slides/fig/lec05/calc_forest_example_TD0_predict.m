%calc_forest_example: Calculating exemplary prediction  trajectories for temporal-difference reinforcement learning applied to the forst tree example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Oliver Wallscheid
% email: wallscheid@lea.upb.de
% March 2020; Last revision: 25-March-2020
%------------- BEGIN CODE --------------
clear all;
close all;
save_plot = 1; %1 = plot saves to harddrive

alpha = 0.2; %Desaster faktor
gamma = 0.8; %Discount facot
num_episodes = 500; %number of simulated episodes
num_trials = 1000; %number of trials

%% Initals 
%policy (fifty-fifty)
p(1,1) = 0.5; %probability of u=cut at state = 1
p(1,2) = 0.5; %probability of u=wait at state = 1

p(2,1) = 0.5; %probability of u=cutt at state = 2
p(2,2) = 0.5; %probability of u=wait at state = 2

p(3,1) = 0.5; %probability of u=cut at state = 3
p(3,2) = 0.5; %probability of u=wait at state = 3

%state-value estimates
v(1) = 0; %state = 1
v(2) = 0; %state = 2
v(3) = 0; %state = 3
v(4) = 0; %state = 4



%% Graphical Output

fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 8; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 14; %width in cm
FigH = 6.25; %height in cm
fig.color.ciplot = [0.6 1 1];
fig.color.mean = [1 0 0];
fig.Linewidth.mean = 1;

fig.fh(end+1) = figure('NumberTitle', 'off', 'name', 'Plot mean and confidence interval of forest tree MC off-policy control', 'Resize', 'off', 'RendererMode', 'manual');
set(fig.fh(end),'PaperPositionMode','manual','PaperUnits','centimeters','Units','centimeters', 'PaperType', 'A4', 'Renderer', 'opengl');
set(fig.fh(end),'defaulttextinterpreter','latex',...
            'DefaultAxesFontSize',fig.PaperFontSize,...
            'DefaultTextFontSize',fig.PaperFontSize,...
            'DefaultTextFontName',fig.PaperFont,...
            'DefaultAxesFontName',fig.PaperFont,...
            'PaperSize',[FigW FigH],...
            'PaperPosition',[0,0,FigW,FigH],...
            'Position',[1,1,FigW,FigH]);

alpha_TD=0.2;
v = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes);
fig.sp(end+1) = subplot(3,3,1);
hold on;
grid on;
box on;
ciplot(v.v1_lower, v.v1_upper, 1:length(v.v1_lower), fig.color.ciplot);
plot(v.v1_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=1)$');
line([0 num_episodes], [1.121 1.121], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 1.5], 'xlim', [0 num_episodes]);

fig.sp(end+1) = subplot(3,3,2);
hold on;
grid on;
box on;
ciplot(v.v2_lower,v.v2_upper, 1:length(v.v2_lower), fig.color.ciplot);
plot(v.v2_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=2)$');
line([0 num_episodes], [1.941 1.941], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 2.5], 'xlim', [0 num_episodes]);
title(['$\alpha_{TD}=$' num2str(alpha_TD)]);

fig.sp(end+1) = subplot(3,3,3);
hold on;
grid on;
box on;
ciplot(v.v3_lower,v.v3_upper, 1:length(v.v3_lower), fig.color.ciplot);
plot(v.v3_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=3)$');
line([0 num_episodes], [2.941 2.941], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 3.5], 'xlim', [0 num_episodes]);

alpha_TD=0.1;
v = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes);
fig.sp(end+1) = subplot(3,3,4);
hold on;
grid on;
box on;
ciplot(v.v1_lower, v.v1_upper, 1:length(v.v1_lower), fig.color.ciplot);
plot(v.v1_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=1)$');
line([0 num_episodes], [1.121 1.121], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 1.5], 'xlim', [0 num_episodes]);


fig.sp(end+1) = subplot(3,3,5);
hold on;
grid on;
box on;
ciplot(v.v2_lower,v.v2_upper, 1:length(v.v2_lower), fig.color.ciplot);
plot(v.v2_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=2)$');
line([0 num_episodes], [1.941 1.941], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 2.5], 'xlim', [0 num_episodes]);
title(['$\alpha_{TD}=$' num2str(alpha_TD)]);

fig.sp(end+1) = subplot(3,3,6);
hold on;
grid on;
box on;
ciplot(v.v3_lower,v.v3_upper, 1:length(v.v3_lower), fig.color.ciplot);
plot(v.v3_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=3)$');
line([0 num_episodes], [2.941 2.941], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 3.5], 'xlim', [0 num_episodes]);

alpha_TD=0.05;
v = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes);
fig.sp(end+1) = subplot(3,3,7);
hold on;
grid on;
box on;
ciplot(v.v1_lower, v.v1_upper, 1:length(v.v1_lower), fig.color.ciplot);
plot(v.v1_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=1)$');
line([0 num_episodes], [1.121 1.121], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 1.5], 'xlim', [0 num_episodes]);
xlabel('Episodes');


fig.sp(end+1) = subplot(3,3,8);
hold on;
grid on;
box on;
ciplot(v.v2_lower,v.v2_upper, 1:length(v.v2_lower), fig.color.ciplot);
plot(v.v2_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=2)$');
line([0 num_episodes], [1.941 1.941], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 2.5], 'xlim', [0 num_episodes]);
title(['$\alpha_{TD}=$' num2str(alpha_TD)]);
xlabel('Episodes');

fig.sp(end+1) = subplot(3,3,9);
hold on;
grid on;
box on;
ciplot(v.v3_lower,v.v3_upper, 1:length(v.v3_lower), fig.color.ciplot);
plot(v.v3_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{v}_{\pi}(x=3)$');
line([0 num_episodes], [2.941 2.941], 'Color','Magenta','LineStyle','--');
set(fig.sp(end), 'ylim', [0 3.5], 'xlim', [0 num_episodes]);
xlabel('Episodes');

 if save_plot ==1
        FigName = ['Forest_Tree_TD0_Prediction.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end


%% TD(0) state-value estimation

function [v] = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes)
    for ee = 1:num_trials

        v = zeros(4,1);

        for ii = 1:num_episodes

            [x, u, r] = Forest_Episode(p, alpha); %Generate a sequence following pi from x=1 as initial state

            for jj = 1:1:length(r)
                     v(x(jj)) = v(x(jj)) + alpha_TD*(r(jj) + gamma*v(x(jj+1)) - v(x(jj))); 
            end
            v1(ee,ii) = v(1);
            v2(ee,ii) = v(2);
            v3(ee,ii) = v(3);
            v4(ee,ii) = v(4);
        end

    end

    % means
    v1_mean = mean(v1,1);
    v2_mean = mean(v2,1);
    v3_mean = mean(v3,1);

    % upper bound (+ std)
    v1_lower = v1_mean-std(v1,0,1);
    v2_lower = v2_mean-std(v2,0,1);
    v3_lower = v3_mean-std(v3,0,1);

    % upper bound (- std)
    v1_upper = v1_mean+std(v1,0,1);
    v2_upper = v2_mean+std(v2,0,1);
    v3_upper = v3_mean+std(v3,0,1);

v = struct('v1_mean', v1_mean, 'v2_mean', v2_mean, 'v3_mean', v3_mean, 'v1_lower', v1_lower, 'v2_lower', v2_lower, 'v3_lower', v3_lower, 'v1_upper', v1_upper, 'v2_upper', v2_upper, 'v3_upper', v3_upper);
end
%% Simulation env. for forest tree MDP
function [x, u, r] = Forest_Episode(p, alpha)
    %p = policy
    %x = array of visited states
    %u = array of picked actions
    %r = array of recieved rewards

    x = 1; %always starting in first state
    u = [];
    r = [];

    while x ~= 4
        if  p(x(end),1) > rand %pick action
            u(end+1) =1; %cut
        else
            u(end+1) =2; %wait
        end
        
        switch x(end) %query current state and reward
            case 1 
                if u(end)==1
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
                if u(end)==1
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
                if u(end)==1
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