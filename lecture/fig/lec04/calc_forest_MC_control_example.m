%calc_forest_example: Calculating exemplary  control trajectories for Monte Carlo reinforcement learning applied to the forst tree example
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
eps = 0.2; %epsilon-greedy factor
num_trials = 2000; %number of trials
num_epsiodes = 500; %number of episodes per trial

%% Initals 
%policy (fifty-fifty)
p(1,1) = 0.5; %probability of u=cut at state = 1
p(1,2) = 0.5; %probability of u=wait at state = 1

p(2,1) = 0.5; %probability of u=cutt at state = 2
p(2,2) = 0.5; %probability of u=wait at state = 2

p(3,1) = 0.5; %probability of u=cut at state = 3
p(3,2) = 0.5; %probability of u=wait at state = 3

%action-value estimates
q(1,1) = 0; %state = 1, u = cut
q(1,2) = 0; %state = 1, u = wait

q(2,1) = 0; %state = 2, u = cut
q(2,2) = 0; %state = 2, u = wait

q(3,1) = 0; %state = 3, u = cut
q(3,2) = 0; %state = 3, u = wait

%empty visit list
n = zeros(length(q(:,1)), length(q(1,:)));

%% On-policy first-visit MC constrol using epsilon-greedy

p_mat = [];
q_mat = [];
for ee = 1:num_trials
    n = zeros(3,2);
    q = zeros(3,2);
    p = ones(3,2)*0.5;
    for ii = 1:num_epsiodes
        %eps = 1/ii;
        [x, u, r] = Forest_Episode(p, alpha);
        g = 0;
        for jj = length(r):-1:1
                 g = gamma*g + r(jj);
                 if (~ismember(x(jj), x(1:max([1 jj-1])))) || (x(jj)==1)
                     n(x(jj), u(jj)) = n(x(jj), u(jj))+1;
                     q(x(jj), u(jj)) = q(x(jj), u(jj)) + 1/(n(x(jj), u(jj)))*(g - q(x(jj), u(jj)));
                     [q_max, q_pos] = max(q(x(jj), :));
                     p(x(jj),q_pos) = 1-eps/2;
                     p(x(jj), 2-q_pos+1) = eps/2;
                 end    
        end
        q11(ee,ii) = q(1,1);
        q12(ee,ii) = q(1,2);
        q21(ee,ii) = q(2,1);
        q22(ee,ii) = q(2,2);
        q31(ee,ii) = q(3,1);
        q32(ee,ii) = q(3,2);
        
        n11(ee,ii) = n(1,1);
        n12(ee,ii) = n(1,2);
        n21(ee,ii) = n(2,1);
        n22(ee,ii) = n(2,2);
        n31(ee,ii) = n(3,1);
        n32(ee,ii) = n(3,2);
        
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

n12_mean = mean(n12,1);
n22_mean = mean(n22,1);
n32_mean = mean(n32,1);

p12_mean = mean(p12,1);
p22_mean = mean(p22,1);
p32_mean = mean(p32,1);

% 5 \% percentile
q12_lower = q12_mean-std(q12,0,1);
q22_lower = q22_mean-std(q22,0,1);
q32_lower = q32_mean-std(q32,0,1);

n12_lower = n12_mean-std(n12,0,1);
n22_lower = n22_mean-std(n22,0,1);
n32_lower = n32_mean-std(n32,0,1);

p12_lower = p12_mean-std(p12,0,1);
p22_lower = p22_mean-std(p22,0,1);
p32_lower = p32_mean-std(p32,0,1);

% 95 \% percentile
q12_upper = q12_mean+std(q12,0,1);
q22_upper = q22_mean+std(q22,0,1);
q32_upper = q32_mean+std(q32,0,1);

p12_upper = p12_mean+std(p12,0,1);
p22_upper = p22_mean+std(p22,0,1);
p32_upper = p32_mean+std(p32,0,1);

n12_upper = n12_mean+std(n12,0,1);
n22_upper = n22_mean+std(n22,0,1);
n32_upper = n32_mean+std(n32,0,1);


%% Graphical Output

fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 8; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 13; %width in cm
FigH = 6.5; %height in cm
fig.color.ciplot = [0.6 1 1];
fig.color.mean = [1 0 0];
fig.Linewidth.mean = 2;

fig.fh(end+1) = figure('NumberTitle', 'off', 'name', 'Plot mean and confidence interval of forest tree MC control', 'Resize', 'off', 'RendererMode', 'manual');
set(fig.fh(end),'PaperPositionMode','manual','PaperUnits','centimeters','Units','centimeters', 'PaperType', 'A4', 'Renderer', 'opengl');
set(fig.fh(end),'defaulttextinterpreter','latex',...
            'DefaultAxesFontSize',fig.PaperFontSize,...
            'DefaultTextFontSize',fig.PaperFontSize,...
            'DefaultTextFontName',fig.PaperFont,...
            'DefaultAxesFontName',fig.PaperFont,...
            'PaperSize',[FigW FigH],...
            'PaperPosition',[0,0,FigW,FigH],...
            'Position',[1,1,FigW,FigH]);

fig.sp(end+1) = subplot(3,3,1);
hold on;
grid on;
box on;
ciplot(q12_lower,q12_upper, 1:length(q12_lower), fig.color.ciplot);
plot(q12_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{q}_{\pi}(x=1, u=\mbox{w})$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 1.5]);

fig.sp(end+1) = subplot(3,3,2);
hold on;
grid on;
box on;
ciplot(q22_lower,q22_upper, 1:length(q22_lower), fig.color.ciplot);
plot(q22_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{q}_{\pi}(x=2, u=\mbox{w})$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 2.5]);

fig.sp(end+1) = subplot(3,3,3);
hold on;
grid on;
box on;
ciplot(q32_lower,q32_upper, 1:length(q32_lower), fig.color.ciplot);
plot(q32_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\hat{q}_{\pi}(x=3, u=\mbox{w})$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 3.5]);

fig.sp(end+1) = subplot(3,3,4);
hold on;
grid on;
box on;
ciplot(p12_lower,p12_upper, 1:length(p12_lower), fig.color.ciplot);
plot(p12_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=1)$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 1.2]);

fig.sp(end+1) = subplot(3,3,5);
hold on;
grid on;
box on;
ciplot(p22_lower,p22_upper, 1:length(p22_lower), fig.color.ciplot);
plot(p22_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=2)$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 1.2]);

fig.sp(end+1) = subplot(3,3,6);
hold on;
grid on;
box on;
ciplot(p32_lower,p32_upper, 1:length(p32_lower), fig.color.ciplot);
plot(p32_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=3)$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 1.2]);

fig.sp(end+1) = subplot(3,3,7);
hold on;
grid on;
box on;
ciplot(n12_lower,n12_upper, 1:length(n12_lower), fig.color.ciplot);
plot(n12_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
yticks([0 250 500]);
xlabel('Number of episodes');
ylabel('$n(x=1,u=\mbox{w})$', 'FontSize',6);

fig.sp(end+1) = subplot(3,3,8);
hold on;
grid on;
box on;
ciplot(n22_lower,n22_upper, 1:length(n22_lower), fig.color.ciplot);
plot(n22_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
xlabel('Number of episodes');
ylabel('$n(x=2,u=\mbox{w})$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 100]);

fig.sp(end+1) = subplot(3,3,9);
hold on;
grid on;
box on;
ciplot(n32_lower,n32_upper, 1:length(n32_lower), fig.color.ciplot);
plot(n32_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
xlabel('Number of episodes');
ylabel('$n(x=3,u=\mbox{w})$', 'FontSize',6);
set(fig.sp(end), 'ylim', [0 30]);

for ii=1:length(fig.sp)
    xticks(fig.sp(ii), [0 250 500])
    set(fig.sp(ii), 'xlim', [0 num_epsiodes]);
end

 if save_plot ==1
        FigName = ['Forest_Tree_MC_Control_eps_02.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
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