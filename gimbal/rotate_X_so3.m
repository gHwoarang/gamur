function rotation_m = rotate_X_so3(Qx)

rotation_m = [1,       0,        0;
              0, cos(Qx), -sin(Qx);
              0, sin(Qx), cos(Qx)];
end

 