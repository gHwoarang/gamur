function skewed = skewSymmetricMatrix(Vector)
    skewed = [         0, -Vector(3),  Vector(2);
               Vector(3),          0, -Vector(1);
              -Vector(2),  Vector(1),          0];
end