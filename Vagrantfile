Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    set -e

    apt-get update
    apt-get install -y curl build-essential

    if ! command -v cargo &> /dev/null; then
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      export PATH="$HOME/.cargo/bin:$PATH"
      echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
    fi

    cd /vagrant/advent-of-code-2024-rust
    cargo build
  SHELL

  config.vm.synced_folder ".", "/vagrant"
end

