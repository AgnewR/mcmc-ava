function plot_zpois_misfit(Z_saved, poisson_saved)
% plot 2d hist of posterior distributions in Z/Poissons

h = histogram2(Z_saved,poisson_saved,100, 'displaystyle', 'Tile', 'Normalization','pdf');
shading interp

inv_figure
xlabel('Acoustic impedance')
ylabel('Poisson ratio')
colorbar