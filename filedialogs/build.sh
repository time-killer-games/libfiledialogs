#!/bin/sh
cd "${0%/*}"

# build command line executable
if [ `uname` = "Darwin" ]; then
  clang++ "/opt/local/lib/libSDL2.a" "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_sdlrenderer.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/opt/local/include -I/opt/local/include/SDL2 -std=c++17 -Wno-format-security -ObjC++ -liconv -Wl,-framework,CoreAudio -Wl,-framework,AudioToolbox -Wl,-weak_framework,CoreHaptics -Wl,-weak_framework,GameController -Wl,-framework,ForceFeedback -lobjc -Wl,-framework,CoreVideo -Wl,-framework,Cocoa -Wl,-framework,Carbon -Wl,-framework,IOKit -Wl,-weak_framework,QuartzCore -Wl,-weak_framework,Metal -fPIC -arch arm64 -arch x86_64 -fPIC
  cp -f "filedialogs" "../filedialogs.app/Contents/MacOS/filedialogs"
elif [ $(uname) = "Linux" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lpthread -no-pie -fPIC
elif [ $(uname) = "FreeBSD" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "DragonFly" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "NetBSD" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "OpenBSD" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -I/usr/local/include `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lkvm -lpthread -fPIC
elif [ $(uname) = "SunOS" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -Llunasvg -llunasvg -ISunOS -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
else
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs.exe" -std=c++17 -I. -D_UNICODE -DUNICODE -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ -static `pkg-config --cflags --libs sdl2 --static` -lopengl32 -lshell32 -ldwmapi -fPIC
fi

# build shared library
if [ `uname` = "Darwin" ]; then
  clang++ "/opt/local/lib/libSDL2.a" "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_sdlrenderer.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.dylib" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/opt/local/include -I/opt/local/include/SDL2 -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -ObjC++ -liconv -Wl,-framework,CoreAudio -Wl,-framework,AudioToolbox -Wl,-weak_framework,CoreHaptics -Wl,-weak_framework,GameController -Wl,-framework,ForceFeedback -lobjc -Wl,-framework,CoreVideo -Wl,-framework,Cocoa -Wl,-framework,Carbon -Wl,-framework,IOKit -Wl,-weak_framework,QuartzCore -Wl,-weak_framework,Metal -fPIC -arch arm64 -arch x86_64 -fPIC
elif [ $(uname) = "Linux" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lpthread -fPIC
elif [ $(uname) = "FreeBSD" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "DragonFly" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "NetBSD" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "OpenBSD" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -I/usr/local/include `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lkvm -lpthread -fPIC
elif [ $(uname) = "SunOS" ]; then
  cd "lunasvg" && cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -Llunasvg -llunasvg -ISunOS -DIMGUI_USE_WCHAR32 -static-libgcc `pkg-config --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lGL -lc -lpthread -fPIC
else
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.dll" -std=c++17 -DIFD_SHARED_LIBRARY -shared -I. -D_UNICODE -DUNICODE -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ -static `pkg-config --cflags --libs sdl2 --static` -lopengl32 -lshell32 -ldwmapi -fPIC
fi
