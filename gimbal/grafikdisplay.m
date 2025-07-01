x = 0.01:0.10:3;

y1= x.^2+x

y2= x.^3



% Plot the trajectories
plot(x, y1, '-s','DisplayName','aq');
hold on;
plot(x, y2 , '-o' );


% Add a title and labels
title('Trajectories of Two Objects');
xlabel('X-Axis');
ylabel('Y-Axis');

% Add a grid
grid on;

% Add a legend
legend('Location', 'Northwest');
