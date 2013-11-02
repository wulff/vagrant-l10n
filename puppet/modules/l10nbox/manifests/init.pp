# == Class: l10nbox
#
# This class installs Lokalize, and sets up a window manager to start on boot.
#
# === Examples
#
#   class { 'l10nbox': }
#
class l10nbox() {

  File { owner => 'vagrant', group => 'vagrant', mode => 0644 }

  # add a lightweight window manager and a terminal emulator

  package { 'openbox':
    ensure => present,
  }

  package { 'xinit':
    ensure => present,
    # require => Package['openbox'],
  }

  package { 'xterm':
    ensure => present,
    # require => Package['openbox'],
  }

  file { '/home/vagrant/.xinitrc':
    source => 'puppet:///modules/l10nbox/xinitrc',
  }

  # add the localization tool

  package { 'lokalize':
    ensure => present,
    # require => Package['openbox'],
  }

  # add virtualbox guest additions to make it easy to run in fullscreen mode

  package { 'linux-kernel-headers':
    ensure => present,
  }
  
  package { 'virtualbox-guest-x11':
    ensure => present,
    require => Package['linux-kernel-headers'],
    # require => [Package['openbox'], Package['linux-kernel-headers']],
  }

  # configure the system

  file { '/home/vagrant/.profile':
    source => 'puppet:///modules/l10nbox/profile',
  }

  file { ['/home/vagrant/.config', '/home/vagrant/.config/openbox']:
    ensure => directory,
  }

  file { '/home/vagrant/.config/openbox/autostart':
    source => 'puppet:///modules/l10nbox/autostart',
    require => File['/home/vagrant/.config/openbox'],
  }

  file { '/home/vagrant/.config/openbox/rc.xml':
    source => 'puppet:///modules/l10nbox/rc.xml',
    require => File['/home/vagrant/.config/openbox'],
  }

  file { '/home/vagrant/.kde':
    ensure => directory,
    mode => 0700,
  }

  # create symlink to lokalize configuration file

  file { ['/home/vagrant/.kde/share', '/home/vagrant/.kde/share/config']:
    ensure => directory,
    mode => 0775,
    require => File['/home/vagrant/.kde'],
  }

  file { '/home/vagrant/.kde/share/config/lokalizerc':
    ensure => link,
    target => '/vagrant/lokalize/conf/lokalizerc',
    require => File['/home/vagrant/.kde/share/config'],
  }

  # create symlink to translation memory

  file { ['/home/vagrant/.kde/share/apps', '/home/vagrant/.kde/share/apps/lokalize']:
    ensure => directory,
    mode => 0700,
    require => File['/home/vagrant/.kde/share'],
  }

  file { '/home/vagrant/.kde/share/apps/lokalize/drupal-da.db':
    ensure => link,
    target => '/vagrant/lokalize/db/drupal-da.db',
    require => File['/home/vagrant/.kde/share/apps/lokalize'],
  }

}
