function [x,y]= random(x_val,y_val,delta)

while 1
lim_x=[x_val-delta x_val+delta];
lim_y=[y_val-delta y_val+delta];
    x=randi(lim_x);
    y=randi(lim_y);
        if [x y]>0 & [x y]<100
            break
        end
end
    