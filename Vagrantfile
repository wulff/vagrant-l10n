Vagrant::configure('2') do |config|
  # the base box this environment is built off of
  config.vm.box = 'precise32'

  # the url from where to fetch the base box if it doesn't exist
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'

  # enable ssh agent forwarding
  config.ssh.forward_agent = true

  # use puppet to provision packages
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'puppet/modules'
  end

  # setup localization node
  config.vm.define :l10n, {:primary => true} do |l10n|
    # configure network
    l10n.vm.hostname = 'l10n.local'
    l10n.vm.network :private_network, ip: '33.33.33.10'

    # configure memory and node name
    config.vm.provider 'virtualbox' do |v|
      v.name = 'Vagrant L10N'
      v.customize ['modifyvm', :id, '--memory', 1024]
      v.gui = true
    end
  end
end
