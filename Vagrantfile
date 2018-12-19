Vagrant.configure("2") do |config|
  config.vm.provider "hyperv"
  config.vm.provider :hyperv do |hv|
    # hv.differencing_disk = false # use differencing disk instead copying whole image
    hv.linked_clone = false
  end
  config.vm.box = "StefanScherer/windows_10"
  config.vm.provision "file", source: "packages.config", destination: "/tmp/packages.config"
  config.vm.provision "shell", path: "scripts/install.ps1", privileged: true
end