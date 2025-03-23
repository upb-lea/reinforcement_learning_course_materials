%calc_forest_example: Calculating prediction RMS accuracy between MC and TD0 for forest tree MDP
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

%true state values
v1_true = 1.121176470588235;
v2_true = 1.941176470588236;
v3_true = 2.941176470588236;

%% Graphical Output

fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 8; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 11.5; %width in cm
FigH = 6.5; %height in cm
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

hold on;
grid on;
box on;

alpha_TD=0.2;
v_TD = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes);
v_TD.RMS = sqrt((v_TD.v1_mean-v1_true).^2 + (v_TD.v2_mean-v2_true).^2 + (v_TD.v3_mean-v3_true).^2);
plot(v_TD.RMS, 'Displayname', ['TD$(\alpha_{TD}=$' num2str(alpha_TD) '$)$'], 'LineStyle', '--');

alpha_MC=0.2;
v_MC = Forest_Episode_MC(alpha_MC,p, alpha, gamma, num_trials, num_episodes);
v_MC.RMS = sqrt((v_MC.v1_mean-v1_true).^2 + (v_MC.v2_mean-v2_true).^2 + (v_MC.v3_mean-v3_true).^2);
plot(v_MC.RMS, 'Displayname', ['MC$(\alpha_{MC}=$' num2str(alpha_MC) '$)$']);

alpha_TD=0.1;
v_TD = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes);
v_TD.RMS = sqrt((v_TD.v1_mean-v1_true).^2 + (v_TD.v2_mean-v2_true).^2 + (v_TD.v3_mean-v3_true).^2);
plot(v_TD.RMS, 'Displayname', ['TD$(\alpha_{TD}=$' num2str(alpha_TD) '$)$'], 'LineStyle', '--');

alpha_MC=0.1;
v_MC = Forest_Episode_MC(alpha_MC,p, alpha, gamma, num_trials, num_episodes);
v_MC.RMS = sqrt((v_MC.v1_mean-v1_true).^2 + (v_MC.v2_mean-v2_true).^2 + (v_MC.v3_mean-v3_true).^2);
plot(v_MC.RMS, 'Displayname', ['MC$(\alpha_{MC}=$' num2str(alpha_MC) '$)$']);

alpha_TD=0.05;
v_TD = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes);
v_TD.RMS = sqrt((v_TD.v1_mean-v1_true).^2 + (v_TD.v2_mean-v2_true).^2 + (v_TD.v3_mean-v3_true).^2);
plot(v_TD.RMS, 'Displayname', ['TD$(\alpha_{TD}=$' num2str(alpha_TD) '$)$'], 'LineStyle', '--');

alpha_MC=0.05;
v_MC = Forest_Episode_MC(alpha_MC,p, alpha, gamma, num_trials, num_episodes);
v_MC.RMS = sqrt((v_MC.v1_mean-v1_true).^2 + (v_MC.v2_mean-v2_true).^2 + (v_MC.v3_mean-v3_true).^2);
plot(v_MC.RMS, 'Displayname', ['MC$(\alpha_{MC}=$' num2str(alpha_MC) '$)$']);

xlabel('Episodes');
ylabel('$ \sqrt{\frac{1}{N}\sum_i^N\left(v(x_i)-\hat{v}(x_i)\right)^2}$');
fig.lg(end+1) = legend('toggle');
set(fig.lg(end), 'Interpreter', 'Latex');

if save_plot ==1
        FigName = ['Forest_Tree_TD0_MC_RMS_Prediction_Zero_Init_500_eps.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end


%% MC state-value estimation

function [v] = Forest_Episode_MC(alpha_MC,p, alpha, gamma, num_trials, num_episodes)
    for ee = 1:num_trials

        v = zeros(4,1);
        %v(1) = 1;v(2)=2;v(3)=3;

        for ii = 1:num_episodes
            
            [x, u, r] = Forest_Episode(p, alpha); %Generate a sequence following pi from x=1 as initial state
            g = 0;
            jj = length(r);
            while (jj > 0)
                 g = gamma*g + r(jj);
                 if (~ismember(x(jj), x(1:max([1 jj-1])))) || (x(jj)==1) %first vist test
                     v(x(jj)) = v(x(jj)) + alpha_MC*(g-v(x(jj)));
                 end
                 jj = jj-1;
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


%% TD(0) state-value estimation

function [v] = Forest_Episode_TD0(alpha_TD,p, alpha, gamma, num_trials, num_episodes)
    for ee = 1:num_trials

        v = zeros(4,1);
        %v(1) = 1;v(2)=2;v(3)=3;

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