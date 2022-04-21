Unicode True
RequestExecutionLevel user
Icon ".\filedialogs\filedialogs.ico"
OutFile ".\filedialogs.exe"
!include "FileFunc.nsh"
SilentInstall silent
Section "filedialogs"
  SetOutPath `$LOCALAPPDATA\__filedialogs__`
  File ".\filedialogs\filedialogs.exe"
  File ".\filedialogs\SDL2.dll"
  File /r ".\filedialogs\fonts"
  ${GetParameters} $0
  nsExec::ExecToStack '"$LOCALAPPDATA\__filedialogs__\filedialogs.exe" $0'
  Pop $0
  Pop $1
  System::Call 'kernel32::GetStdHandle(i -11)i.r0' 
  System::Call 'kernel32::AttachConsole(i -1)' 
  FileWrite $0 $1
  RMDir /r `$LOCALAPPDATA\__filedialogs__`
SectionEnd
