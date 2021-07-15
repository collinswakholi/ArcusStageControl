% Functions for controlling Arcus DMX-J-SA stage

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

classdef MyArcus
    properties(Constant)
        H_vel = 1000; % HSPD High speed setting for stage (pps)
        L_vel = 100; % LSPD Low speed setting for stage (pps)
        Accn = 300; % Accelaration time (ms)
        time_out = 0; % Time out value (ms)
        
        
    end
    methods (Static)
        % moveHome
        function out = goHome()
            
            RunCMD('CLR')
            RunCMD('EO=1');% enable driver
            RunCMD('DL=0');% enable disable limit
            out = RunCMD('L-');% go to negative limit
            % wait till stage arrives
            
            
            jj = 1;
            while jj > 0
                if MyArcus.IsBusy<1
                    jj = 0;
                end
            end
            RunCMD('CLR');% clear limit error
           
        end
        
        % is stage busy?
        function out = IsBusy()
            out = RunCMD('MST');
            if strcmp(out,'1')
                out = 1;
            else
                out = 0;
            end
        end
        
        % abort
        function out = Abort()
            comm = 'ABORT';
            out = RunCMD(comm);
            RunCMD('CLR')
        end
        
        % stop
        function out = Stop()
            comm = 'STOP';
            out = RunCMD(comm);
            RunCMD('CLR')
        end
        
        % Enable
        function out = Enable()
            RunCMD('CLR')
            comm = 'EO';
            out = RunCMD(comm);
            if strcmp(out, '0')
               comm = 'EO';
               out = RunCMD(comm,'=1');
               RunCMD('ABORT');
            end
        end
        
        % Disable
        function out = Disable()
            RunCMD('CLR')
            comm = 'EO';
            out = RunCMD(comm);
            if strcmp(out, '1')
               comm = 'EO';
               out = RunCMD(comm,'=0');
            end
        end
        
        % Device information
        function out = DevInfo()
            out = [];
            out.ID = RunCMD('ID');
            out.Ver = RunCMD('VER');
        end
        
        % Device status
        function out = DevStat()
            comm = 'MST';
            out = RunCMD(comm);
        end
        
        % Set current position to zero
        function out = setAsZero()
            comm = 'PX';
            out = RunCMD(comm,'=0');
        end
        
        % get parameters (current position, accn and velocity)
        function out = getParams()
            out = [];
            RunCMD('CLR');
            pos = RunCMD('PX');
            l_vel = RunCMD('LSPD');
            h_vel = RunCMD('HSPD');
            accn = RunCMD('ACC');
            
            out.pos = double(pos);
            out.l_vel = double(l_vel);
            out.h_vel = double(h_vel);
            out.accn = double(accn);
        end
        
        % Jog plus
        function out = JogPlus()
            RunCMD('CLR');
            comm = 'J+';
            out = RunCMD(comm);
            RunCMD('CLR');
        end
        
        % Jog minus
        function out = JogMinus()
            RunCMD('CLR');
            comm = 'J-';
            out = RunCMD(comm);
            RunCMD('CLR');
        end
        
    
        % set move mode
        function out = setMoveMode(choice)% set move mode to INC (incremental) or ABS (abbsolute)
            out = RunCMD('MM');
            if (choice == 0)&&(out==0)
                comm = 'ABS';% for absolute mode
                out = RunCMD(comm);
            elseif (choice == 1)&&(out==1)
                comm = 'INC';% for incremental mode
                out = RunCMD(comm);
            end
        end
        
        % reset to default
        function out = resetStage()
            RunCMD('CLR');
            try
                RunCMD('HSPD',['=',num2str(MyArcus.H_vel)]);
                RunCMD('LSPD',['=',num2str(MyArcus.L_vel)]);
                RunCMD('ACC',['=',num2str(MyArcus.Accn)]);
                out = RunCMD('TOC',['=',num2str(MyArcus.time_out)]);
            catch
                out = 'check reset function again...';
            end
        end
        
        % set parameters (position, accn, velocity)
        function out = setParams(pos, l_vel, h_vel, accn)
            out = RunCMD('CLR');
            if strcmp(out, 'OK')
                RunCMD('HSPD',['=',num2str(h_vel)]);
                RunCMD('LSPD',['=',num2str(l_vel)]);
                RunCMD('ACC',['=',num2str(accn)]);
                RunCMD('X',num2str(pos));
                out = 'Done';
            end
        end
        
        % move to position
        function out = moveToAbs(pos)
            out = RunCMD('CLR');
            out2 = RunCMD('MM');
            if strcmp(out2,'0')
                RunCMD('X',num2str(pos));
            end
        end
        
        
    end
    
end