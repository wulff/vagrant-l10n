# nodes.pp

node "basenode" {
  class { 'l10n::bootstrap':
    stage => 'bootstrap',
  }
}

node "l10n.vagrant.ratatosk.net" inherits "basenode" {
  class { 'l10nbox': }
}
