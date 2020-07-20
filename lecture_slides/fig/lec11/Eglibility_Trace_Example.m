clc
clear all
close all

% Parameter
lambda = 0.9;
gamma = 1;

% Step Vector
k_vec = 0:1:50;

% Assume x1 is the state and also the only feature input to a linear function approximation
% We assign random numbers to the state transistions
x1 = (rand(length(k_vec),1)-0.5)*2;

% Due to linear approximation the gradient of the value function is the feature vector
nabla_v = [x1];

% Calculate egilbility trace for this example
z = zeros(1,length(k_vec));
for ii=2:length(k_vec)
    z(ii) = nabla_v(ii) + z(ii-1)*gamma*lambda;
end
    
%% Plotting
save_plot = 1;
fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 13; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 13; %width in cm
FigH = 6; %height in cm

fig.fh(end+1) = figure('NumberTitle', 'off', 'name', 'Eglibility Trace Example with Linear Function Approximation', 'Resize', 'off');
set(fig.fh(end),'PaperPositionMode','manual','PaperUnits','centimeters','Units','centimeters', 'PaperType', 'A4');
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
plot(k_vec, x1);
plot(k_vec, z);
xlabel('$k$');
ylabel('${x,z}$')
fig.lg(end+1) = legend('$x$', '$z$');
set(fig.lg(end), 'Location', 'Best', 'Interpreter', 'LaTex');

 if save_plot ==1
        FigName = ['Eglibility_Trace_Example.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end