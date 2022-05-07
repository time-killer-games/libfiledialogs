#!/bin/sh
cd "${0%/*}"

# build command line executable
if [ `uname` = "Darwin" ]; then
  clang++ "/opt/local/lib/libSDL2.a" "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_sdlrenderer.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/opt/local/include -I/opt/local/include/SDL2 -std=c++17 -Wno-format-security -ObjC++ -liconv -Wl,-framework,CoreAudio -Wl,-framework,AudioToolbox -Wl,-weak_framework,CoreHaptics -Wl,-weak_framework,GameController -Wl,-framework,ForceFeedback -lobjc -Wl,-framework,CoreVideo -Wl,-framework,Cocoa -Wl,-framework,Carbon -Wl,-framework,IOKit -Wl,-weak_framework,QuartzCore -Wl,-weak_framework,Metal -fPIC -arch arm64 -arch x86_64 -fPIC
elif [ $(uname) = "Linux" ]; then
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` -lGL -lpthread -no-pie -fPIC
elif [ $(uname) = "FreeBSD" ]; then
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -DIMGUI_USE_WCHAR32 `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "DragonFly" ]; then
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "NetBSD" ]; then
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "OpenBSD" ]; then
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs" -std=c++17 -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/usr/local/include `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
else
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "main.cpp" -o "filedialogs.exe" -std=c++17 -I. -D_UNICODE -DUNICODE -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ -static `pkg-config --cflags --libs sdl2 --static` -lopengl32 -lshell32 -ldwmapi -fPIC
fi

# build shared library
if [ `uname` = "Darwin" ]; then
  clang++ "/opt/local/lib/libSDL2.a" "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_sdlrenderer.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.dylib" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/opt/local/include -I/opt/local/include/SDL2 -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -ObjC++ -liconv -Wl,-framework,CoreAudio -Wl,-framework,AudioToolbox -Wl,-weak_framework,CoreHaptics -Wl,-weak_framework,GameController -Wl,-framework,ForceFeedback -lobjc -Wl,-framework,CoreVideo -Wl,-framework,Cocoa -Wl,-framework,Carbon -Wl,-framework,IOKit -Wl,-weak_framework,QuartzCore -Wl,-weak_framework,Metal -fPIC -arch arm64 -arch x86_64 -fPIC
elif [ $(uname) = "Linux" ]; then
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` -lGL -lpthread -fPIC
elif [ $(uname) = "FreeBSD" ]; then
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "DragonFly" ]; then
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "NetBSD" ]; then
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
elif [ $(uname) = "OpenBSD" ]; then
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/usr/local/include `pkg-config --cflags --libs sdl2 --static` -lGL -lc -lpthread -fPIC
else
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl2.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" -o "libfiledialogs.dll" -std=c++17 -DIFD_SHARED_LIBRARY -shared -I. -D_UNICODE -DUNICODE -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ -static `pkg-config --cflags --libs sdl2 --static` -lopengl32 -lshell32 -ldwmapi -fPIC
fi
