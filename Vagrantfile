# set up the default terminal
ENV["TERM"]="linux"

Vagrant.configure("2") do |config|
  # set the image for the vagrant box
  config.vm.define "ark" do |ark|
    ark.vm.box = "ubuntu/focal64"
    ark.vm.network "private_network", ip: "192.168.50.4"
    for i in 8000..8030
      ark.vm.network :forwarded_port, guest: i, host: i
    end
    # For hubble UI
    ark.vm.network :forwarded_port, guest: 12000, host: 12000 # Modify IP here to avoid error in VBox
    ark.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 4
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end
end
