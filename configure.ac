AC_PREREQ([2.69])
AC_INIT([dtsbuild],[0.1],[gregory@distrotech.co.za])

AM_INIT_AUTOMAKE

AC_ARG_WITH([srvdir], AS_HELP_STRING([--with-srvdir], [toplevel direcrory for tar packages and yum repository]))

AS_IF([test "x$with_srvdir" = "x"], [SRVDIR=${prefix}/srv/${PACKAGE_NAME}], [SRVDIR=$with_srvdir])
AC_SUBST(SRVDIR)

AS_IF([test "x$prefix" = "x/opt"], [
  AS_IF([test x$SRVDIR = x${prefix}/srv/${PACKAGE_NAME} ], [SRVDIR=/srv/opt/${PACKAGE_NAME}])
  AS_IF([test x$localstatedir = x'${prefix}/var' ], [localstatedir=/var/opt/${PACKAGE_NAME}])
  AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=/etc/opt/${PACKAGE_NAME}])
  prefix=${prefix}/${PACKAGE_NAME};
], [
  AS_IF([test x$libexecdir = x'${exec_prefix}/libexec' ], [libexecdir='${exec_prefix}/libexec/${PACKAGE_NAME}'])
  AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=${prefix}/etc/${PACKAGE_NAME}])
])

AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=${prefix}/etc])

AC_CONFIG_FILES([Makefile bin/build bin/mkbuilddef])

AC_OUTPUT
