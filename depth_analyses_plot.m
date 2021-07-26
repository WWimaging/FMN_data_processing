


cd "path_to_depth_and_tract_based_analyses"/gather_folder_depth

y_limits_FA = [0.025, 0.35];

hh=figure;
hold on;
fig_size_x = 20;
fig_size_y = 30;
set(gcf, 'Position',[0 0 2400 600]);
pos1=[0.04 0.4 0.17 0.35];
pos2=[0.29 0.4 0.17 0.35];
pos3=[0.54 0.4 0.17 0.35];
pos4=[0.79 0.4 0.17 0.35];


%% T2

figsub1=subplot(1, 8/2, 1);
set(figsub1,'position',pos1);
load('T2_invivo_CC00389XX19.mat')
load('T2_invivo_CC00530XX11.mat')
load('T2_invivo_CC00657XX14.mat')
load('T2_invivo_CC00672AN13.mat')
load('T2_invivo_CC00735XX18.mat')
load('T2_invivo_group.mat')
load('T2_exvivo_lowres.mat')
load('T2_exvivo_highres.mat')

y_label = 'T2w';

if strcmp('T2','T2')==0 & strcmp('T2','MD')==0 & strcmp('T2','MK')==0

    y_limits = y_limits_T2;
    
end

x_limits = [0, 4];
x_label = 'Depth (mm)';

marker_size = 8;
line_width = 3;
line_width_subject_scaling_factor = 0.5;

exvivo_highres_colour = [230/255, 97/255, 1/255];
exvivo_lowres_colour = [253/255, 184/255, 99/255];
invivo_group_colour = [94/255, 60/255, 153/255];
invivo_subject_colour = [178/255, 171/255, 210/255];
% invivo_subject_colour = [0.8 0.8 0.8];


dot_colour = [1 1 1];

axis_line_width = 2;
label_font_size = 20;

fig_size_x = 6;
fig_size_y = 5.7;

% figure;

hold on;

% in vivo subjects
p1_data = plot(x_T2_invivo_CC00389XX19, y_T2_invivo_CC00389XX19, 'o', 'Color', dot_colour);
f1 = fit(x_T2_invivo_CC00389XX19, y_T2_invivo_CC00389XX19, 'smoothingspline', 'SmoothingParam', 0.99);
p1_fit = plot(f1);
p1_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p1_fit.Color = invivo_subject_colour;
legend('off')

p2_data = plot(x_T2_invivo_CC00530XX11, y_T2_invivo_CC00530XX11, 'o', 'Color', dot_colour);
f2 = fit(x_T2_invivo_CC00530XX11, y_T2_invivo_CC00530XX11, 'smoothingspline', 'SmoothingParam', 0.99);
p2_fit = plot(f2);
p2_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p2_fit.Color = invivo_subject_colour;
legend('off')

p3_data = plot(x_T2_invivo_CC00657XX14, y_T2_invivo_CC00657XX14, 'o', 'Color', dot_colour);
f3 = fit(x_T2_invivo_CC00657XX14, y_T2_invivo_CC00657XX14, 'smoothingspline', 'SmoothingParam', 0.99);
p3_fit = plot(f3);
p3_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p3_fit.Color = invivo_subject_colour;
legend('off')

p4_data = plot(x_T2_invivo_CC00672AN13, y_T2_invivo_CC00672AN13, 'o', 'Color', dot_colour);
f4 = fit(x_T2_invivo_CC00672AN13, y_T2_invivo_CC00672AN13, 'smoothingspline', 'SmoothingParam', 0.99);
p4_fit = plot(f4);
p4_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p4_fit.Color = invivo_subject_colour;
legend('off')

p5_data = plot(x_T2_invivo_CC00735XX18, y_T2_invivo_CC00735XX18, 'o', 'Color', dot_colour);
f5 = fit(x_T2_invivo_CC00735XX18, y_T2_invivo_CC00735XX18, 'smoothingspline', 'SmoothingParam', 0.99);
p5_fit = plot(f5);
p5_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p5_fit.Color = invivo_subject_colour;
legend('off')

% in vivo group
p6_data = plot(x_T2_invivo_group, y_T2_invivo_group, 'o', 'Color', dot_colour);
f6 = fit(x_T2_invivo_group, y_T2_invivo_group, 'smoothingspline', 'SmoothingParam', 0.99);
p6_fit = plot(f6);
p6_fit.LineWidth = line_width;
p6_fit.Color = invivo_group_colour;
legend('off')

if strcmp('T2','T2')==1 | strcmp('T2','MD')==1 | strcmp('T2','MK')==1
    yyaxis right
end

% ex vivo lowres
p7_data = plot(x_T2_exvivo_lowres, y_T2_exvivo_lowres, 'o', 'Color', dot_colour);
f7 = fit(x_T2_exvivo_lowres, y_T2_exvivo_lowres, 'smoothingspline', 'SmoothingParam', 0.99);
p7_fit = plot(f7);
p7_fit.LineWidth = line_width;
p7_fit.Color = exvivo_lowres_colour;
legend('off')

% ex vivo highres
p8_data = plot(x_T2_exvivo_highres, y_T2_exvivo_highres, 'o', 'Color', dot_colour);
f8 = fit(x_T2_exvivo_highres, y_T2_exvivo_highres, 'smoothingspline', 'SmoothingParam', 0.99);
p8_fit = plot(f8);
p8_fit.LineWidth = line_width;
p8_fit.Color = exvivo_highres_colour;
legend('off')

if strcmp('T2','T2')==1 | strcmp('T2','MD')==1 | strcmp('T2','MK')==1
    ylabel('');
    ax = gca;
    ax.YAxis(2).Color = 'k';
    yyaxis left
end

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');


hold off;

xlim(x_limits);
xticks(x_limits(1): 1 : x_limits(2))
xlabel(x_label);

if strcmp('T2','T2')==0 & strcmp('T2','MD')==0 & strcmp('T2','MK')==0
    
    ylim(y_limits);
    
end

ylabel(y_label);

ax = gca;
ax.FontWeight = 'bold';
ax.LineWidth = axis_line_width;
ax.Box = 'on';
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;
ax.FontSize = ax.XLabel.FontSize * 0.75;
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');

if 1 == 1
    l = legend([p8_fit, p7_fit, p6_fit, p5_fit],'Post-mortem HR','Post-mortem LR', 'In vivo group', 'In vivo individual', 'Box','on', 'Location', 'southeast');
    l.FontSize = label_font_size*0.8;
end



%% MD

figsub2=subplot(1, 8/2, 2);
set(figsub2,'position',pos2);
load('MD_invivo_CC00389XX19.mat')
load('MD_invivo_CC00530XX11.mat')
load('MD_invivo_CC00657XX14.mat')
load('MD_invivo_CC00672AN13.mat')
load('MD_invivo_CC00735XX18.mat')
load('MD_invivo_group.mat')
load('MD_exvivo_lowres.mat')
load('MD_exvivo_highres.mat')

y_label = 'Mean diffusivity';

if strcmp('MD','T2')==0 & strcmp('MD','MD')==0 & strcmp('MD','MK')==0
    
    y_limits = y_limits_MD;
    
end

x_limits = [0, 4];
x_label = 'Depth (mm)';

marker_size = 8;
line_width = 3;
line_width_subject_scaling_factor = 0.5;

exvivo_highres_colour = [230/255, 97/255, 1/255];
exvivo_lowres_colour = [253/255, 184/255, 99/255];
invivo_group_colour = [94/255, 60/255, 153/255];
invivo_subject_colour = [178/255, 171/255, 210/255];
% invivo_subject_colour = [0.8 0.8 0.8];


dot_colour = [1 1 1];

axis_line_width = 2;
label_font_size = 20;

fig_size_x = 6;
fig_size_y = 5.7;

% figure;

hold on;

% in vivo subjects
p1_data = plot(x_MD_invivo_CC00389XX19, y_MD_invivo_CC00389XX19, 'o', 'Color', dot_colour);
f1 = fit(x_MD_invivo_CC00389XX19, y_MD_invivo_CC00389XX19, 'smoothingspline', 'SmoothingParam', 0.99);
p1_fit = plot(f1);
p1_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p1_fit.Color = invivo_subject_colour;
legend('off')

p2_data = plot(x_MD_invivo_CC00530XX11, y_MD_invivo_CC00530XX11, 'o', 'Color', dot_colour);
f2 = fit(x_MD_invivo_CC00530XX11, y_MD_invivo_CC00530XX11, 'smoothingspline', 'SmoothingParam', 0.99);
p2_fit = plot(f2);
p2_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p2_fit.Color = invivo_subject_colour;
legend('off')

p3_data = plot(x_MD_invivo_CC00657XX14, y_MD_invivo_CC00657XX14, 'o', 'Color', dot_colour);
f3 = fit(x_MD_invivo_CC00657XX14, y_MD_invivo_CC00657XX14, 'smoothingspline', 'SmoothingParam', 0.99);
p3_fit = plot(f3);
p3_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p3_fit.Color = invivo_subject_colour;
legend('off')

p4_data = plot(x_MD_invivo_CC00672AN13, y_MD_invivo_CC00672AN13, 'o', 'Color', dot_colour);
f4 = fit(x_MD_invivo_CC00672AN13, y_MD_invivo_CC00672AN13, 'smoothingspline', 'SmoothingParam', 0.99);
p4_fit = plot(f4);
p4_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p4_fit.Color = invivo_subject_colour;
legend('off')

p5_data = plot(x_MD_invivo_CC00735XX18, y_MD_invivo_CC00735XX18, 'o', 'Color', dot_colour);
f5 = fit(x_MD_invivo_CC00735XX18, y_MD_invivo_CC00735XX18, 'smoothingspline', 'SmoothingParam', 0.99);
p5_fit = plot(f5);
p5_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p5_fit.Color = invivo_subject_colour;
legend('off')

% in vivo group
p6_data = plot(x_MD_invivo_group, y_MD_invivo_group, 'o', 'Color', dot_colour);
f6 = fit(x_MD_invivo_group, y_MD_invivo_group, 'smoothingspline', 'SmoothingParam', 0.99);
p6_fit = plot(f6);
p6_fit.LineWidth = line_width;
p6_fit.Color = invivo_group_colour;
legend('off')

if strcmp('MD','T2')==1 | strcmp('MD','MD')==1 | strcmp('MD','MK')==1
    yyaxis right
end

% ex vivo lowres
p7_data = plot(x_MD_exvivo_lowres, y_MD_exvivo_lowres, 'o', 'Color', dot_colour);
f7 = fit(x_MD_exvivo_lowres, y_MD_exvivo_lowres, 'smoothingspline', 'SmoothingParam', 0.99);
p7_fit = plot(f7);
p7_fit.LineWidth = line_width;
p7_fit.Color = exvivo_lowres_colour;
legend('off')

% ex vivo highres
p8_data = plot(x_MD_exvivo_highres, y_MD_exvivo_highres, 'o', 'Color', dot_colour);
f8 = fit(x_MD_exvivo_highres, y_MD_exvivo_highres, 'smoothingspline', 'SmoothingParam', 0.99);
p8_fit = plot(f8);
p8_fit.LineWidth = line_width;
p8_fit.Color = exvivo_highres_colour;
legend('off')

if strcmp('MD','T2')==1 | strcmp('MD','MD')==1 | strcmp('MD','MK')==1
    ylabel('');
    ax = gca;
    ax.YAxis(2).Color = 'k';
    yyaxis left
end

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');


hold off;

xlim(x_limits);
xticks(x_limits(1): 1 : x_limits(2))
xlabel(x_label);

if strcmp('MD','T2')==0 & strcmp('MD','MD')==0 & strcmp('MD','MK')==0
    
    ylim(y_limits);
    
end

ylabel(y_label);

ax = gca;
ax.FontWeight = 'bold';
ax.LineWidth = axis_line_width;
ax.Box = 'on';
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;
ax.FontSize = ax.XLabel.FontSize * 0.75;
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');

if 2 == 2
    %     l = legend([p8_fit, p7_fit, p6_fit, p5_fit],'Ex vivo HR','Ex vivo LR', 'In vivo mean', 'In vivo', 'Box','on', 'Location', 'southeast');
    %     l.FontSize = label_font_size*0.57;
end


%% FA

figsub3=subplot(1, 8/2, 3)
set(figsub3,'position',pos3);
load('FA_invivo_CC00389XX19.mat')
load('FA_invivo_CC00530XX11.mat')
load('FA_invivo_CC00657XX14.mat')
load('FA_invivo_CC00672AN13.mat')
load('FA_invivo_CC00735XX18.mat')
load('FA_invivo_group.mat')
load('FA_exvivo_lowres.mat')
load('FA_exvivo_highres.mat')

y_label = 'Fractional anisotropy';

if strcmp('FA','T2')==0 & strcmp('FA','MD')==0 & strcmp('FA','MK')==0

    y_limits = y_limits_FA;
    
end

x_limits = [0, 4];
x_label = 'Depth (mm)';

marker_size = 8;
line_width = 3;
line_width_subject_scaling_factor = 0.5;

exvivo_highres_colour = [230/255, 97/255, 1/255];
exvivo_lowres_colour = [253/255, 184/255, 99/255];
invivo_group_colour = [94/255, 60/255, 153/255];
invivo_subject_colour = [178/255, 171/255, 210/255];
% invivo_subject_colour = [0.8 0.8 0.8];


dot_colour = [1 1 1];

axis_line_width = 2;
label_font_size = 20;

fig_size_x = 6;
fig_size_y = 5.7;

% figure;

hold on;

% in vivo subjects
p1_data = plot(x_FA_invivo_CC00389XX19, y_FA_invivo_CC00389XX19, 'o', 'Color', dot_colour);
f1 = fit(x_FA_invivo_CC00389XX19, y_FA_invivo_CC00389XX19, 'smoothingspline', 'SmoothingParam', 0.99);
p1_fit = plot(f1);
p1_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p1_fit.Color = invivo_subject_colour;
legend('off')

p2_data = plot(x_FA_invivo_CC00530XX11, y_FA_invivo_CC00530XX11, 'o', 'Color', dot_colour);
f2 = fit(x_FA_invivo_CC00530XX11, y_FA_invivo_CC00530XX11, 'smoothingspline', 'SmoothingParam', 0.99);
p2_fit = plot(f2);
p2_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p2_fit.Color = invivo_subject_colour;
legend('off')

p3_data = plot(x_FA_invivo_CC00657XX14, y_FA_invivo_CC00657XX14, 'o', 'Color', dot_colour);
f3 = fit(x_FA_invivo_CC00657XX14, y_FA_invivo_CC00657XX14, 'smoothingspline', 'SmoothingParam', 0.99);
p3_fit = plot(f3);
p3_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p3_fit.Color = invivo_subject_colour;
legend('off')

p4_data = plot(x_FA_invivo_CC00672AN13, y_FA_invivo_CC00672AN13, 'o', 'Color', dot_colour);
f4 = fit(x_FA_invivo_CC00672AN13, y_FA_invivo_CC00672AN13, 'smoothingspline', 'SmoothingParam', 0.99);
p4_fit = plot(f4);
p4_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p4_fit.Color = invivo_subject_colour;
legend('off')

p5_data = plot(x_FA_invivo_CC00735XX18, y_FA_invivo_CC00735XX18, 'o', 'Color', dot_colour);
f5 = fit(x_FA_invivo_CC00735XX18, y_FA_invivo_CC00735XX18, 'smoothingspline', 'SmoothingParam', 0.99);
p5_fit = plot(f5);
p5_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p5_fit.Color = invivo_subject_colour;
legend('off')

% in vivo group
p6_data = plot(x_FA_invivo_group, y_FA_invivo_group, 'o', 'Color', dot_colour);
f6 = fit(x_FA_invivo_group, y_FA_invivo_group, 'smoothingspline', 'SmoothingParam', 0.99);
p6_fit = plot(f6);
p6_fit.LineWidth = line_width;
p6_fit.Color = invivo_group_colour;
legend('off')

if strcmp('FA','T2')==1 | strcmp('FA','MD')==1 | strcmp('FA','MK')==1
    yyaxis right
end

% ex vivo lowres
p7_data = plot(x_FA_exvivo_lowres, y_FA_exvivo_lowres, 'o', 'Color', dot_colour);
f7 = fit(x_FA_exvivo_lowres, y_FA_exvivo_lowres, 'smoothingspline', 'SmoothingParam', 0.99);
p7_fit = plot(f7);
p7_fit.LineWidth = line_width;
p7_fit.Color = exvivo_lowres_colour;
legend('off')

% ex vivo highres
p8_data = plot(x_FA_exvivo_highres, y_FA_exvivo_highres, 'o', 'Color', dot_colour);
f8 = fit(x_FA_exvivo_highres, y_FA_exvivo_highres, 'smoothingspline', 'SmoothingParam', 0.99);
p8_fit = plot(f8);
p8_fit.LineWidth = line_width;
p8_fit.Color = exvivo_highres_colour;
legend('off')

if strcmp('FA','T2')==1 | strcmp('FA','MD')==1 | strcmp('FA','MK')==1
    ylabel('');
    ax = gca;
    ax.YAxis(2).Color = 'k';
    yyaxis left
end

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');

hold off;

xlim(x_limits);
xticks(x_limits(1): 1 : x_limits(2))
xlabel(x_label);

if strcmp('FA','T2')==0 & strcmp('FA','MD')==0 & strcmp('FA','MK')==0
    
    ylim(y_limits);
    
end

ylabel(y_label);

ax = gca;
ax.FontWeight = 'bold';
ax.LineWidth = axis_line_width;
ax.Box = 'on';
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;
ax.FontSize = ax.XLabel.FontSize * 0.75;
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');

if 3 == 1
    l = legend([p8_fit, p7_fit, p6_fit, p5_fit],'FMN HR','FMN LR', 'IV mean', 'IV subjs', 'Box','on', 'Location', 'southeast');
    l.FontSize = label_font_size*0.4;
end


%% MK

figsub4=subplot(1, 8/2, 4)
set(figsub4,'position',pos4);
load('MK_invivo_CC00389XX19.mat')
load('MK_invivo_CC00530XX11.mat')
load('MK_invivo_CC00657XX14.mat')
load('MK_invivo_CC00672AN13.mat')
load('MK_invivo_CC00735XX18.mat')
load('MK_invivo_group.mat')
load('MK_exvivo_lowres.mat')
load('MK_exvivo_highres.mat')

y_label = 'Mean kurtosis';

if strcmp('MK','T2')==0 & strcmp('MK','MD')==0 & strcmp('MK','MK')==0
    
    y_limits = y_limits_MK;
    
end

x_limits = [0, 4];
x_label = 'Depth (mm)';

marker_size = 8;
line_width = 3;
line_width_subject_scaling_factor = 0.5;

exvivo_highres_colour = [230/255, 97/255, 1/255];
exvivo_lowres_colour = [253/255, 184/255, 99/255];
invivo_group_colour = [94/255, 60/255, 153/255];
invivo_subject_colour = [178/255, 171/255, 210/255];
% invivo_subject_colour = [0.8 0.8 0.8];


dot_colour = [1 1 1];

axis_line_width = 2;
label_font_size = 20;

fig_size_x = 6;
fig_size_y = 5.7;

% figure;

hold on;

% in vivo subjects
p1_data = plot(x_MK_invivo_CC00389XX19, y_MK_invivo_CC00389XX19, 'o', 'Color', dot_colour);
f1 = fit(x_MK_invivo_CC00389XX19, y_MK_invivo_CC00389XX19, 'smoothingspline', 'SmoothingParam', 0.99);
p1_fit = plot(f1);
p1_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p1_fit.Color = invivo_subject_colour;
legend('off')

p2_data = plot(x_MK_invivo_CC00530XX11, y_MK_invivo_CC00530XX11, 'o', 'Color', dot_colour);
f2 = fit(x_MK_invivo_CC00530XX11, y_MK_invivo_CC00530XX11, 'smoothingspline', 'SmoothingParam', 0.99);
p2_fit = plot(f2);
p2_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p2_fit.Color = invivo_subject_colour;
legend('off')

p3_data = plot(x_MK_invivo_CC00657XX14, y_MK_invivo_CC00657XX14, 'o', 'Color', dot_colour);
f3 = fit(x_MK_invivo_CC00657XX14, y_MK_invivo_CC00657XX14, 'smoothingspline', 'SmoothingParam', 0.99);
p3_fit = plot(f3);
p3_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p3_fit.Color = invivo_subject_colour;
legend('off')

p4_data = plot(x_MK_invivo_CC00672AN13, y_MK_invivo_CC00672AN13, 'o', 'Color', dot_colour);
f4 = fit(x_MK_invivo_CC00672AN13, y_MK_invivo_CC00672AN13, 'smoothingspline', 'SmoothingParam', 0.99);
p4_fit = plot(f4);
p4_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p4_fit.Color = invivo_subject_colour;
legend('off')

p5_data = plot(x_MK_invivo_CC00735XX18, y_MK_invivo_CC00735XX18, 'o', 'Color', dot_colour);
f5 = fit(x_MK_invivo_CC00735XX18, y_MK_invivo_CC00735XX18, 'smoothingspline', 'SmoothingParam', 0.99);
p5_fit = plot(f5);
p5_fit.LineWidth = line_width * line_width_subject_scaling_factor;
p5_fit.Color = invivo_subject_colour;
legend('off')

% in vivo group
p6_data = plot(x_MK_invivo_group, y_MK_invivo_group, 'o', 'Color', dot_colour);
f6 = fit(x_MK_invivo_group, y_MK_invivo_group, 'smoothingspline', 'SmoothingParam', 0.99);
p6_fit = plot(f6);
p6_fit.LineWidth = line_width;
p6_fit.Color = invivo_group_colour;
legend('off')

if strcmp('MK','T2')==1 | strcmp('MK','MD')==1 | strcmp('MK','MK')==1
    yyaxis right
end

% ex vivo lowres
p7_data = plot(x_MK_exvivo_lowres, y_MK_exvivo_lowres, 'o', 'Color', dot_colour);
f7 = fit(x_MK_exvivo_lowres, y_MK_exvivo_lowres, 'smoothingspline', 'SmoothingParam', 0.99);
p7_fit = plot(f7);
p7_fit.LineWidth = line_width;
p7_fit.Color = exvivo_lowres_colour;
legend('off')

% ex vivo highres
p8_data = plot(x_MK_exvivo_highres, y_MK_exvivo_highres, 'o', 'Color', dot_colour);
f8 = fit(x_MK_exvivo_highres, y_MK_exvivo_highres, 'smoothingspline', 'SmoothingParam', 0.99);
p8_fit = plot(f8);
p8_fit.LineWidth = line_width;
p8_fit.Color = exvivo_highres_colour;
legend('off')

if strcmp('MK','T2')==1 | strcmp('MK','MD')==1 | strcmp('MK','MK')==1
    ylabel('');
    ax = gca;
    ax.YAxis(2).Color = 'k';
    yyaxis left
end

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');

hold off;

xlim(x_limits);
xticks(x_limits(1): 1 : x_limits(2))
xlabel(x_label);

if strcmp('MK','T2')==0 & strcmp('MK','MD')==0 & strcmp('MK','MK')==0
    
    ylim(y_limits);
    
end

ylabel(y_label);

ax = gca;
ax.FontWeight = 'bold';
ax.LineWidth = axis_line_width;
ax.Box = 'on';
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;
ax.FontSize = ax.XLabel.FontSize * 0.75;
ax.XLabel.FontSize = label_font_size;
ax.YLabel.FontSize = label_font_size;

set(p1_data,'visible','off');
set(p2_data,'visible','off');
set(p3_data,'visible','off');
set(p4_data,'visible','off');
set(p5_data,'visible','off');
set(p6_data,'visible','off');
set(p7_data,'visible','off');
set(p8_data,'visible','off');

if 4 == 1
    l = legend([p8_fit, p7_fit, p6_fit, p5_fit],'FMN HR','FMN LR', 'IV mean', 'IV subjs', 'Box','on', 'Location', 'southeast');
    l.FontSize = label_font_size*0.4;
end


fig_name = 'distance_plots';

print(gcf, '-dpng', fig_name, '-r600')
