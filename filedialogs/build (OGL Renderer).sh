#!/bin/sh
cd "${0%/*}"

# build command line executable
if [ `uname` = "Darwin" ]; then
  sudo port install libsdl2 +universal python311 ninja && git clone https://chromium.googlesource.com/angle/angle && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && sudo port select --set python python311 && export PATH=`pwd`/depot_tools:"$PATH" && cd angle && python scripts/bootstrap.py && gclient sync && git checkout main;
  mkdir ../arm64 && gn gen ../arm64 && echo "target_cpu = \"arm64\"" >> ../arm64/args.gn && echo "angle_enable_metal=true" >> ../arm64/args.gn && echo "mac_deployment_target=\"11.0\"" >> ../arm64/args.gn && GYP_GENERATORS=ninja gclient runhooks && ninja -j 10 -k1 -C ../arm64 && mkdir ../x86_64 && gn gen ../x86_64 && echo "target_cpu = \"x64\"" >> ../x86_64/args.gn && echo "angle_enable_metal=true" >> ../x86_64/args.gn && echo "mac_deployment_target=\"10.14\"" >> ../x86_64/args.gn && GYP_GENERATORS=ninja gclient runhooks && ninja -j 10 -k1 -C ../x86_64;
  lipo -create -output ../libEGL.dylib ../arm64/libEGL.dylib ../x86_64/libEGL.dylib
  lipo -create -output ../libGLESv2.dylib ../arm64/libGLESv2.dylib ../x86_64/libGLESv2.dylib
  lipo -create -output ../libc++_chrome.dylib ../arm64/libc++_chrome.dylib ../x86_64/libc++_chrome.dylib
  lipo -create -output ../libchrome_zlib.dylib ../arm64/libchrome_zlib.dylib ../x86_64/libchrome_zlib.dylib
  lipo -create -output ../libthird_party_abseil-cpp_absl.dylib ../arm64/libthird_party_abseil-cpp_absl.dylib ../x86_64/libthird_party_abseil-cpp_absl.dylib
  lipo -create -output ../libdawn_proc.dylib ../arm64/libdawn_proc.dylib ../x86_64/libdawn_proc.dylib
  lipo -create -output ../libdawn_native.dylib ../arm64/libdawn_native.dylib ../x86_64/libdawn_native.dylib
  lipo -create -output ../libdawn_platform.dylib ../arm64/libdawn_platform.dylib ../x86_64/libdawn_platform.dylib
  cd ..;
  clang++ "/opt/local/lib/libSDL2.a" "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" -o "filedialogs" -std=c++17 -DIFD_USE_OPENGL -framework OpenGL -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/opt/local/include -I/opt/local/include/SDL2 -Iangle/include -L. -ObjC++ -liconv -lEGL -lGLESv2 -Wl,-framework,CoreAudio -Wl,-framework,AudioToolbox -Wl,-weak_framework,CoreHaptics -Wl,-weak_framework,GameController -Wl,-framework,ForceFeedback -lobjc -Wl,-framework,CoreVideo -Wl,-framework,Cocoa -Wl,-framework,Carbon -Wl,-framework,IOKit -Wl,-weak_framework,QuartzCore -Wl,-weak_framework,Metal -fPIC -arch arm64 -arch x86_64 -fPIC
  install_name_tool -change @rpath/libEGL.dylib @loader_path/libEGL.dylib ./filedialogs; install_name_tool -change @rpath/libGLESv2.dylib @loader_path/libGLESv2.dylib ./filedialogs;
  cp -f "libEGL.dylib" "../filedialogs.app/Contents/MacOS/libEGL.dylib"
  cp -f "libGLESv2.dylib" "../filedialogs.app/Contents/MacOS/libGLESv2.dylib"
  cp -f "libc++_chrome.dylib" "../filedialogs.app/Contents/MacOS/libc++_chrome.dylib"
  cp -f "libchrome_zlib.dylib" "../filedialogs.app/Contents/MacOS/libchrome_zlib.dylib"
  cp -f "libthird_party_abseil-cpp_absl.dylib" "../filedialogs.app/Contents/MacOS/libthird_party_abseil-cpp_absl.dylib"
  cp -f "libdawn_proc.dylib" "../filedialogs.app/Contents/MacOS/libdawn_proc.dylib"
  cp -f "libdawn_native.dylib" "../filedialogs.app/Contents/MacOS/libdawn_native.dylib"
  cp -f "libdawn_platform.dylib" "../filedialogs.app/Contents/MacOS/libdawn_platform.dylib"
  cp -f "filedialogs" "../filedialogs.app/Contents/MacOS/filedialogs"
elif [ $(uname) = "Linux" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" -o "filedialogs" -std=c++17 -DIFD_USE_OPENGL -lGL -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lpthread -no-pie -fPIC
elif [ $(uname) = "FreeBSD" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" -o "filedialogs" -std=c++17 -DIFD_USE_OPENGL -lGL -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
elif [ $(uname) = "DragonFly" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" -o "filedialogs" -std=c++17 -DIFD_USE_OPENGL -lGL -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
elif [ $(uname) = "NetBSD" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" -o "filedialogs" -std=c++17 -DIFD_USE_OPENGL -lGL -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
elif [ $(uname) = "OpenBSD" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" -o "filedialogs" -std=c++17 -DIFD_USE_OPENGL -lGL -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -I/usr/local/include `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lkvm -lpthread -fPIC
elif [ $(uname) = "SunOS" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  export PKG_CONFIG_PATH=/usr/lib/64/pkgconfig && g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" -o "filedialogs" -std=c++17 -DIFD_USE_OPENGL -lGL -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
else
  windres "resources.rc" -o "resources.o"
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" "main.cpp" "resources.o" -o "filedialogs.exe" -std=c++17 -DIFD_USE_OPENGL -lopengl32 -I. -D_UNICODE -DUNICODE -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ -static `pkg-config --cflags --libs sdl2 --static` -lshell32 -fPIC
  rm -f "resources.o"
fi

# build shared library
if [ `uname` = "Darwin" ]; then
  clang++ "/opt/local/lib/libSDL2.a" "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.dylib" -std=c++17 -DIFD_USE_OPENGL -framework OpenGL -DIFD_SHARED_LIBRARY -shared -Wno-format-security -I. -DIMGUI_USE_WCHAR32 -I/opt/local/include -I/opt/local/include/SDL2 -Iangle/include -L. -ObjC++ -liconv -lEGL -lGLESv2 -Wl,-framework,CoreAudio -Wl,-framework,AudioToolbox -Wl,-weak_framework,CoreHaptics -Wl,-weak_framework,GameController -Wl,-framework,ForceFeedback -lobjc -Wl,-framework,CoreVideo -Wl,-framework,Cocoa -Wl,-framework,Carbon -Wl,-framework,IOKit -Wl,-weak_framework,QuartzCore -Wl,-weak_framework,Metal -fPIC -arch arm64 -arch x86_64 -fPIC
  install_name_tool -change @rpath/libEGL.dylib @loader_path/libEGL.dylib ./libfiledialogs.dylib; install_name_tool -change @rpath/libGLESv2.dylib @loader_path/libGLESv2.dylib ./libfiledialogs.dylib;
  rm -fr "angle" "depot_tools" "arm64" "x86_64"
elif [ $(uname) = "Linux" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_USE_OPENGL -DIFD_SHARED_LIBRARY -lGL -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lpthread -fPIC
elif [ $(uname) = "FreeBSD" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_USE_OPENGL -DIFD_SHARED_LIBRARY -lGL -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
elif [ $(uname) = "DragonFly" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_USE_OPENGL -DIFD_SHARED_LIBRARY -lGL -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
elif [ $(uname) = "NetBSD" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_USE_OPENGL -DIFD_SHARED_LIBRARY -lGL -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
elif [ $(uname) = "OpenBSD" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  clang++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_USE_OPENGL -DIFD_SHARED_LIBRARY -lGL -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -I/usr/local/include `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lkvm -lpthread -fPIC
elif [ $(uname) = "SunOS" ]; then
  cd "lunasvg" && rm -f "CMakeCache.txt" &&  cmake . && make && cd ..;
  export PKG_CONFIG_PATH=/usr/lib/64/pkgconfig && g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.so" -std=c++17 -DIFD_USE_OPENGL -DIFD_SHARED_LIBRARY -lGL -shared -Wno-format-security -I. -Llunasvg -llunasvg -DIMGUI_USE_WCHAR32 -static-libgcc `pkg-config --cflags --libs sdl2 --static` `pkg-config --cflags --libs gtk+-3.0` `pkg-config --cflags --libs gio-2.0` `pkg-config --cflags --libs glib-2.0` -lX11 -lc -lpthread -fPIC
else
  g++ "ImFileDialog.cpp" "imgui.cpp" "imgui_impl_sdl.cpp" "imgui_impl_opengl3.cpp" "imgui_draw.cpp" "imgui_tables.cpp" "imgui_widgets.cpp" "filesystem.cpp" "filedialogs.cpp" "msgbox/imguial_msgbox.cpp" -o "libfiledialogs.dll" -std=c++17 -DIFD_USE_OPENGL -DIFD_SHARED_LIBRARY -lopengl32 -shared -I. -D_UNICODE -DUNICODE -DIMGUI_USE_WCHAR32 -static-libgcc -static-libstdc++ -static `pkg-config --cflags --libs sdl2 --static` -lshell32 -fPIC
fi
