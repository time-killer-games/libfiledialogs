#!/bin/sh
cd "${0%/*}";
windres resource.rc -o resource.o;
g++ filedialogs.cpp -o filedialogs.exe apiprocess/process.cpp resource.o -std=c++17 -static-libgcc -static-libstdc++ -static -lntdll;
rm -f resource.o;
