#!/bin/bash

if [ -x /usr/bin/clear ];then
  clear
 else
  printf "\033c"
fi;

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
  mount -t sysfs ${HOST_ARCH}_sys /sys
fi;

LANG=${LANG:=en_ZA.UTF8}
if [ ! -e /etc/localtime ];then
  export TZ=${TZ:=Africa/Johannesburg}
fi;

LIB_PATH="/${HOST_LIBDIR}";
if [ "${HOST_MLIBDIR}" ];then
   HOSTLIBDIR="${HOST_LIBDIR}/${HOST_MLIBDIR}"
   LIB_PATH="${LIB_PATH}:${LIB_PATH}/${HOST_MLIBDIR}";
 else
   HOSTLIBDIR="${HOST_LIBDIR}"
fi;

for libpth in /usr /usr/X11R7 /opt/qt-5 /opt/qt-4 /opt/xfce;do
  if [ "${HOST_MLIBDIR}" ] && [ -d ${libpth}/${HOST_LIBDIR}/${HOST_MLIBDIR} ];then
    LIB_PATH="${LIB_PATH}:${libpth}/${HOST_LIBDIR}/${HOST_MLIBDIR}";
  fi;
  if [ -d ${libpth}/${HOST_LIBDIR} ];then
    LIB_PATH="${LIB_PATH}:${libpth}/${HOST_LIBDIR}";
  fi;
done;

unset JAVA_HOME ANT_HOME M2_HOME QTDIR
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/apache2/bin:/usr/X11R7/bin:/opt/xfce/bin

if [ "${JAVA_VER}" ] && [ -d /usr/${HOST_LIBDIR}/jvm/jdk-${JAVA_VER} ];then
  export JAVA_HOME=/usr/${HOST_LIBDIR}/jvm/jdk-${JAVA_VER}
  PATH=${PATH}:${JAVA_HOME}/bin
fi;

if [ ! "${JAVA_HOME}" ] && [ -d /usr/${HOST_LIBDIR}/jvm/gcj-jdk/bin ];then
  export JAVA_HOME=/usr/${HOST_LIBDIR}/jvm/gcj-jdk
  PATH=${PATH}:${JAVA_HOME}/bin
fi;

if [ "${ANT_VER}" ] && [ -d /usr/${HOST_LIBDIR}/jvm/apache-ant-${ANT_VER} ];then
  export ANT_HOME=/usr/${HOST_LIBDIR}/jvm/apache-ant-${ANT_VER}
  PATH=${PATH}:${ANT_HOME}/bin
fi;

if [ "${M2_VER}" ] && [ -d /usr/${HOST_LIBDIR}/jvm/apache-maven-${M2_VER} ];then
  export M2_HOME=/usr/${HOST_LIBDIR}/jvm/apache-maven-${M2_VER}
  PATH=${PATH}:${M2_HOME}/bin
fi;

if [ "${QT_VER}" ] && [ -d /opt/qt-${QT_VER} ];then
  export QTDIR=/opt/qt-${QT_VER}
  PATH=${PATH}:${QTDIR}/bin
fi;

if [ -d /opt/apache2/bin ];then
  PATH=${PATH}:/opt/apache2/bin
fi;

export LD_LIBRARY_PATH=${LIB_PATH}
export DISTROVER="${HOST_ARCH} ${HOST_BITS}bit"
export PS1='${HOST_ARCH}_${HOST_BITS}:\w\$ '
export DIALOG="dialog --backtitle \"${DISTRONAME} Linux ${DISTROVER}\""
export PATH

export LESSOPEN="|lesspipe.sh %s"
export LESSQUIET=1
export LESS="-MR"
unset LESSCLOSE

eval `dircolors -b`

if [ -x /usr/bin/linux_logo ];then
  linux_logo -F "Distrotech #O ${DISTROVER} #V\n#U\n#L"
fi;

if [ "${HOME}" ];then
  cd ${HOME}
fi;

alias ls='ls --color=auto'
alias pstree='pstree -U'
alias pico='nano'
