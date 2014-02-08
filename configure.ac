AC_PREREQ([2.69])
AC_INIT([dtsbuild],[0.1],[gregory@distrotech.co.za])

AM_INIT_AUTOMAKE

AC_ARG_WITH([srvdir], AS_HELP_STRING([--with-srvdir], [toplevel direcrory for tar packages and yum repository (${prefix}/srv/${PACKAGE_NAME}]))

AS_IF([test "x$with_srvdir" = "x"], [SRVDIR=${prefix}/srv/${PACKAGE_NAME}], [SRVDIR=$with_srvdir])
AC_SUBST(SRVDIR)

AC_ARG_WITH([srvdir_tar], AS_HELP_STRING([--with-srvdir-tar], [toplevel direcrory to place tar packages (${SRVDIR}/tar)]))
AS_IF([test "x$with_srvdir_tar" = "x"], [SRVDIRTAR=${SRVDIR}/tar], [SRVDIRTAR=$with_srvdir_tar])
AC_SUBST(SRVDIRTAR)

AC_ARG_WITH([srvdir_yum], AS_HELP_STRING([--with-srvdir-yum], [toplevel direcrory to place rpm packages (${SRVDIR}/yum)]))
AS_IF([test "x$with_srvdir_yum" = "x"], [SRVDIRYUM=${SRVDIR}/yum], [SRVDIRYUM=$with_srvdir_yum])
AC_SUBST(SRVDIRYUM)

AC_ARG_WITH([yum_repo_conf_dir], AS_HELP_STRING([--with-yum-repo-conf-dir], [yum repo config directory (/etc/yum/repos.d)]))
AS_IF([test "x$with_yum_repo_conf_dir" = "x"], [YUMREPOCONFDIR=/etc/yum/repos.d], [YUMREPOCONFDIR=$with_yum_repo_conf_dir])
AC_SUBST(YUMREPOCONFDIR)


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

AC_CONFIG_FILES([Makefile bin/build bin/mkbuilddef bin/pkg2rpm etc/yum_repo.conf])

AC_OUTPUT
