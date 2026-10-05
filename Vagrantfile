Vagrant.configure("2") do |config|

    # Oracle9 image
    config.vm.box = "generic/oracle9"

    # Backend config
    config.vm.define "backend" do |backend|
        backend.vm.hostname = "backend-vm"
        backend.vm.network "private_network", ip: "192.168.56.20"
        backend.vm.network "forwarded_port", guest: 5000, host: 5000, auto_correct: true

        backend.vm.provider "virtualbox" do |vb|
            vb.name = "space2study-backend"
            vb.memory = "2048"
            vb.cpus = 2
        end
    end

    # Frontend config
    config.vm.define "frontend" do |frontend|
        frontend.vm.hostname = "frontend-vm"
        frontend.vm.network "private_network", ip: "192.168.56.21"
        frontend.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true

        frontend.vm.provider "virualbox" do |vb|
            vb.name = "space2study-frontend"
            vb.memory = "2048"
            vb.cpus = 2
        end
    end
end