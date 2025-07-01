function rotation_m = rotate_Y_se3(Qy)

rotation_m = [ cos(Qy), 0, sin(Qy), 0;
                     0, 1,       0, 0;
              -sin(Qy), 0, cos(Qy), 0;
                     0, 0,       0, 1];
end