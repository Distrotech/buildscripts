DIST_TARGETS = dist-gzip dist-bzip2 dist-xz dist-zip

EXTRA_DIST = bin etc libexec

bin_SCRIPTS = bin/build bin/mkbuilddef bin/pkg2rpm

libexec_SCRIPTS	= \
	libexec/make_apache-ant \
	libexec/make_boost \
	libexec/make_docbook \
	libexec/make_docbook-xsl \
	libexec/make_gs-fonts \
	libexec/make_iproute2 \
	libexec/make_lsof \
	libexec/make_openssl \
	libexec/make_p7zip \
	libexec/make_perl \
	libexec/make_po4a \
	libexec/make_PyQt-x11 \
	libexec/make_qt-4 \
	libexec/make_qt-5 \
	libexec/make_sendmail \
	libexec/make_sip \
	libexec/make_syslinux \
	libexec/make_tzdata \
	libexec/make_Xorg \
	libexec/make_yodl

distclean-local:
	-rm -rf autom4te.cache

install-data-local:
	$(INSTALL) -d $(DESTDIR)$(sysconfdir) $(SRVDIR) $(localstatedir) $(YUMREPOCONFDIR)
	$(INSTALL) etc/yum_repo.conf $(DESTDIR)$(YUMREPOCONFDIR)/$(PACKAGE_NAME).conf
	cp -rp etc/* $(DESTDIR)$(sysconfdir)
