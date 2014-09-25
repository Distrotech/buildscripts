DIST_TARGETS = dist-gzip dist-bzip2 dist-xz dist-zip

EXTRA_DIST = bin etc libexec

bin_SCRIPTS = \
	bin/build \
	bin/mkkern \
	bin/mkgroups \
	bin/mkbuilddef \
	bin/pkg2rpm \
	bin/chroot-arch \
	bin/umount-arch

libexec_SCRIPTS	= \
	libexec/make_apache-ant \
	libexec/make_boost \
	libexec/make_docbook \
	libexec/make_docbook-4.1.2 \
	libexec/make_docbook-4.2 \
	libexec/make_docbook-4.3 \
	libexec/make_docbook-4.4 \
	libexec/make_docbook-4.5 \
	libexec/make_docbook-xsl \
	libexec/make_gs-fonts \
	libexec/make_iproute2 \
	libexec/make_lsof \
	libexec/make_openssl \
	libexec/make_openssl-0.9.8 \
	libexec/make_p7zip \
	libexec/make_perl \
	libexec/make_po4a \
	libexec/make_PyQt-x11 \
	libexec/make_qt-4 \
	libexec/make_qt-5 \
	libexec/make_qt-4-bin \
	libexec/make_sendmail \
	libexec/make_sip \
	libexec/make_syslinux \
	libexec/make_tzdata \
	libexec/make_Xorg \
	libexec/make_yodl

distclean-local:
	-rm -rf autom4te.cache

install-data-local:
	$(INSTALL) -d $(DESTDIR)$(sysconfdir) $(DESTDIR)$(localstatedir) $(DESTDIR)$(YUMREPOCONFDIR) \
	              $(DESTDIR)$(SRCDIR) $(DESTDIR)$(PATCHDIR) $(DESTDIR)$(KCONFIGDIR)
	$(INSTALL) etc/yum_repo.conf $(DESTDIR)$(YUMREPOCONFDIR)/$(PACKAGE_NAME).repo
	cp -Ppr etc/{builddef,waf_cross,skel,cmake_cross} $(DESTDIR)$(sysconfdir)
	@cp -Ppr patches/* $(DESTDIR)$(PATCHDIR)/ || true
	@cp -Ppr kernconfig/* $(DESTDIR)$(KCONFIGDIR)/ || true
