%% Inverted Pendulum with Animation
% 
% This example shows how to model an inverted pendulum.  The animation is created using MATLAB(R) Handle Graphics(R).  The animation block is a masked
% S-function.  For more information, use the context menu to look under the Animation block's mask
% and open the S-function for editing.

open_system('penddemo');
set_param('penddemo', 'StopTime', '10');
sim('penddemo');

%% 
% Copyright 2012 The MathWorks, Inc.