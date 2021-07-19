# ArcusStageControl
A custom MATLAB Class and example for controlling any Arcus stage or motor (Arcus-Technologies Inc.)

Dependencies
- Motor or stage from Arcus-Technologies Inc.
- install Arcus-technologies stage/ motor control software depending on whether its DriveMax or PerforMax. Find in _"Arcus_installers"_ folder or download from webpage (https://www.arcus-technology.com/support/downloads/)
- MATLAB (higher versions preferable)


This code depends on simple commands (written in text _"gui_cmd.txt"_) that are passed on to the program **_"GUI_CMD.exe"_** to control any Arcus stage or motor.

The role of the developed MATLAB class (myArcus.m) is to translate comamnds from MATLAB to the text commands that can be understood by the **_"GUI_CMD_exe"_** that runs the Motor/Stage.

To Run your Motor/Stage, check the _"gui_cmd.txt"_ file, Be sure to edit it to suit your hardware. For further information concerning this read _"README.txt"_.
Example of controlling stage can be found in the _"Test_run.m"_ file
