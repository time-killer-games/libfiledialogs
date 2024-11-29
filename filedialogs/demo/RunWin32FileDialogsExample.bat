@echo off
cd /d "%~dp0"
GetForegroundWindow > GetForegroundWindow.txt
set /p IMGUI_DIALOG_PARENT=< GetForegroundWindow.txt
set IMGUI_DIALOG_WIDTH=720
set IMGUI_DIALOG_HEIGHT=380
set IMGUI_DIALOG_THEME=2
set IMGUI_TEXT_COLOR_0=1
set IMGUI_TEXT_COLOR_1=1
set IMGUI_TEXT_COLOR_2=1
set IMGUI_HEAD_COLOR_0=0.35
set IMGUI_HEAD_COLOR_1=0.35
set IMGUI_HEAD_COLOR_2=0.35
set IMGUI_AREA_COLOR_0=0.05
set IMGUI_AREA_COLOR_1=0.05
set IMGUI_AREA_COLOR_2=0.05
set IMGUI_BODY_COLOR_0=1
set IMGUI_BODY_COLOR_1=1
set IMGUI_BODY_COLOR_2=1
set IMGUI_POPS_COLOR_0=0.07
set IMGUI_POPS_COLOR_1=0.07
set IMGUI_POPS_COLOR_2=0.07
..\filedialogs --get-open-filename "Portable Network Graphic (*.png)|*.png|Graphic Interchange Format (*.gif)|*.gif" "Untitled.png"