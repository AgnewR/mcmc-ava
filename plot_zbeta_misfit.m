function h = plot_zbeta_misfit(Z_saved, beta_saved)
%plots a 2d histogram of posterior distributions in Z/Vs

h = histogram2(Z_saved,beta_saved,100, 'displaystyle', 'Tile', 'Normalization','pdf');
shading interp
xlabel('Acoustic impedance')
ylabel('Vs')
colorbar