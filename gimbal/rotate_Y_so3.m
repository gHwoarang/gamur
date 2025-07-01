function rotation_m = rotate_Y_so3(Qy)

rotation_m = [ cos(Qy), 0, sin(Qy);
                     0, 1,       0;
              -sin(Qy), 0, cos(Qy)];
end