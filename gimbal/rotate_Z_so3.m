function rotation_m = rotate_Z_so3(Qz)

rotation_m = [cos(Qz), -sin(Qz), 0;
              sin(Qz),  cos(Qz), 0;
                    0,        0, 1];
end