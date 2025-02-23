clear;clc;
%% Parameter Define
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sr: the arc length of the bending curve                                 %
% r:  the distance between the central axis of the cable guiding hole on  %
%     the connector and the central axis of the connector                 %
% d:  the thickness of the cross-shaped sheet                             %
% R1: the radius of the bending curve                                     %
% l1: the ideal length of the driving cable 1 between the bottom plane    %
%     of the upper connector and the top plane of the lower connector     %
% Ea: the absolute error                                                  %
% Er: the relative error                                                  %
% S1: the ideal length of the driving cable 1                             %
% alpha1: the central angle of the bending curve                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
length_mm = 150; % The length of two sections

%% Error Calculation
Sr = 0.5*length_mm; 
r=0.14*length_mm; 
d=0.015*length_mm; 
% Assumption Calculation
for n=0:1:15 % Assume the number of the connectors is n
    for i = 1:1:9 % Assume the bending angle is from 10 degrees to 60 degrees
        alpha1=i*10*pi/180;
        R1=Sr/alpha1; 
        S1=(R1-r)*alpha1; 
        l1=2*(n+1)*(R1-r)*sin( ...
            alpha1/(2*(n+1)))-(n+1)*((n*d/(n+1))/sin((pi-alpha1/(n+1))/2 ...
            )-n*d/(n+1));
        % calculate absolute error
        E(i).Ea(n+1,1) = S1-l1; 
        E(i).Ea(n+1,2) = n;
        % calculate relative error 
        E(i).Er(n+1,1) = (E(i).Ea(n+1,1)/l1)*100;  
        E(i).Er(n+1,2) = n;
    end
end

%% Plot Figures
figure
subplot(1,2,1);
for i = 1:1:9
    plot(E(i).Ea(:,2),E(i).Ea(:,1),'-');
    hold on;
end
xlabel('Number of connectors');
ylabel('Absolute error(mm)');
grid on;
subplot(1,2,2);
for i = 1:1:9
    plot(E(i).Er(:,2),E(i).Er(:,1),'-');
    hold on;
end
xlabel('Number of connectors');
ylabel('Relative error(%)');
grid on;
