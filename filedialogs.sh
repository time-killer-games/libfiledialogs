#!/bin/sh
cd "${0%/*}";
windres resources.rc -o resources.o;
g++ filedialogs.cpp -o filedialogs.exe apiprocess/process.cpp resources.o -std=c++17 -static-libgcc -static-libstdc++ -static -lntdll;
rm -f resources.o;
