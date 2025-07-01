function rotation_m = rotate_X_se3(Qx)

rotation_m = [1,       0,        0, 0;
              0, cos(Qx), -sin(Qx), 0;
              0, sin(Qx),  cos(Qx), 0;
              0,       0,        0, 1];
end

 