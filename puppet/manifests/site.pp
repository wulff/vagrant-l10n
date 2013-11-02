# basic site manifest

import 'nodes'

# define global paths and file ownership
Exec { path => '/usr/sbin/:/sbin:/usr/bin:/bin' }
File { owner => 'root', group => 'root' }

# create a stage to make sure apt-get update is run before all other tasks
stage { 'requirements': before => Stage['main'] }
stage { 'bootstrap': before => Stage['requirements'] }

class l10n::bootstrap {
  # we need an updated list of sources before we can apply the configuration
  exec { 'l10n_apt_update':
    command => '/usr/bin/apt-get update && touch /root/apt-update',
    creates => '/root/apt-update',
  }
}
