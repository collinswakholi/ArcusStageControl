function Out = RunCMD(myCmd,myValue)

my_mat = readmatrix('gui_cmd.txt','OutputType','string');
if nargin<2
    myValue = [];
end

if isempty(myValue)
    CMD = myCmd;
else
    CMD = [myCmd,myValue];
end

%% write cmd to gui_cmd.txt
my_mat(3,2) = CMD;
writematrix(my_mat,'gui_cmd.txt')

%% Run

!GUI_CMD.exe

%% read outcome
Out = readmatrix('GuiCmdOut.txt','OutputType','string');
