clear; clc;

%% functions Available

% MyArcus.goHome
% MyArcus.Abort
% MyArcus.Stop
% MyArcus.Enable
% MyArcus.Disable
% MyArcus.DevInfo
% MyArcus.DevStat
% MyArcus.setAsZero
% MyArcus.getParams
% MyArcus.JogPlus
% MyArcus.JogMinus
% MyArcus.setMoveMode
% MyArcus.resetStage
% MyArcus.moveToAbs
% MyArcus.setParams
% My Arcus.IsBusy

%% 

Res = MyArcus.Enable; % enable stage 

MyArcus.resetStage; % reset stage variables to default

kk = 1;
MyArcus.goHome; % send stage home
while kk > 0 % wait for command reach stage
    out = MyArcus.IsBusy;
    if out == 1
        break;
    end
end

kk = 1; % wait for stage to go home
while kk>0
  out = MyArcus.IsBusy;
  if out==0
     kk = 0;
  else
     kk = kk+1;

  end
end


MyArcus.setAsZero; % set home position as zero

info = MyArcus.DevInfo; % get device info
params = MyArcus.getParams; % get stage parameters (velocity, accelaration, position)

velocity = params.h_vel;
acceleartion = params.accn;
current_position = params.pos;


MyArcus.setMoveMode('ABS'); % set move mode to 'ABS' for absolute or 'INC' incremental

% set parameters
h_vel = 500; % highest velocity
l_vel = 100; % lowest velocity
accn = 30;
pos = 60000;% device units (NOTE: you have to amke your own calibration of the stage)

MyArcus.setParams(pos, l_vel, h_vel, acc);

% OR

pos = 3000;
MyArcus.moveToAbs(pos)

% stop all motion
MyArcus.Stop;

% disconnect
MyArcus.Disable


