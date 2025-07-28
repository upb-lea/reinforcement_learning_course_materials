%calc_forest_MC_off_policy_WIS_prediction_example: Calculating exemplary control trajectories for off-policy Monte Carlo learning with weighted importance sampling 
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: Oliver Wallscheid
% email: wallscheid@lea.upb.de
% March 2020; Last revision: 21-March-2020
%------------- BEGIN CODE --------------
clear all;
close all;
save_plot = 1; %1 = plot saves to harddrive

alpha = 0.2; %Desaster faktor
gamma = 0.8; %Discount facot

num_trials = 1500; %number of trials
num_epsiodes = 5000; %number of episodes per trial

%% Initals 
%target policy (also fifty-ftify)
p(1,1) = 0.5; %probability of u=cut at state = 1
p(1,2) = 0.5; %probability of u=wait at state = 1

p(2,1) = 0.5; %probability of u=cutt at state = 2
p(2,2) = 0.5; %probability of u=wait at state = 2

p(3,1) = 0.5; %probability of u=cut at state = 3
p(3,2) = 0.5; %probability of u=wait at state = 3

%behavior policy (fifty-fifty)
b(1,1) = 0.5; %probability of u=cut at state = 1
b(1,2) = 0.5; %probability of u=wait at state = 1

b(2,1) = 0.5; %probability of u=cutt at state = 2
b(2,2) = 0.5; %probability of u=wait at state = 2

b(3,1) = 0.5; %probability of u=cut at state = 3
b(3,2) = 0.5; %probability of u=wait at state = 3

%% Off-policy MC constrol using WIS

for ee = 1:num_trials
    %action-value estimates init
    q = zeros(3,2);
    p =0.5*ones(3,2);
    
    %cumulative weights
    c = zeros(3,2);
    
    for ii = 1:num_epsiodes
        [x, u, r] = Forest_Episode(b, alpha);
        g = 0;
        w = 1;
        jj = length(r);
        while (jj > 0)
                 g = gamma*g + r(jj);
                 c(x(jj), u(jj)) = c(x(jj), u(jj)) + w;
                 q(x(jj), u(jj)) = q(x(jj), u(jj)) + w/c(x(jj), u(jj))*(g - q(x(jj), u(jj)));
                 [q_max, q_pos] = max(q(x(jj), :));
                 p(x(jj),q_pos) = 1;
                 p(x(jj), 2-q_pos+1) = 0;
                 if u(jj) ~= q_pos
                     break;
                 else
                    w = w/b(x(jj), u(jj));  
                 end
                 jj = jj-1;
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

p12_mean = mean(p12,1);
p22_mean = mean(p22,1);
p32_mean = mean(p32,1);


% upper bound (+ std)
q12_lower = q12_mean-std(q12,0,1);
q22_lower = q22_mean-std(q22,0,1);
q32_lower = q32_mean-std(q32,0,1);

p12_lower = p12_mean-std(p12,0,1);
p22_lower = p22_mean-std(p22,0,1);
p32_lower = p32_mean-std(p32,0,1);


% upper bound (- std)
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
fig.res = '-r900'; %resolution
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
xlabel('Number of episodes');
set(fig.sp(end), 'xlim', [0 num_epsiodes]);

fig.sp(end+1) = subplot(2,3,5);
hold on;
grid on;
box on;
ciplot(p22_lower,p22_upper, 1:length(p22_lower), fig.color.ciplot);
plot(p22_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=2)$');
xlabel('Number of episodes');
set(fig.sp(end), 'xlim', [0 num_epsiodes]);

fig.sp(end+1) = subplot(2,3,6);
hold on;
grid on;
box on;
ciplot(p32_lower,p32_upper, 1:length(p32_lower), fig.color.ciplot);
plot(p32_mean, 'LineWidth',fig.Linewidth.mean, 'Color', fig.color.mean);
ylabel('$\pi(u=\mbox{w}|x=3)$');
xlabel('Number of episodes');
set(fig.sp(end), 'xlim', [0 num_epsiodes]);

 if save_plot ==1
        FigName = ['Forest_Tree_MC_Off_Policy_Control_WIS.pdf'];
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