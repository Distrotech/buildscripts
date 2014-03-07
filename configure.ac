AC_PREREQ([2.69])
AC_INIT([dtsbuild],[0.1],[gregory@distrotech.co.za])

AM_INIT_AUTOMAKE

AC_ARG_WITH([dist-id], AS_HELP_STRING([--with-dist-id], [Distribution id stored in lsb-release (Distrotech)]))
AS_IF([test "x$with_dist_id" = "x" ], [DIST_ID=Distrotech], [DIST_ID=$with_dist_id])
AC_SUBST(DIST_ID)

AC_ARG_WITH([dist-release], AS_HELP_STRING([--with-dist-release], [Distribution release stored in lsb-release]))
AS_IF([test "x$with_dist_release" = "x" ], [DIST_RE=""], [DIST_RE=$with_dist_release])
AC_SUBST(DIST_RE)

AC_ARG_WITH([dist-codename], AS_HELP_STRING([--with-dist-codename], [Distribution codename stored in lsb-release]))
AS_IF([test "x$with_dist_codename" = "x" ], [DIST_CN=""], [DIST_CN=$with_dist_codename])
AC_SUBST(DIST_CN)

AC_ARG_WITH([dist-description], AS_HELP_STRING([--with-dist-description], [Distribution codename stored in lsb-release (Distrotech Solutions)]))
AS_IF([test "x$with_dist_description" = "x" ], [DIST_DI="Distrotech Solutions Linux"], [DIST_DI=$with_dist_description])
AC_SUBST(DIST_DI)

AC_ARG_WITH([srvdir], AS_HELP_STRING([--with-srv-dir], [toplevel direcrory for tar packages and yum repository]))
AC_ARG_WITH([src-dir], AS_HELP_STRING([--with-src-dir], [where the source is checked out and built]))
AC_ARG_WITH([build-dir], AS_HELP_STRING([--with-build-dir], [staging/bootstrap directory]))
AC_ARG_WITH([sysroot-dir], AS_HELP_STRING([--with-sysroot-dir], [sysroot directory where the build will be installed]))

AS_IF([test "x$prefix" = "x/opt"], [
  AS_IF([test x$localstatedir = x'${prefix}/var' ], [localstatedir=/var/opt/${PACKAGE_NAME}])
  AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=/etc/opt/${PACKAGE_NAME}])

  AS_IF([test "x$with_srv_dir" = "x" ], [SRVDIR=/srv/opt/${PACKAGE_NAME}], [SRVDIR=$with_srv_dir])
  AS_IF([test "x$with_src_dir" = "x"], [SRCDIR=$localstatedir/src], [SRCDIR=$with_src_dir])
  AS_IF([test "x$with_build_dir" = "x"], [BUILDDIR=$localstatedir/build], [BUILDDIR=$with_build_dir])
  AS_IF([test "x$with_sysroot_dir" = "x"], [ARCHROOT=$localstatedir/sysroot], [ARCHROOT=$with_sysroot_dir])

  prefix=${prefix}/${PACKAGE_NAME};
  AS_IF([test "x$exec_prefix" = "xNONE"], [exec_prefix=${prefix}])
  AS_IF([test x$libexecdir = x'${exec_prefix}/libexec' ], [libexecdir=${exec_prefix}/libexec])
], [
  AS_IF([test x$localstatedir = x'${prefix}/var' ], [localstatedir=${prefix}/var])
  AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=${prefix}/etc/${PACKAGE_NAME}])

  AS_IF([test "x$with_srv_dir" = "x" ], [SRVDIR=${prefix}/srv/${PACKAGE_NAME}], [SRVDIR=$with_srv_dir])
  AS_IF([test "x$with_src_dir" = "x"], [SRCDIR=$localstatedir/lib/${PACKAGE_NAME}/src], [SRCDIR=$with_src_dir])
  AS_IF([test "x$with_build_dir" = "x"], [BUILDDIR=$localstatedir/lib/${PACKAGE_NAME}/build], [BUILDDIR=$with_build_dir])
  AS_IF([test "x$with_sysroot_dir" = "x"], [ARCHROOT=$localstatedir/lib/${PACKAGE_NAME}/sysroot], [ARCHROOT=$with_sysroot_dir])

  AS_IF([test "x$exec_prefix" = "xNONE"], [exec_prefix=${prefix}])
  AS_IF([test x$libexecdir = x'${exec_prefix}/libexec' ], [libexecdir=${exec_prefix}/libexec/${PACKAGE_NAME}])
])

AS_IF([test x$datarootdir = x'${prefix}/share' ], [datarootdir=${prefix}/share])
AS_IF([test x$bindir = x'${exec_prefix}/bin' ], [bindir=${exec_prefix}/bin])


AC_ARG_WITH([srvdir_tar], AS_HELP_STRING([--with-srvdir-tar], [toplevel direcrory to place tar packages (${SRVDIR}/tar)]))
AS_IF([test "x$with_srvdir_tar" = "x"], [SRVDIRTAR=${SRVDIR}/tar], [SRVDIRTAR=$with_srvdir_tar])

AC_ARG_WITH([srvdir_yum], AS_HELP_STRING([--with-srvdir-yum], [toplevel direcrory to place rpm packages (${SRVDIR}/yum)]))
AS_IF([test "x$with_srvdir_yum" = "x"], [SRVDIRYUM=${SRVDIR}/yum], [SRVDIRYUM=$with_srvdir_yum])

AC_ARG_WITH([yum_repo_conf_dir], AS_HELP_STRING([--with-yum-repo-conf-dir], [yum repo config directory (/etc/yum/repos.d)]))
AS_IF([test "x$with_yum_repo_conf_dir" = "x"], [YUMREPOCONFDIR=/etc/yum/repos.d], [YUMREPOCONFDIR=$with_yum_repo_conf_dir])

AS_IF([test x$sysconfdir = x'${prefix}/etc'], [sysconfdir=${prefix}/etc])
PATCHDIR=${datarootdir}/patches

AC_CONFIG_FILES([
  Makefile
  bin/build
  bin/mkbuilddef
  bin/pkg2rpm
  bin/umount-arch
  etc/yum_repo.conf
  lsb/lsb-release])

AC_SUBST(YUMREPOCONFDIR)
AC_SUBST(SRVDIRTAR)
AC_SUBST(SRVDIRYUM)
AC_SUBST(SRVDIR)
AC_SUBST(SRCDIR)
AC_SUBST(BUILDDIR)
AC_SUBST(ARCHROOT)
AC_SUBST(PATCHDIR)

AC_OUTPUT

printf "\n\nDirectory Layout\n"

printf "%-40s: %s\n" "bindir" "${bindir}"
printf "%-40s: %s\n" "libexecdir" "${libexecdir}"
printf "%-40s: %s\n" "sysconfdir" "${sysconfdir}"
printf "%-40s: %s\n" "tardir" "${SRVDIRTAR}"
printf "%-40s: %s\n" "yumdir" "${SRVDIRYUM}"
printf "%-40s: %s\n" "srcdir" "${SRCDIR}"
printf "%-40s: %s\n" "builddir" "${BUILDDIR}"
printf "%-40s: %s\n" "sysrootdir" "${ARCHROOT}"
printf "%-40s: %s\n" "patchdir" "${PATCHDIR}"
printf "%-40s: %s\n" "repodir" "${YUMREPOCONFDIR}"
