module OS
    def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def OS.mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def OS.unix?
        !OS.windows?
    end

    def OS.linux?
        OS.unix? and not OS.mac?
    end
end

Vagrant.configure(2) do |config|
  config.vm.box = "projectatomic/adb"

  config.vm.provider "libvirt" do |libvirt, override|
    libvirt.driver = "kvm"
    libvirt.memory = 1024
    libvirt.cpus = 2
  end

  config.vm.provider "virtualbox" do |vbox, override|
    vbox.memory = 1024
    vbox.cpus = 2

    # Enable use of more than one virtual CPU in a virtual machine.
    vbox.customize ["modifyvm", :id, "--ioapic", "on"]
  end

    if OS.windows?
        config.vm.provision "shell", inline: "yum makecache fast && yum install -y cifs-utils"
        config.vm.synced_folder "C:/Users/<user>/Documents/adb_mount", "/vagrant", type: "smb"	
    elsif OS.linux?
       config.vm.synced_folder "/home/<user>/Desktop/adb_mount", "/vagrant", type: "nfs"
  end
end
