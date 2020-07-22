ulc  = /usr/local/cpanel
tmpl = /whostmgr/docroot/templates/troglodyne
cgi  = /whostmgr/docroot/cgi/troglodyne
vcp  = /var/cpanel/perl
vca  = /var/cpanel/apps
vct  = /var/cpanel/templates
pwd  = $(shell pwd)
 
.PHONY: all install register test uninstall rpm test-depend
all: install register

install: test
	mkdir -p  $(DESTDIR)$(ulc)$(cgi) $(DESTDIR)$(vca) $(DESTDIR)$(vcp)/Troglodyne/CGI $(DESTDIR)$(vcp)/Troglodyne/API $(DESTDIR)$(ulc)/whostmgr/docroot/addon_plugins
	install $(pwd)/cgi/api.cgi $(DESTDIR)$(ulc)$(cgi)
	install $(pwd)/lib/Troglodyne/CGI/API.pm $(DESTDIR)$(vcp)/Troglodyne/CGI
	install $(pwd)/lib/Troglodyne/CGI.pm $(DESTDIR)$(vcp)/Troglodyne
	install $(pwd)/plugin/troglodyne_api.conf $(DESTDIR)$(vca)
	chmod 0755 $(DESTDIR)$(vca)
	chmod +x $(DESTDIR)$(ulc)$(cgi)/api.cgi

register:
	$(ulc)/bin/register_appconfig ./plugin/troglodyne_api.conf

uninstall:
	$(ulc)/bin/unregister_appconfig troglodyne_api
	rm -f $(vcp)/Troglodyne/CGI/API.pm
	rm -f $(vcp)/Troglodyne/CGI.pm
	rm -f $(ulc)$(cgi)/api.cgi

test-depend:
	perl -MTest2::V0 -MTest::MockModule -MFile::Temp -MCapture::Tiny -e 'exit 0' || sudo cpan -i Test2::V0 Test::MockModule File::Temp Capture::Tiny

test: test-depend
	prove -mv t/*.t

rpm:
	rm -rf SOURCES/*
	mkdir -p SOURCES/Troglodyne-API-1.0
	ln -s $(pwd)/bin SOURCES/Troglodyne-API-1.0/bin
	ln -s $(pwd)/cgi SOURCES/Troglodyne-API-1.0/cgi
	ln -s $(pwd)/img SOURCES/Troglodyne-API-1.0/img
	ln -s $(pwd)/install SOURCES/Troglodyne-API-1.0/install
	ln -s $(pwd)/js SOURCES/Troglodyne-API-1.0/js
	ln -s $(pwd)/lib SOURCES/Troglodyne-API-1.0/lib
	ln -s $(pwd)/plugin SOURCES/Troglodyne-API-1.0/plugin
	ln -s $(pwd)/t SOURCES/Troglodyne-API-1.0/t
	ln -s $(pwd)/templates SOURCES/Troglodyne-API-1.0/templates
	cp $(pwd)/Makefile SOURCES/Troglodyne-API-1.0/Makefile
	cp $(pwd)/configure SOURCES/Troglodyne-API-1.0/configure
	mkdir -p ~/rpmbuild/SOURCES
	cd SOURCES && tar --exclude="*.swp" --exclude="*.swn" --exclude="*.swo" -ch Troglodyne-API-1.0 | gzip > ~/rpmbuild/SOURCES/Troglodyne-API-1.0.tar.gz
	rpmbuild -ba --clean --target noarch SPECS/TroglodyneApi.spec
	rm -rf SOURCES/*
