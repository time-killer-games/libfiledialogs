#!/bin/sh
cd "${0%/*}";
if [ `uname` = "Darwin" ]; then
  sudo xcode-select --install;
  if [ -f "/opt/local/bin/port" ]; then
    env NO_ANGLE=1 "./filedialogs/build (OGL Renderer).sh";
  else
    echo "MacPorts installation not found! Please download and install MacPorts first from www.macports.org";
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
  echo "build the visual studio solution found in the \"filedialogs\" sub-directory of this repository's source tree.";
fi
