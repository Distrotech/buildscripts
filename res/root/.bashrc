#!/bin/bash

printf "\033c"

if [ -e ~/.distrotech_build ];then
  . ~/.distrotech_build
fi;

if [ ! -d /dev/pts ];then
  mount -t devtmpfs ${HOST_ARCH}_dev /dev
fi

if [ -d /dev/pts ] && [ ! -e /dev/pts/ptmx ];then
  mount -t devpts ${HOST_ARCH}_pts /dev/pts
fi

if [ ! -e /proc/self ];then
  mount -t proc ${HOST_ARCH}_proc /proc
fi;

if [ ! -e /sys/kernel ];then
  mount -t sys ${HOST_ARCH}_sys /sys
fi;

alias ls='ls --color=yes'
alias less='less -r'

LANG=${LANG:=en_ZA.UTF8}
if [ ! -e /etc/localtime ];then
  export TZ=${TZ:=Africa/Johannesburg}
fi;

LIB_PATH="/${HOST_LIBDIR}";
if [ "${HOST_MLIBDIR}" ];then
   LIB_PATH="${LIB_PATH}:${LIB_PATH}/${MLIBDIR}";
fi;

for libpth in /usr /usr/X11R7 /opt/qt-5 /opt/qt-4 /opt/xfce;do
  if [ "${HOST_MLIBDIR}" ] && [ -d ${libpth}/${HOST_LIBDIR}/${MLIBDIR} ];then
    LIB_PATH="${LIB_PATH}:${libpth}/${HOST_LIBDIR}/${MLIBDIR}";
  fi;
  if [ -d ${libpth}/${HOST_LIBDIR} ];then
    LIB_PATH="${LIB_PATH}:${libpth}/${HOST_LIBDIR}";
  fi;
done;

export LD_LIBRARY_PATH=${LIB_PATH}
export DISTROVER="${HOST_ARCH} ${HOST_BITS}bit"
export PS1='${HOST_ARCH}_${HOST_BITS}:\w\$ '
export DIALOG="dialog --backtitle \"${DISTRONAME} Linux ${DISTROVER}\""

if [ -x /usr/bin/linux_logo ];then
  linux_logo -F "Distrotech #O ${DISTROVER} #V\n#U\n#L"
fi;

if [ "${HOME}" ];then
  cd ${HOME}
fi;

