clear all 
close all
clc

save_plot = 1;

steps = 10;
x = -10:0.1:10;
k = 1:steps;

sigma_TRPO = linspace(2.5,0.5,steps);
mu_TRPO = linspace(-2.5,3,steps);

sigma_rnd = linspace(2.5,1.5,steps)+0.25*randn(1,steps);
mu_rnd = linspace(2.5,-1.5,steps)+2.5*randn(1,steps);





fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 12; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 25; %width in cm
FigH = 12; %height in cm
fig.color.ciplot = [0.6 1 1];
fig.color.mean = [1 0 0];
fig.Linewidth.mean = 2;


fig.fh(end+1) = figure('NumberTitle', 'off', 'name', 'Bode plots', 'Resize', 'off', 'RendererMode', 'manual');
set(fig.fh(end),'PaperPositionMode','manual','PaperUnits','centimeters','Units','centimeters', 'PaperType', 'A4', 'Renderer', 'opengl');
set(fig.fh(end),'defaulttextinterpreter','latex',...
            'DefaultAxesFontSize',fig.PaperFontSize,...
            'DefaultTextFontSize',fig.PaperFontSize,...
            'DefaultTextFontName',fig.PaperFont,...
            'DefaultAxesFontName',fig.PaperFont,...
            'PaperSize',[FigW FigH],...
            'PaperPosition',[0,0,FigW,FigH],...
            'Position',[1,1,FigW,FigH]);


fig.sp(end+1) = subplot(1,2,1);
hold on;
for ii = 1:steps
   plot3(x, ii*ones(length(x),1), normpdf(x,mu_TRPO(ii),sigma_TRPO(ii)));
end
xlabel('action $u$', 'Interpreter', 'LaTeX');
ylabel('update step $k$', 'Interpreter', 'LaTeX');
zlabel('action probability $\pi(u|\cdot)$', 'Interpreter', 'LaTeX');
grid on;
view(45, 20);
zlim([0 0.8]);
title('Smooth policy updates');

fig.sp(end+1) = subplot(1,2,2);
hold on;
for ii = 1:steps
   plot3(x, ii*ones(length(x),1), normpdf(x,mu_rnd(ii),sigma_rnd(ii)));
end
xlabel('action $u$', 'Interpreter', 'LaTeX');
ylabel('update step $k$', 'Interpreter', 'LaTeX');
zlabel('action probability $\pi(u|\cdot)$', 'Interpreter', 'LaTeX');
grid on;
view(45, 20);
zlim([0 0.8]);
title('Erratic policy updates');

 if save_plot ==1
        FigName = ['TRPO_Style_Updates.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" already exists! Override?'], 'Problem', 'Yes', 'No', 'Yes');
        if strcmp(choice, 'Yes')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end