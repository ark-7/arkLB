# set up the default terminal
ENV["TERM"]="linux"

Vagrant.configure("2") do |config|
  
  # set the image for the vagrant box
  config.vm.box = "ubuntu/jammy64"
  ## Set the image version
  # config.vm.box_version = "15.2.31.212"

  # set the static IP for the vagrant box
  config.vm.network "private_network", ip: "192.168.50.4"

  # Set range of ports to be forwarded to the host
  for i in 8000..8030
    config.vm.network :forwarded_port, guest: i, host: i
  end
  
  # For hubble UI
  config.vm.network :forwarded_port, guest: 12000, host: 12000 # Modify IP here to avoid error in VBox

  # configure the parameters for VirtualBox provider
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "3072"
    vb.cpus = 4
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end
end
