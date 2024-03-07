#!/bin/sh
cd "${0%/*}";
if [ `uname` = "Darwin" ]; then
  if [ -d "/System/Library/Frameworks/OpenGL.framework" ]; then
    "./filedialogs/build (OGL Renderer).sh";
  else
    "./filedialogs/build (SDL Renderer).sh";
  fi
elif [ $(uname) = "Linux" ]; then
  "./filedialogs/build (OGL Renderer).sh";
elif [ $(uname) = "FreeBSD" ]; then
  "./filedialogs/build (OGL Renderer).sh";
elif [ $(uname) = "DragonFly" ]; then
  "./filedialogs/build (OGL Renderer).sh";
elif [ $(uname) = "NetBSD" ]; then
  "./filedialogs/build (OGL Renderer).sh";
elif [ $(uname) = "OpenBSD" ]; then
  "./filedialogs/build (OGL Renderer).sh";
elif [ $(uname) = "SunOS" ]; then
  "./filedialogs/build (OGL Renderer).sh";
else
  echo "make sure you build the visual c++ project first found in the \"filedialogs\" sub-directory of this repository's source tree.";
  windres resources.rc -o resources.o;
  g++ main.cpp -o filedialogs.exe apiprocess/process.cpp resources.o -std=c++17 -static-libgcc -static-libstdc++ -static -lntdll;
  rm -f resources.o;
fi
