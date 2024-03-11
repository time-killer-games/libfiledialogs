#!/bin/sh
cd "${0%/*}";
if [ `uname` = "Darwin" ]; then
  "./filedialogs/build (SDL Renderer).sh";
elif [ $(uname) = "Linux" ]; then
  "./filedialogs/build (SDL Renderer).sh";
elif [ $(uname) = "FreeBSD" ]; then
  "./filedialogs/build (SDL Renderer).sh";
elif [ $(uname) = "DragonFly" ]; then
  "./filedialogs/build (SDL Renderer).sh";
elif [ $(uname) = "NetBSD" ]; then
  "./filedialogs/build (SDL Renderer).sh";
elif [ $(uname) = "OpenBSD" ]; then
  "./filedialogs/build (SDL Renderer).sh";
elif [ $(uname) = "SunOS" ]; then
  "./filedialogs/build (SDL Renderer).sh";
else
  echo "build the visual studio solution found in the \"filedialogs\" sub-directory of this repository's source tree.";
fi
