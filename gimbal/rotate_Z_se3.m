function rotation_m = rotate_Z_se3(Qz)

rotation_m = [cos(Qz), -sin(Qz), 0, 0;
              sin(Qz),  cos(Qz), 0, 0;
                    0,        0, 1, 0;
                    0,        0, 0, 1];
end