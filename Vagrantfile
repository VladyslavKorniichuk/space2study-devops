Vagrant.configure("2") do |config|

    # Oracle9 image
    config.vm.box = "generic/oracle9"
    config.vm.hostname = "space2study-server"

    # Static ip
    config.vm.network "private_network", ip: "192.168.56.10"

    # Forwarding to windows
    config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true
    config.vm.network "forwarded_port", guest: 5000, host: 5000, auto_correct: true

    config.vm.provider "virtualbox" do |vb|
        vb.name = "space2study-oracle9"
        vb.memory = "4096"
        vb.cpus = 2
    end
end