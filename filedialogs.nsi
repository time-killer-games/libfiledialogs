Unicode True
RequestExecutionLevel user
Icon ".\filedialogs\filedialogs.ico"
OutFile ".\filedialogs.exe"
SilentInstall silent
Section "filedialogs"
  SetOutPath `$LOCALAPPDATA\__filedialogs__`
  File /r ".\filedialogs\*.*"
  nsExec::ExecToStack "$LOCALAPPDATA\__filedialogs__\getppidargv.exe"
  Pop $0
  Pop $1
  nsExec::ExecToStack '"$LOCALAPPDATA\__filedialogs__\filedialogs.exe" $1'
  Pop $0
  Pop $1
  System::Call 'kernel32::GetStdHandle(i -11)i.r0' 
  System::Call 'kernel32::AttachConsole(i -1)' 
  FileWrite $0 $1
  RMDir /r `$LOCALAPPDATA\__filedialogs__`
SectionEnd
