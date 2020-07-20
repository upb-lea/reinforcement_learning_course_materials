%calc_forest_example_q_learning: Calculating exemplary  control trajectories for Q-learning reinforcement learning applied to the forst tree example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Oliver Wallscheid
% email: wallscheid@lea.upb.de
% March 2020; Last revision: 27-March-2020
%------------- BEGIN CODE --------------
clear all;
close all;
save_plot = 0; %1 = plot saves to harddrive

alpha = 0.2; %Desaster faktor
alpha_TD = 0.1;
gamma = 0.8; %Discount facor
eps = 0.2; %epsilon-greedy factor
num_trials = 50; %number of trials
num_epsiodes = 10000; %number of episodes per trial
%% Initals 
%policy (fifty-fifty)
p(1,1) = 0.5; %probability of u=cut at state = 1
p(1,2) = 0.5; %probability of u=wait at state = 1

p(2,1) = 0.5; %probability of u=cutt at state = 2
p(2,2) = 0.5; %probability of u=wait at state = 2

p(3,1) = 0.5; %probability of u=cut at state = 3
p(3,2) = 0.5; %probability of u=wait at state = 3

%% Off-policy q-learning control


for ee = 1:num_trials

    q = zeros(3,2);
    p = ones(3,2)*0.5;

    for ii = 1:num_epsiodes

        x = 1; %always start at x=1
        while x~= 4 %terminate state?
            
            u = Forest_action(x, p);
            [x_next, r] = Forest_step(x, u, alpha);
            if x_next ~= 4 %Is next step terminal?
                q_max = max(q(x_next, :));
                q(x,u) = q(x,u) + alpha_TD*(r + gamma*q_max  - q(x,u));
            else
                q(x,u) = q(x,u) + alpha_TD*(r + gamma*0 - q(x,u));
            end
            
            %eps-greedy improvement
            [q_max, q_pos] = max(q(x, :));
            p(x,q_pos) = 1-eps/2;
            p(x, 2-q_pos+1) = eps/2;
            
            x = x_next;
        end
 
        q11(ee,ii) = q(1,1);
        q12(ee,ii) = q(1,2);
        q21(ee,ii) = q(2,1);
        q22(ee,ii) = q(2,2);
        q31(ee,ii) = q(3,1);
        q32(ee,ii) = q(3,2);
        
        p11(ee,ii) = p(1,1);
        p12(ee,ii) = p(1,2);
        p21(ee,ii) = p(2,1);
        p22(ee,ii) = p(2,2);
        p31(ee,ii) = p(3,1);
        p32(ee,ii) = p(3,2);
    end
 
end

% means
q12_mean = mean(q12,1);
q22_mean = mean(q22,1);
q32_mean = mean(q32,1);
q11_mean = mean(q11,1);
q21_mean = mean(q21,1);
q31_mean = mean(q31,1);

p12_mean = mean(p12,1);
p22_mean = mean(p22,1);
p32_mean = mean(p32,1);

% lower bound
q12_lower = q12_mean-std(q12,0,1);
q22_lower = q22_mean-std(q22,0,1);
q32_lower = q32_mean-std(q32,0,1);

p12_lower = p12_mean-std(p12,0,1);
p22_lower = p22_mean-std(p22,0,1);
p32_lower = p32_mean-std(p32,0,1);

% upper bound
q12_upper = q12_mean+std(q12,0,1);
q22_upper = q22_mean+std(q22,0,1);
q32_upper = q32_mean+std(q32,0,1);

p12_upper = p12_mean+std(p12,0,1);
p22_upper = p22_mean+std(p22,0,1);
p32_upper = p32_mean+std(p32,0,1);

%% Graphical Output

fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 8; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r700'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 14; %width in cm
FigH = 5.0; %height in cm
fig.color.ciplot = [0.6 1 1];
fig.color.mean = [1 0 0];
fig.Linewidth.mean = 2;

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

fig.sp(end+1) = subplot(2,3,1);
hold on;
grid on;
box on;
ciplot(q12_lower,q12_upper, 1:length(q12_lower), fig.color.ciplot);
plot(q12_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{q}_{\pi}(x=1, u=\mbox{w})$');
set(fig.sp(end), 'ylim', [0 2], 'xlim', [0 num_epsiodes]);

fig.sp(end+1) = subplot(2,3,2);
hold on;
grid on;
box on;
ciplot(q22_lower,q22_upper, 1:length(q22_lower), fig.color.ciplot);
plot(q22_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{q}_{\pi}(x=2, u=\mbox{w})$');
set(fig.sp(end), 'ylim', [0 3], 'xlim', [0 num_epsiodes]);

fig.sp(end+1) = subplot(2,3,3);
hold on;
grid on;
box on;
ciplot(q32_lower,q32_upper, 1:length(q32_lower), fig.color.ciplot);
plot(q32_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{q}_{\pi}(x=3, u=\mbox{w})$');
set(fig.sp(end), 'ylim', [0 4], 'xlim', [0 num_epsiodes]);

fig.sp(end+1) = subplot(2,3,4);
hold on;
grid on;
box on;
ciplot(p12_lower,p12_upper, 1:length(p12_lower), fig.color.ciplot);
plot(p12_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=1)$');
xlabel('Episodes');
set(fig.sp(end), 'xlim', [0 num_epsiodes]);

fig.sp(end+1) = subplot(2,3,5);
hold on;
grid on;
box on;
ciplot(p22_lower,p22_upper, 1:length(p22_lower), fig.color.ciplot);
plot(p22_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=2)$');
xlabel('Episodes');
set(fig.sp(end), 'xlim', [0 num_epsiodes]);

fig.sp(end+1) = subplot(2,3,6);
hold on;
grid on;
box on;
ciplot(p32_lower,p32_upper, 1:length(p32_lower), fig.color.ciplot);
plot(p32_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=3)$');
xlabel('Episodes');
set(fig.sp(end), 'xlim', [0 num_epsiodes]);

 if save_plot ==1
        FigName = ['Forest_Tree_Sarsa_alpha_' num2str(alpha_TD) '.png'];
    if exist([fig.folder FigName]) == 0
            print('-dpng','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpng', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end


%% Simulation env. for forest tree MDP

function [u] = Forest_action(x, p)
 if x ~= 4
        if  p(x,1) > rand %pick action
            u =1; %cut
        else
            u =2; %wait
        end
 end
end

function [x_next, r] = Forest_step(x, u, alpha)

    switch x %query current state and reward
        case 1 
            if u==1
                x_next = 4;
                r = 1;
            else
                 r = 0;
                if (rand(1) < alpha)
                   x_next = 4;
                else
                   x_next = 2;
                end
            end  
        case 2 
            if u==1
                x_next = 4;
                r = 2;
            else
                 r = 0;
                if (rand(1) < alpha)
                   x_next = 4;
                else
                   x_next = 3;
                end
            end
        case 3 
            if u==1
                x_next = 4;
                r = 3;
            else
                r = 1;
                if (rand(1) < alpha)
                   x_next = 4;
                else
                   x_next = 3;
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