function [obj1, obj2, obj3] = unitAxis_Drawer(coordinates, color1, color2, color3, arg)
    lineX = [coordinates(:,1), coordinates(:,2)];
    lineY = [coordinates(:,1), coordinates(:,3)];
    lineZ = [coordinates(:,1), coordinates(:,4)];
    if arg == 1
        obj1 = plot3(lineX(1,:), lineX(2,:), lineX(3,:), color1, LineWidth=2);
        obj2 = plot3(lineY(1,:), lineY(2,:), lineY(3,:), color2);
        obj3 = plot3(lineZ(1,:), lineZ(2,:), lineZ(3,:), color3);
    elseif arg == 2
        delta_X = lineX(1,2)-lineX(1,1);
        delta_Y = lineX(2,2)-lineX(2,1);
        delta_Z = lineX(3,2)-lineX(3,1);
        lineX(1,2) = lineX(1,2) + 50*delta_X;
        lineX(2,2) = lineX(2,2) + 50*delta_Y;
        lineX(3,2) = lineX(3,2) + 50*delta_Z;

        obj1 = plot3(lineX(1,:), lineX(2,:), lineX(3,:), color1);
        obj2 = plot3(lineY(1,:), lineY(2,:), lineY(3,:), color2);
        obj3 = plot3(lineZ(1,:), lineZ(2,:), lineZ(3,:), color3);
    end
end