#!/bin/bash

NARCH=${NARCH:=$( uname -m )}
case ${NARCH} in
  powerpc)NARCH=ppc;;
  powerpc64)NARCH=ppc64;;
  aarch64)NARCH=arm64;;
  armv7l)NARCH=arm;;
  armv6l|armv6)NARCH=armv6;
         SYSARCH=arm;;
  armv5*)NARCH=armv5;
         SYSARCH=arm;;
esac;
if [ ! "${SYSARCH}" ];then
  SYSARCH=${NARCH}
fi
export NARCH

if [ ! -e /proc/sys/fs/binfmt_misc/register ];then
  mount -t binfmt_misc none /proc/sys/fs/binfmt_misc/
fi;

if [ -e /proc/sys/fs/binfmt_misc/${SYSARCH} ] && [ -x /usr/bin/hybrid/clear ];then
  /usr/bin/hybrid/clear
 elif [ -x /usr/bin/clear ];then
  /usr/bin/clear
 else
  printf "\033c"
fi;

if [ -e ~/.distrotech_build ];then
  . ~/.distrotech_build
fi;

if [ ! -d /dev/pts ];then
  mount -t devtmpfs ${HOST_ARCH}_dev /dev
  if [ "$?" == "0" ] && [ ! -d /dev/pts ];then
    mkdir /dev/pts
  fi;
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

export LANG=${LANG:=en_ZA.UTF8}
if [ ! -e /etc/localtime ];then
  export TZ=${TZ:=Africa/Johannesburg}
fi;

unset JAVA_HOME ANT_HOME M2_HOME QTDIR FOP_HOME FORREST_HOME LESSCLOSE

LIB_PATH="/${HOST_LIBDIR}";
if [ "${HOST_MLIBDIR}" ];then
   HOSTLIBDIR="${HOST_LIBDIR}/${HOST_MLIBDIR}"
   LIB_PATH="${LIB_PATH}:${LIB_PATH}/${HOST_MLIBDIR}";
 else
   HOSTLIBDIR="${HOST_LIBDIR}"
fi;

for libpth in /usr /opt/Xorg /opt/qt-5 /opt/qt-4 /opt/xfce /opt/apr /opt/mysql /opt/radius;do
  if [ "${HOST_MLIBDIR}" ] && [ -d ${libpth}/${HOST_LIBDIR}/${HOST_MLIBDIR} ];then
    LIB_PATH="${LIB_PATH}:${libpth}/${HOST_LIBDIR}/${HOST_MLIBDIR}";
  fi;
  if [ -d ${libpth}/${HOST_LIBDIR} ];then
    LIB_PATH="${LIB_PATH}:${libpth}/${HOST_LIBDIR}";
  fi;
done;

if [ -e /proc/sys/fs/binfmt_misc/${SYSARCH} ] || [ -e /proc/sys/fs/binfmt_misc/${NARCH} ];then
  if [ -d /usr/bin/hybrid ];then
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin/hybrid:/usr/bin:/sbin:/bin/hybrid:/bin:/opt/apache2/bin:/opt/Xorg/bin:/opt/xfce/bin
   else
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/apache2/bin:/opt/Xorg/bin:/opt/xfce/bin
  fi;
  if [ -d /var/hybrid/libexec/gcc/ ];then
    export GCC_EXEC_PREFIX=/var/hybrid/libexec/gcc/
    LIBGCC_DIR=$(dirname $(gcc -print-libgcc-file-name))
    export ADA_INCLUDE_PATH=${LIBGCC_DIR}/adainclude
    export ADA_OBJECTS_PATH=${LIBGCC_DIR}/adalib
    unset LIBGCC_DIR
  fi;
  if [ -d /var/hybrid/git-core ];then
    export GIT_EXEC_PATH=/var/hybrid/git-core
  fi;
 else
  PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/apache2/bin:/opt/Xorg/bin:/opt/xfce/bin
fi;
MANPATH=/share:/usr/share/man

if [ "${JAVA8_VER}" ] && [ -d /usr/${HOST_LIBDIR}/jvm/jdk-${JAVA8_VER} ];then
  export JAVA_HOME=/usr/${HOST_LIBDIR}/jvm/jdk-${JAVA8_VER}
  PATH=${PATH}:${JAVA_HOME}/bin
 elif [ "${JAVA7_VER}" ] && [ -d /usr/${HOST_LIBDIR}/jvm/jdk-${JAVA7_VER} ];then
  export JAVA_HOME=/usr/${HOST_LIBDIR}/jvm/jdk-${JAVA7_VER}
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

if [ -d /opt/texlive ];then
  export TEX=tex
  PATH=${PATH}:/opt/texlive/bin/custom
  if [ -d /opt/texlive/bin/${HOST}-linux ];then
    PATH=${PATH}:/opt/texlive/bin/x86_64-linux
  fi;
  MANPATH=${MANPATH}:/opt/texlive/texmf-dist/doc/man
fi;

for pkg in /opt/*;do
  if [ "${pkg:0:3}" != "qt-" ] && [ -d ${pkg}/bin ];then
    PATH=${PATH}:${pkg}/bin
  fi;
done

if [ "${QT_VER}" ] && [ -d /opt/qt-${QT_VER} ];then
  export QTDIR=/opt/qt-${QT_VER}
  PATH=${PATH}:${QTDIR}/bin
fi;

if [ -d /opt/fop ];then
  export FOP_HOME=/opt/fop
  PATH=${PATH}:${FOP_HOME}
fi;

export LD_LIBRARY_PATH=${LIB_PATH}
export DISTROVER="${HOST_ARCH} ${HOST_BITS}bit"
export PS1='${HOST_ARCH}_${HOST_BITS}:\w\$ '
export DIALOG="dialog --backtitle \"${DISTRONAME} Linux ${DISTROVER}\""
export PATH

export GIT_EDITOR="nano"

export LESSOPEN="|lesspipe.sh %s"
export LESSQUIET=1
export LESS="-MR"

eval `dircolors -b`
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -x /usr/bin/linux_logo ];then
  linux_logo -F "Distrotech #O ${DISTROVER} #V\n#U\n#L"
fi;
if [ -x /usr/bin/fortune ];then
  if [ -x /usr/bin/figlet ];then
    fortune -s |figlet -f term
   else
    fortune -s
  fi;
  echo
fi

if [ "${HOME}" ];then
  cd ${HOME}
fi;

alias ls='ls --color=auto'
alias pstree='pstree -U'
alias pico='nano'
alias vi='vim'
