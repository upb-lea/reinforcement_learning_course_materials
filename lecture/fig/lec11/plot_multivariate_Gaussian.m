clc
clear all
close all

u_vec = -1:0.05:1;

[dx, dy] = meshgrid(u_vec, u_vec);

sigma = [0.04 0; 0 0.02];
mu = [-0.4; 0.3];
p = zeros(length(u_vec));

for ii = 1:length(dx(1,:))
  for jj = 1:length(dx(:,1))
    u_buf = [dx(ii,jj); dy(ii,jj)];  
    p(ii,jj) = 1/(sqrt((2*pi).^2*det(sigma)))*exp(-1/2*(u_buf-mu)'*inv(sigma)*(u_buf-mu));
  end
end

%% Plotting
save_plot = 1;
fig.PaperFont = 'Times New Roman'; %Font
fig.PaperFontSize = 12; %Font size
fig.folder = ''; %folder to be saved
fig.res = '-r900'; %resolution
fig.fh = []; %init figure handle
fig.lg =[]; %init legend handle
fig.sp = []; %init subplot handle
FigW = 8; %width in cm
FigH = 6; %height in cm

fig.fh(end+1) = figure('NumberTitle', 'off', 'name', 'Multivariante Gaussian Probability Distribution', 'Resize', 'off');
set(fig.fh(end),'PaperPositionMode','manual','PaperUnits','centimeters','Units','centimeters', 'PaperType', 'A4');
set(fig.fh(end),'defaulttextinterpreter','latex',...
            'DefaultAxesFontSize',fig.PaperFontSize,...
            'DefaultTextFontSize',fig.PaperFontSize,...
            'DefaultTextFontName',fig.PaperFont,...
            'DefaultAxesFontName',fig.PaperFont,...
            'PaperSize',[FigW FigH],...
            'PaperPosition',[0,0,FigW,FigH],...
            'Position',[1,1,FigW,FigH]);

surf(dx, dy, p);
xlabel('$u_1$');
ylabel('$u_2$');
zlabel('$\pi$')

 if save_plot ==1
        FigName = ['Gaussian_Policy_Multivariate.pdf'];
    if exist([fig.folder FigName]) == 0
            print('-dpdf','-painters', fig.res,[fig.folder FigName]);
        else
            choice = questdlg(['Datei "' FigName '" existiert bereit! Überschreiben?'], 'Problem', 'Ja', 'Nein', 'Ja');
        if strcmp(choice, 'Ja')
             print(fig.fh(end), '-dpdf', '-painters' , fig.res,[fig.folder FigName]);
        end
   end
 end