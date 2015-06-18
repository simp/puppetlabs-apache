Summary: Puppet Labs Apache Module
Name: pupmod-puppetlabs-apache
Version: 1.0.1
Release: 2
License: Apache License, 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: puppetlabs-stdlib >= 3.2.0
Requires: pupmod-concat >= 4.0.0
Requires: pupmod-iptables >= 4.1.0-4
Buildarch: noarch
Requires: simp-bootstrap >= 4.2.0

Prefix: /etc/puppet/environments/simp/modules

%description
A module to create Puppetlabs Apache, modified for SIMP

%prep
%setup -q

%build

%install

[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/puppetlabs_apache

dirs='files lib manifests examples templates'
for dir in $dirs; do
  test -d $dir && cp -r $dir %{buildroot}/%{prefix}/puppetlabs_apache
done

cp CHANGELOG.md %{buildroot}/%{prefix}/puppetlabs_apache
cp CONTRIBUTING.md %{buildroot}/%{prefix}/puppetlabs_apache
cp Gemfile %{buildroot}/%{prefix}/puppetlabs_apache
cp LICENSE %{buildroot}/%{prefix}/puppetlabs_apache
cp metadata.json %{buildroot}/%{prefix}/puppetlabs_apache
cp Modulefile %{buildroot}/%{prefix}/puppetlabs_apache
cp README.md %{buildroot}/%{prefix}/puppetlabs_apache
cp README.passenger.md %{buildroot}/%{prefix}/puppetlabs_apache

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/puppetlabs_apache

%files
%defattr(0640,root,puppet,0750)
%{prefix}/puppetlabs_apache

%changelog
* Fri Feb 13 2015 - Trevor Vaughan <tvaughan@onyxpoint.com> - 1.0.1-1
- Migrated to the new 'simp' environment

* Thu May 22 2014 - Nick Markowski <nmarkowski@keywcorp.com> - 1.0.1-0
- Modified module to use our concat.
- Changed the namespace to be puppet_apache instead of apache.
