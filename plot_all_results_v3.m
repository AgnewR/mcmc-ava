%% plot_all_results_v3.m
%% plot all results of inversion

%% plot histograms of bed properties
[h1, h2, h3, h4, h5, h6, h7, h8, fig1, fig2] = plot_hists(models_pbi, poisson_saved, Z_saved);

[p, b] = max(h1.Values);
moderho1 = h1.BinEdges(b)+  0.5*(h1.BinEdges(b+1) - h1.BinEdges(b));

[p, b] = max(h2.Values);
modealpha1 = h2.BinEdges(b)+  0.5*(h2.BinEdges(b+1) - h2.BinEdges(b));

[p, b] = max(h3.Values);
modebeta1 = h3.BinEdges(b)+  0.5*(h3.BinEdges(b+1) - h3.BinEdges(b));

[p, b] = max(h4.Values);
moderho2 = h4.BinEdges(b)+  0.5*(h4.BinEdges(b+1) - h4.BinEdges(b));

[p, b] = max(h5.Values);
modealpha2 = h5.BinEdges(b)+  0.5*(h5.BinEdges(b+1) - h5.BinEdges(b));

[p, b] = max(h6.Values);
modebeta2 = h6.BinEdges(b)+  0.5*(h6.BinEdges(b+1) - h6.BinEdges(b));

[p, b] = max(h8.Values);
modeZ = h8.BinEdges(b)+  0.5*(h8.BinEdges(b+1) - h8.BinEdges(b));

mode_model = [moderho1, moderho2, modealpha1, modealpha2, modebeta1, modebeta2];

coefPP_mode = zoeppritz(mode_model(1), mode_model(3), mode_model(5), mode_model(2), mode_model(4), mode_model(6), 1, 1, 0, anginc_PP);
Rpp_mode = real(coefPP_mode);

coefPS_mode = zoeppritz(mode_model(1), mode_model(3), mode_model(5), mode_model(2), mode_model(4), mode_model(6), 1, 2, 0, anginc_PS);
Rps_mode = real(coefPS_mode);

coefSS_mode = zoeppritz(mode_model(1), mode_model(3), mode_model(5), mode_model(2), mode_model(4), mode_model(6), 2, 2, 0, anginc_SS);
Rss_mode = real(coefSS_mode);



%% plot the avo curves

if includeSS
    fig3 = figure;
    subplot(1,3,1);
    hold on;
    e1 = errorbar(anginc_PP, Rpp_input, sigs_PP, sigs_PP, '.', 'Color','b');
    plot(anginc_PP, Rpp_best);
    plot(anginc_PP, Rpp_med);
    legend('Data', 'Best model', 'Median model');
    xlabel('Angle of incidence (degrees)'); ylabel('R_{PP}')
    ylim([-1 1])
    inv_figure

    subplot(1,3,2);
    hold on;
    e2 = errorbar(anginc_PS, Rps_input, sigs_PS, '.', 'Color','r');
    plot(anginc_PS, Rps_best);
    plot(anginc_PS, Rps_med);
    legend('Data', 'Best model', 'Median model');
    xlabel('Angle of incidence (degrees)'); ylabel('R_{PS}')
    ylim([-1 1])

    inv_figure

    subplot(1,3,3);
    hold on;
    e3 =errorbar(anginc_SS, Rss_input,sigs_SS, '.','Color','g');
    plot(anginc_SS, Rss_best);
    plot(anginc_SS, Rss_med);
    legend('Data', 'Best model', 'Median model');
    xlabel('Angle of incidence (degrees)'); ylabel('R_{SS}')
    ylim([-1 1])

    inv_figure
    set(gcf, 'Name', 'AVO_curves', 'Color','w');

else
    fig3 = figure;
    subplot(1,2,1);
    hold on;
    e1=errorbar(anginc_PP, Rpp_input, sigs_PP,'.', 'Color','b', 'MarKerSize', 10);
    plot(anginc_PP, Rpp_best, 'Color','b', 'LineWidth', 1.5);
    plot(anginc_PP, Rpp_med,'--', 'Color','b', 'LineWidth', 1.5);
    %plot(anginc_PP, Rpp_mode, '-.','Color','b', 'LineWidth',1.5);
    alpha=0.5;
    set([e1.Bar, e1.Line], 'ColorType', 'truecoloralpha','ColorData', [e1.Line.ColorData(1:3); 255*alpha])
    
    xlabel('ang inc (deg)'); ylabel('Rpp')
    linex = [0 max(anginc_PP)];
    liney = [0 0];
    plot(linex,liney, 'Color', '[0.5 0.5 0.5]', 'LineWidth',1.5)
    %legend('data', 'best model', 'median model', 'mode model');
    legend('Data', 'Best model', 'Median model');
    xlabel('Angle of incidence (degrees)'); ylabel('R_{PP}')
    inv_figure
    ylim([-1 1]);
    inv_figure

    subplot(1,2,2);
    hold on;
    e2=errorbar(anginc_PS, Rps_input,sigs_PS,'.', 'Color','r', 'MarKerSize', 10);
    plot(anginc_PS, Rps_best, 'Color','r', 'LineWidth', 1.5);
    plot(anginc_PS, Rps_med, '--','Color','r', 'LineWidth', 1.5);
    %plot(anginc_PS, Rps_mode, '-.','Color','r', 'LineWidth',1.5);

  
    xlabel('ang inc (deg)'); ylabel('Rps')
    inv_figure
    linex = [0 max(anginc_PS)];
    plot(linex,liney, 'Color', '[0.5 0.5 0.5]', 'LineWidth',1.5)  
    legend('Data', 'Best model', 'Median model');
    xlabel('Angle of incidence (degrees)'); ylabel('R_{PS}')
    ylim([-1 1])
    xlim([0 max(anginc_PS)])
    set(gcf, 'Name', 'AVO_curves', 'Color','w');
    inv_figure
    alpha=0.5;
    set([e2.Bar, e2.Line], 'ColorType', 'truecoloralpha','ColorData', [e2.Line.ColorData(1:3); 255*alpha])
      
end

%% plot isosurfaces

x_iso = models_pbi(modelnum_above_level, 4);
y_iso = models_pbi(modelnum_above_level, 6);
z_iso = models_pbi(modelnum_above_level, 2);
c = log_likelihood_saved(burn_in+1:number_iterations);
c_iso = exp(log_posterior_pbi(modelnum_above_level));

fig4=figure;
ax1 = subplot(1,2,1);
hold on;   
grid on

[pa1, pa2, pa3, pa4, pa5, pa6, pa7, pa8, pa9, pa10] = plot_reference(m_best,mode_model,median_model,iqr_model,200);
axis equal
legend('ice', 'bedrock','lithified seds', 'dilatant seds', 'water','permafrost', 'stiff till','mode model', 'median model', 'best model')
xlabel('V_p (m s^{-1})'); ylabel('V_s (m s^{-1})'); zlabel('Density (kg m^{-3})')
set(gca, 'FontSize', 15)

ax2 = subplot(1,2,2);

plot3(x,y,z);
cla
patch([x; nan], [y; nan], [z; nan], [c; nan], 'EdgeColor', 'interp', 'FaceColor', 'none');
xlabel('V_p (m s^{-1})'); ylabel('V_s (m s^{-1})'); zlabel('Density (kg m^{-3})')
axis equal
grid on
set(gca, 'FontSize', 15)
Link = linkprop([ax1, ax2],{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim', 'ZLim'});

set(gcf, 'Name', 'density-Vp-Vs_results');
set(gcf, 'Color', 'w')
set(gca, 'FontSize', 15)


%% plot Z and poisson ratio

fig5= figure; 
hold on;
height = max(exp(log_posterior_pbi));
plot_zpois_misfit(Z_saved, poisson_saved)

plot_zpois_ref

scatter3(Z_best, poisson_best, height, 'o', 'filled','k');
bar = errorbar(median(Z_saved), median(poisson_saved), 0.5*iqr(poisson_saved), 0.5*iqr(poisson_saved), 0.5*iqr(Z_saved), 0.5*iqr(Z_saved), 'o','Color','k');
bar.LineWidth = 1.5;     

bar2 = errorbar(mean(Z_saved), mean(poisson_saved), std(poisson_saved), std(poisson_saved), std(Z_saved), std(Z_saved), 'o','Color',[0.5 0.5 0.5]);
bar2.LineWidth = 1.5; 
legend('pdf','Ice','Bedrock','Lithified sediments','Dilatant till','Water','Frozen sediments','Stiff till','Best model','Median', 'Mean');
ylim([0 0.5])
set(gcf, 'Name','Z-poisson_results', 'Color','w');
inv_figure
pbaspect([1 1 1])



%% plot Z and Vs
fig6= figure; hold on;
beta_saved = models_pbi(:,6);
h = plot_zbeta_misfit(Z_saved, beta_saved);
plot_zbeta_ref;
scatter(Z_best, m_best(6), 'o','filled', 'k');
bar = errorbar(median(Z_saved), median(models_pbi(:,6)), 0.5*iqr(models_pbi(:,6)), 0.5*iqr(models_pbi(:,6)), 0.5*iqr(Z_saved), 0.5*iqr(Z_saved), 'o','Color','k');
bar.LineWidth = 1.5;


bar2 = errorbar(mean(Z_saved), mean(models_pbi(:,6)), std(models_pbi(:,6)), std(models_pbi(:,6)), std(Z_saved), std(Z_saved), 'o','Color',[0.5 0.5 0.5]);
bar2.LineWidth = 1.5;
legend('pdf','ice','bedrock','lithified till','dilatant till','water','permafrost','stiff till','best model','median', 'mean');
inv_figure
pbaspect([1 1 1])
set(gcf, 'Name','Z-Vs_results', 'Color','w');



%% plot running medians of poisson's ratio and Z to check for convergence
figure; subplot(2,1,1);
plot(runningmedianpois, 'LineWidth',1.5);
xlabel('iteration/1000')
ylabel('Poisson ratio')
inv_figure

subplot(2,1,2);
plot(runningmedianZ, 'LineWidth',1.5)
xlabel('iteration/1000')
ylabel('Acoustic impedance (kg m^{-2} s^{-1})')
inv_figure
title('Running medians');
