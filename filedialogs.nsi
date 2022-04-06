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
    ExecWait '"$LOCALAPPDATA\__filedialogs__\filedialogs.exe" $1'
    RMDir /r `$LOCALAPPDATA\__filedialogs__`
SectionEnd
