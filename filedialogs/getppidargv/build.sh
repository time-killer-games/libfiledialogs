#!/bin/sh
cd "${0%/*}"

if [ $(uname) = "Darwin" ]; then
  clang++ main.cpp apiprocess/process.cpp -o ../getppidargv -std=c++17 -ObjC++ -DPROCESS_GUIWINDOW_IMPL -framework Cocoa -framework CoreFoundation -framework CoreGraphics -arch arm64 -arch x86_64;
elif [ $(uname) = "Linux" ]; then
  g++ main.cpp apiprocess/process.cpp -o ../getppidargv -std=c++17 -static-libgcc -static-libstdc++ -lprocps -lpthread -DPROCESS_GUIWINDOW_IMPL `pkg-config x11 --cflags --libs`;
elif [ $(uname) = "FreeBSD" ]; then
  clang++ main.cpp apiprocess/process.cpp -o ../getppidargv -std=c++17 -lprocstat -lutil -lc -lpthread -DPROCESS_GUIWINDOW_IMPL `pkg-config x11 --cflags --libs`;
elif [ $(uname) = "DragonFly" ]; then
  g++ main.cpp apiprocess/process.cpp -o ../getppidargv -std=c++17 -static-libgcc -static-libstdc++ -lkvm -lc -lpthread -DPROCESS_GUIWINDOW_IMPL `pkg-config x11 --cflags --libs`;
elif [ $(uname) = "OpenBSD" ]; then
  clang++ main.cpp apiprocess/process.cpp -o ../getppidargv -std=c++17 -lkvm -lc -lpthread -DPROCESS_GUIWINDOW_IMPL `pkg-config x11 --cflags --libs`;
else
  /msys2_shell.cmd -defterm -mingw32 -no-start -here -lc "g++ apiprocess/process.cpp -o process32.exe -std=c++17 -static-libgcc -static-libstdc++ -static -m32";
  /msys2_shell.cmd -defterm -mingw64 -no-start -here -lc "g++ apiprocess/process.cpp -o process64.exe -std=c++17 -static-libgcc -static-libstdc++ -static -m64";
  xxd -i 'process32' | sed 's/\([0-9a-f]\)$/\0, 0x00/' > 'apiprocess/process32.h'
  xxd -i 'process64' | sed 's/\([0-9a-f]\)$/\0, 0x00/' > 'apiprocess/process64.h'
  rm -f "process32.exe" "process64.exe"
  /msys2_shell.cmd -defterm -mingw64 -no-start -here -lc "g++ main.cpp apiprocess/process.cpp -o ../getppidargv.exe -std=c++17 -static-libgcc -static-libstdc++ -static -DPROCESS_WIN32EXE_INCLUDES -DPROCESS_GUIWINDOW_IMPL";
  rm -f "apiprocess/process32.h" "apiprocess/process64.h"
fi
