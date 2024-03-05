#!/bin/sh
# this build script is intended for windows-only; packs all fonts and other files and compiles into a single executable file.
# make sure you build the visual c++ project first found in the "filedialogs" sub-directory of this repository's source tree.
# run "filedialogs/build.sh" instead of this script to build on all non-windows platforms: macos, linux, bsd, sunos, android.
# android building requires the cxxdroid app from google play: https://play.google.com/store/apps/details?id=ru.iiec.cxxdroid
cd "${0%/*}";
windres resources.rc -o resources.o;
g++ main.cpp -o filedialogs.exe apiprocess/process.cpp resources.o -std=c++17 -static-libgcc -static-libstdc++ -static -lntdll;
rm -f resources.o;
