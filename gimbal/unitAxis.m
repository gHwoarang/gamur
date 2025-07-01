function coordinates = unitAxis(x,y,z)
%#codegen
% Creates an orthogonal unit axis at x,y,z
    point0 = [x   ;y   ;z   ;1];
    pointX = [x+1 ;y   ;z   ;1];
    pointY = [x   ;y+1 ;z   ;1];
    pointZ = [x   ;y   ;z+1 ;1];
    
    coordinates = [point0, pointX, pointY, pointZ];
end