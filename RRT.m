clear all;
close all;
% Start and Goal point coordinates
start=[10 10];
goal=[90 90];
xlim([0 100])
ylim([0 100])
hold on
h=plot(start(1),start(2),'go',goal(1),goal(2),'ro');
set(h,'linewidth',5)
coord.near=[];
coord.new=[];
coord.nodes=[];
coord.dist=[];
ind=[];
coord.near(1,:)=[start(1) start(2)];
ind(1)=0;
k=1;
% Obstacle coordinates
    obs=[25 25 30 30;0 50 50 0;
        0 0 35 35;70 75 75 70
        70 70 75 75;50 100 100 50;
        55 55 100 100;25 30 30 25];
obstacles=polyshape({obs(1,:),obs(3,:),obs(5,:),obs(7,:)},{obs(2,:),obs(4,:),obs(6,:),obs(8,:)});
g=plot(obstacles);
set(g,'facecolor',[0,0,0])
% The tree branch radius, can be chnaged as required
radius=15;
coord.nodes(1,:)=[start(1) start(2)];
% Generate tree
while k>0
    % Random point generation within the radius
    [x,y]=random(coord.near(k,1),coord.near(k,2),radius);
    coord.new(k,:)=[x y];
    % Finding the nearest point
    [R,~]=size(coord.nodes);
        for j=1:R
            coord.dist(j)=sqrt((x-coord.nodes(j,1))^2+(y-coord.nodes(j,2))^2);
        end
    [M,I]=min(coord.dist);
    ind(k,1)=I;
    coord.near(k+1,:)=[coord.nodes(I,1) coord.nodes(I,2)];
    % Find if any collision
    lineseg=[coord.near(k+1,1) coord.near(k+1,2);coord.new(k,1) coord.new(k,2)];
    [in,out] = intersect(obstacles,lineseg);
        if in ~= NaN
            continue
        else
            plot([coord.near(k+1,1) coord.new(k,1)],[coord.near(k+1,2) coord.new(k,2)]);
            drawnow
        end
        % Exit loop
        if sqrt( (x-goal(1))^2 + (y-goal(2))^2 ) <= 5
            plot([x goal(1)],[y goal(2)])
            coord.nodes(k,:)=coord.new(k,:);
            ind(k,1)=length(coord.nodes);
            break
        end
    coord.nodes(k+1,:)=coord.new(k,:);
    k=k+1;
end
% To find the shortest path from start to goal point
plot([goal(1) coord.new(k,1)],[goal(2) coord.new(k,2)],'k-','linewidth',5);
a=length(coord.new);
leastDist=[];
    for n=1:length(coord.new)
        leastDist(n,:)=coord.new(a,:)-coord.new(n,:);
    end
    m=a;
 while coord.near(m+1,:)~=start
    for m=1:length(leastDist)
        if leastDist(m,1)==0 & leastDist(m,2)==0
            break
        end
    end
    plot([coord.new(m,1) coord.near(m+1,1)],[coord.new(m,2) coord.near(m+1,2)],'k-','linewidth',2)
    drawnow
    for n=1:length(coord.new)
        leastDist(n,:)=coord.near(m+1,:)-coord.new(n,:);
    end
 end
 plot([coord.near(m+1,1) start(1)],[coord.near(m+1,2) start(2)],'k-','linewidth',2);
