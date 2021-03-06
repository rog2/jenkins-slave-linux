#!/bin/bash -e

sudo apt-get update

# Dependencies by UE4 for building on linux
# See: https://intranet.rog2.org/docs/unreal-engine/build/build-game-linux
DEPS="
    build-essential
    clang-5.0
    mono-xbuild
    mono-devel
    mono-dmcs
    mono-mcs
    mono-reference-assemblies-4.0
    libmono-microsoft-build-tasks-v4.0-4.0-cil
    libmono-system-data-datasetextensions4.0-cil
    libmono-system-web-extensions4.0-cil
    libmono-system-management4.0-cil
    libmono-system-xml-linq4.0-cil
    dos2unix
    xdg-user-dirs
    libfreetype6-dev
    libgtk-3-dev
    libnss3-dev
    libgconf2-dev
    libxss-dev
    libasound2-dev
    "

# Apache Ant is required by UE4 for packaging Android apk. See:
# https://docs.unrealengine.com/latest/INT/Platforms/Android/GettingStarted/1/index.html
# https://developer.nvidia.com/codeworks-android
DEPS+=" ant "

# Packages required to build third-party libraries
# Example: https://github.com/google/protobuf/blob/master/src/README.md
DEPS+="
    autoconf
    automake
    libtool
    check
    "
# Lua build dependency
# See: http://www.lua.org/manual/5.3/readme.html
DEPS+=" libreadline-dev "

# Utility packages
DEPS+="
    apt-show-versions
    gdb
    curl
    unzip
    unrar
    htop
    ifstat
    tree
    jq
    crudini
    subversion
    python3-pip
    "

for DEP in $DEPS; do
    if ! dpkg -s $DEP > /dev/null 2>&1; then
        echo "Attempting installation of missing package: $DEP"
        sudo apt-get install -y $DEP
    fi
done
