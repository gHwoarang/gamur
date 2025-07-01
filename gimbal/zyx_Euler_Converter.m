function zyx_Euler_converter = zyx_Euler_Converter(gamma, theta)

zyx_Euler_converter = [1, sin(gamma)*tan(theta), cos(gamma)*tan(theta);
                       0,            cos(gamma),           -sin(gamma);
                       0, sin(gamma)*sec(theta), cos(gamma)*sec(theta)];
end

 