GUI cmd executable

1) Prepare "gui_cmd.txt" configuration file and then
   execute the .exe.

2) Command response will be written to "GuiCmdOut.txt"

3) Explanation of configuration file: "gui_cmd.txt"

COM:USB/Serial/ETHERNET
POR:Comport number(for Serial), Or Port for Ethernet
DEV:Device number
BAU:Baud rate (for Serial)
CMD:ASCII command
MOD:Arcus Model (PMX-4EX-SA, PMX-2EX-SA, etc)
IPA:192.168.1.250

Example:

COM:USB
DEV:0
CMD:SR=1
MOD:DMX-J-SA