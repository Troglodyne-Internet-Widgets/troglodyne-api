Name: Troglodyne-API
Version: 1.0
Release:	1%{?dist}
Summary: Common code for Troglodyne cPanel & WHM Plugins

Group: Plugins
License: Troglodyne
URL: https://troglodyne.net/troglodyne-api
Source0: Troglodyne-API-%{version}.tar.gz

# No real way to tell it what version of cpanel-perl libs it needs,
# as each of these are named like cpanel-perl-5xx-Module-Name.
# This makes your RPM break every time they upgrade perl.
# As such, just require the symlink to the binary and "pray it goes ok"
AutoReqProv: no
BuildRequires: make
Requires: /usr/local/cpanel/3rdparty/bin/perl

%description
Troglodyne common code plugin

%prep
%setup -q

%build

%install
make install DESTDIR=%{buildroot}

%files
%defattr(0700,root,root,-)
/usr/local/cpanel/whostmgr/docroot/cgi/troglodyne/api.cgi
%defattr(0600,root,root,-)
/var/cpanel/perl/Troglodyne/CGI/API.pm
/var/cpanel/perl/Troglodyne/CGI.pm
%defattr(0755,root,root,0755)
/var/cpanel/apps/troglodyne_api.conf

%preun
/usr/local/cpanel/bin/unregister_appconfig troglodyne_api

%post
/usr/local/cpanel/bin/register_appconfig /var/cpanel/apps/troglodyne_api.conf

%changelog
* Tue Jul 21 2020 George S. Baugh <george@troglodyne.net> - 1.0.1
- Initial Release
