%% Aircraft Longitudinal Flight Control
% 
% This example shows how to model flight control for the longitudinal
% motion of an aircraft. First order linear approximations of the aircraft
% and actuator behavior are connected to an analog flight control design
% that uses the pilot's stick pitch command as the set point for the
% aircraft's pitch attitude and uses aircraft pitch angle and pitch rate to
% determine commands.   A simplified Dryden wind gust model is incorporated
% to perturb the system.
% 
% The Viewers and Generators Manager was used in this model to create the
% model scope for viewing signals, Scope1.  Found on *Simulation > Prepare
% > Viewers Manager*, the Viewers and Generators Manager allows you to
% instrument your model without having to add blocks to the model.  If you
% close a model scope, such as for batch simulations, you can later reopen
% it by double-clicking the "scope" icon on the signal of interest.
% 
% Parameters for the model are stored in a file named slexAircraftData.m.
% This file is loaded by the model into the model workspace.  You can view
% and edit data in the model workspace directly by using the Model
% Explorer, which is launched using the *Modeling > Design > Model
% Explorer* menu item.
% 

% Copyright 2012-2019 The MathWorks, Inc.

open_system('slexAircraftExample')
evalc('sim(''slexAircraftExample'')');
