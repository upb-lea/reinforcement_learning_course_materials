clc;
clear all;
close all;

save_plot=1;

alpha = 0.1; %learning step size
w_old = [1 1 1]'; %initial linear regression parameter vector


x_vec = -5:0.5:5; %base grid vector
[dx, dy] = meshgrid(x_vec); %base grid

%% Simple arbitrary learning step at x1 = x2 = 1 with target U = 1
U = 1; %target at evaluated state (e.g. from one-step TD or MC)
zeta = [1 1 1]; %regression vector with zeta = [x1 x2 1] 
w_new = w_old + alpha * (U - zeta*w_old)*w_old; %incremental learning step

%% Graphical representation

v_hat_old = w_old(1)*dx + w_old(2)*dy + w_old(3); %estimated value with initial parameter vector
v_hat_new = w_new(1)*dx + w_new(2)*dy + w_new(3); %estimated value with updated parameter vector

fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 10; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 13; %width in cm
FigH = 6; %height in cm

fig.fh(end+1) = figure('NumberTitle', 'off', 'name', 'Linear Regression RL Prediction Learning', 'Resize', 'off');
set(fig.fh(end),'PaperPositionMode','manual','PaperUnits','centimeters','Units','centimeters', 'PaperType', 'A4');
set(fig.fh(end),'defaulttextinterpreter','latex',...
            'DefaultAxesFontSize',fig.PaperFontSize,...
            'DefaultTextFontSize',fig.PaperFontSize,...
            'DefaultTextFontName',fig.PaperFont,...
            'DefaultAxesFontName',fig.PaperFont,...
            'PaperSize',[FigW FigH],...
            'PaperPosition',[0,0,FigW,FigH],...
            'Position',[1,1,FigW,FigH]);
        
fig.sp(end+1)=subplot(1,2,1);   
hold on;
grid on;
box on;
colormap('gray');
surf(dx,dy,v_hat_old);
view([15, 10]);
zlim([-10 15]);
xlabel('$x_1$');
ylabel('$x_2$');
zlabel('$\hat{v}$');
title('$k=0$');

fig.sp(end+1)=subplot(1,2,2);      
hold on;
grid on;
box on;
colormap('gray');
surf(dx,dy,v_hat_new);
view([15, 10]);
zlim([-10 15]);
xlabel('$x_1$');
ylabel('$x_2$');
zlabel('$\hat{v}$');
title('$k=1$');

 if save_plot ==1
        FigName = ['Simple_LinearRegression_Example.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end
