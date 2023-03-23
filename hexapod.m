clc
close all
clear 
%% initial parameters
radius =6;
center = [5 5];
h = 5;
angle = [0 30 120 180 -120 -30];
base = [cos(0) sin(0);
        cos(pi/3) sin(pi/3);
        cos(2*pi/3) sin(2*pi/3);
        cos(pi) sin(pi);
        cos(-2*pi/3) sin(-2*pi/3);
        cos(-pi/3) sin(-pi/3)];

length1 = 6;
length2 = 6;
[body_joint, leg_joint, feet] = JointPos(radius, base, center, h, length1, length2); % compute initial joint position
Draw(body_joint, center, h, leg_joint, feet) % Draw initial joint
%% Move
for y=0:60
%% Step1
for i=0:5:30
    if (i<=15)
        beta = (i*2)*pi/180;
    else
        beta = (60-i*2)*pi/180;
    end
    k=2;
        angle2 = angle(1,2)/2-i;
        alpha = pi*angle2/180;
        leg_joint(2,1) = body_joint(k,1)+length1*sin(alpha);
        leg_joint(2,2) = body_joint(k,2)+length1*cos(alpha);
        %
        feet(2,:) = leg_joint(k,:);
        feet(2,1) = feet(k,1)+length2*sin(beta)*sin(alpha);
        feet(2,2) = feet(k,2)+length2*sin(beta)*cos(alpha);
        feet(2,3) = feet(k,3)-length2*cos(beta);
    k=4;
        angle4 = angle(1,4)/2-i;
        alpha = -pi*angle4/180;
        leg_joint(4,1) = body_joint(k,1)+length1*sin(alpha);
        leg_joint(4,2) = body_joint(k,2)+length1*cos(alpha);
        %
        feet(4,:) = leg_joint(k,:);
        feet(4,1) = feet(k,1)+length2*sin(beta)*sin(alpha);
        feet(4,2) = feet(k,2)+length2*sin(beta)*cos(alpha);
        feet(4,3) = feet(k,3)-length2*cos(beta);
    k=6;
        angle6 = angle(1,6)/2-i-180;
        alpha = pi*angle6/180;
        leg_joint(6,1) = body_joint(k,1)+length1*sin(alpha);
        leg_joint(6,2) = body_joint(k,2)+length1*cos(alpha);
        %
        feet(6,:) = leg_joint(k,:);
        feet(6,1) = feet(k,1)+length2*sin(beta)*sin(alpha);
        feet(6,2) = feet(k,2)+length2*sin(beta)*cos(alpha);
        feet(6,3) = feet(k,3)-length2*cos(beta);
Draw(body_joint, center, h, leg_joint, feet)
end
%% Step 2
center = center+[0 0.2];
[body_joint, leg_joint, feet] = JointPos(radius, base, center, h, length1, length2); % Tinh toa do cac khop
Draw(body_joint, center, h, leg_joint, feet)
%% Step3
for i=0:5:30
    if (i<=15)
        beta = (i*2)*pi/180;
    else
        beta = (60-i*2)*pi/180;
    end
    k=3;
        angle3 = angle(1,1)/2-i+30;
        alpha = -pi*angle3/180;
        leg_joint(k,1) = body_joint(k,1)+length1*sin(alpha);
        leg_joint(k,2) = body_joint(k,2)+length1*cos(alpha);
        %
        feet(k,:) = leg_joint(k,:);
        feet(k,1) = feet(k,1)+length2*sin(beta)*sin(alpha);
        feet(k,2) = feet(k,2)+length2*sin(beta)*cos(alpha);
        feet(k,3) = feet(k,3)-length2*cos(beta);
    k=5;
        angle5 = angle(1,5)/2-i+210;
        alpha = -pi*angle5/180;
        leg_joint(k,1) = body_joint(k,1)+length1*sin(alpha);
        leg_joint(k,2) = body_joint(k,2)+length1*cos(alpha);
        %
        feet(k,:) = leg_joint(k,:);
        feet(k,1) = feet(k,1)+length2*sin(beta)*sin(alpha);
        feet(k,2) = feet(k,2)+length2*sin(beta)*cos(alpha);
        feet(k,3) = feet(k,3)-length2*cos(beta);
    k=1;
        angle1 = angle(1,1)/2-i+90;
        alpha = pi*angle1/180;
        leg_joint(k,1) = body_joint(k,1)+length1*sin(alpha);
        leg_joint(k,2) = body_joint(k,2)+length1*cos(alpha);
        %
        feet(k,:) = leg_joint(k,:);
        feet(k,1) = feet(k,1)+length2*sin(beta)*sin(alpha);
        feet(k,2) = feet(k,2)+length2*sin(beta)*cos(alpha);
        feet(k,3) = feet(k,3)-length2*cos(beta);
Draw(body_joint, center, h, leg_joint, feet)
end
%% Step 4
center = center+[0 0.2];
[body_joint, leg_joint, feet] = JointPos(radius, base, center, h, length1, length2);
Draw(body_joint, center, h, leg_joint, feet)
end
%% Function: compute joint pos
function  [body_joint, leg_joint, feet] = JointPos(radius, base, center, h, length1, length2)
% body joints
body_joint = [];
for i=1:6 
    tmp = [body_joint; [radius*base(i,:)+center h]];
    body_joint = tmp;
end
centerjoint1 = body_joint(:,1:2);
% leg joints
leg_joint = [];
for i=1:6
    tmp = [leg_joint; [length1*base(i,:)+centerjoint1(i,:) h]];
    leg_joint = tmp;
end     
% feet joints
feet = [];
for i=1:6
    tmp = [feet; leg_joint(i,1:2) leg_joint(i,3)-length2];
    feet = tmp;
end
end
%% Function: Draw
function Draw(body_joint, center, h, leg_joint, feet)
% Draw body
p1 = plot3([body_joint(:,1); body_joint(1,1)], [body_joint(:,2); body_joint(1,2)], [body_joint(:,3); body_joint(1,3)], 'o-red');
p1.LineWidth = 3;
% Draw center
hold on
plot3(center(1), center(2), h, '*-red')
% Draw leg
for i=1:6
    hold on
    p2 = plot3([body_joint(i,1); leg_joint(i,1)], [body_joint(i,2); leg_joint(i,2)], [body_joint(i,3); leg_joint(i,3)], 'o-red');
    p2.LineWidth = 2;
end
% Draw feet
for i=1:6
    hold on
    p3 = plot3([feet(i,1); leg_joint(i,1)], [feet(i,2); leg_joint(i,2)], [feet(i,3); leg_joint(i,3)], 'x-red');
    p3.LineWidth = 2;
end
grid on
axis([-10 20 -10 40 -5 5]);
set(gca, 'DataAspectRatio',[1 1 1])
pause(.0001);
hold off
end