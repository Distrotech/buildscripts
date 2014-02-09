AC_PREREQ([2.69])
AC_INIT([dtsbuild],[0.1],[gregory@distrotech.co.za])

AM_INIT_AUTOMAKE

AC_ARG_WITH([srvdir], AS_HELP_STRING([--with-srv-dir], [toplevel direcrory for tar packages and yum repository]))
AC_ARG_WITH([src-dir], AS_HELP_STRING([--with-src-dir], [where the source is checked out and built]))
AC_ARG_WITH([build-dir], AS_HELP_STRING([--with-build-dir], [staging/bootstrap directory]))

AS_IF([test "x$prefix" = "x/opt"], [
  AS_IF([test x$localstatedir = x'${prefix}/var' ], [localstatedir=/var/opt/${PACKAGE_NAME}])
  AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=/etc/opt/${PACKAGE_NAME}])

  AS_IF([test "x$with_srv_dir" = "x" ], [SRVDIR=/srv/opt/${PACKAGE_NAME}], [SRVDIR=$with_srv_dir])
  AS_IF([test "x$with_src_dir" = "x"], [SRCDIR=$localstatedir/src], [SRCDIR=$with_src_dir])
  AS_IF([test "x$with_build_dir" = "x"], [BUILDDIR=$localstatedir/build], [BUILDDIR=$with_build_dir])

  prefix=${prefix}/${PACKAGE_NAME};
  AS_IF([test "x$exec_prefix" = "xNONE"], [exec_prefix=${prefix}])
  AS_IF([test x$libexecdir = x'${exec_prefix}/libexec' ], [libexecdir=${exec_prefix}/libexec])
], [
  AS_IF([test x$localstatedir = x'${prefix}/var' ], [localstatedir=${prefix}/var])
  AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=${prefix}/etc/${PACKAGE_NAME}])

  AS_IF([test "x$with_srv_dir" = "x" ], [SRVDIR=${prefix}/srv/${PACKAGE_NAME}], [SRVDIR=$with_srv_dir])
  AS_IF([test "x$with_src_dir" = "x"], [SRCDIR=$localstatedir/lib/${PACKAGE_NAME}/src], [SRCDIR=$with_src_dir])
  AS_IF([test "x$with_build_dir" = "x"], [BUILDDIR=$localstatedir/lib/${PACKAGE_NAME}/build], [BUILDDIR=$with_build_dir])

  AS_IF([test "x$exec_prefix" = "xNONE"], [exec_prefix=${prefix}])
  AS_IF([test x$libexecdir = x'${exec_prefix}/libexec' ], [libexecdir=${exec_prefix}/libexec/${PACKAGE_NAME}])
])

AS_IF([test x$bindir = x'${exec_prefix}/bin' ], [bindir=${exec_prefix}/bin])


AC_ARG_WITH([srvdir_tar], AS_HELP_STRING([--with-srvdir-tar], [toplevel direcrory to place tar packages (${SRVDIR}/tar)]))
AS_IF([test "x$with_srvdir_tar" = "x"], [SRVDIRTAR=${SRVDIR}/tar], [SRVDIRTAR=$with_srvdir_tar])

AC_ARG_WITH([srvdir_yum], AS_HELP_STRING([--with-srvdir-yum], [toplevel direcrory to place rpm packages (${SRVDIR}/yum)]))
AS_IF([test "x$with_srvdir_yum" = "x"], [SRVDIRYUM=${SRVDIR}/yum], [SRVDIRYUM=$with_srvdir_yum])

AC_ARG_WITH([yum_repo_conf_dir], AS_HELP_STRING([--with-yum-repo-conf-dir], [yum repo config directory (/etc/yum/repos.d)]))
AS_IF([test "x$with_yum_repo_conf_dir" = "x"], [YUMREPOCONFDIR=/etc/yum/repos.d], [YUMREPOCONFDIR=$with_yum_repo_conf_dir])

AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=${prefix}/etc])

AC_CONFIG_FILES([Makefile bin/build bin/mkbuilddef bin/pkg2rpm etc/yum_repo.conf])

AC_SUBST(YUMREPOCONFDIR)
AC_SUBST(SRVDIRTAR)
AC_SUBST(SRVDIRYUM)
AC_SUBST(SRVDIR)
AC_SUBST(SRCDIR)
AC_SUBST(BUILDDIR)

AC_OUTPUT

printf "\n\nDirectory Layout\n"

printf "%-40s: %s\n" "bindir" "${bindir}"
printf "%-40s: %s\n" "libexecdir" "${libexecdir}"
printf "%-40s: %s\n" "sysconfdir" "${sysconfdir}"
printf "%-40s: %s\n" "tardir" "${SRVDIRTAR}"
printf "%-40s: %s\n" "yumdir" "${SRVDIRYUM}"
printf "%-40s: %s\n" "srcdir" "${SRCDIR}"
printf "%-40s: %s\n" "builddir" "${BUILDDIR}"
printf "%-40s: %s\n" "repodir" "${YUMREPOCONFDIR}"
