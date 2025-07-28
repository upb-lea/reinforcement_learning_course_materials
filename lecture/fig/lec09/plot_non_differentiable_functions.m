clc;
clear all;
close all;

save_plot=1;

x_vec = -4.05:0.02:4.05;

y1 = x_vec./abs(x_vec);
y2 = 1./x_vec;
y3 = real(sqrt(x_vec));
y3(x_vec < 0) = NaN;
y4 = x_vec.^(2/3);


%% Graphical representation

fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 10; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 14; %width in cm
FigH = 5.5; %height in cm

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
        
fig.sp(end+1)=subplot(2,2,1);   
hold on;
grid on;
box on;
plot(x_vec, y1);
xlabel('$x$');
ylabel('$y$');
xlim([-4 4]);
ylim([-1.25 1.25]);
title('$y=\frac{x}{|x|}$');

fig.sp(end+1)=subplot(2,2,2);   
hold on;
grid on;
box on;
plot(x_vec, y2);
xlabel('$x$');
ylabel('$y$');
xlim([-4 4]);
ylim([-5 5]);
title('$y=\frac{1}{x}$');

fig.sp(end+1)=subplot(2,2,3);   
hold on;
grid on;
box on;
plot(x_vec, y3);
xlabel('$x$');
ylabel('$y$');
xlim([-4 4]);
title('$y=\sqrt{x}$');

fig.sp(end+1)=subplot(2,2,4);   
hold on;
grid on;
box on;
plot(x_vec, y4);
xlabel('$x$');
ylabel('$y$');
xlim([-4 4]);
title('$y=x^\frac{2}{3}$');


 if save_plot ==1
        FigName = ['Non_differentiable_functions.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end