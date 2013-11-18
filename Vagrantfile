Vagrant::Config.run do |config|
  config.vm.box     = "cloudspace_default_12.042"
  config.vm.box_url = "http://vagrant.cloudspace.com.s3.amazonaws.com/cloudspace_ubuntu_12.042_ruby_2.box"
  
  # config.vm.box = "precise64"
  # config.vm.box_url = "http://vagrant.cloudspace.com.s3.amazonaws.com/cloudspace_ubuntu_12.04.box"
  # config.vm.network :hostonly, "10.10.10.10"
  
  config.ssh.private_key_path = File.join(ENV['HOME'], '.ssh', 'cs_vagrant.pem')
  
  config.vm.share_folder("cloudlogistics", "/srv/cloudlogistics", "./")

  # config.vm.boot_mode = :gui
  

  config.vm.define :web do |web|
    web.vm.network(:hostonly, "33.33.33.116")
    
    config.vm.customize ["modifyvm", :id, "--memory", "8192", "--name", "api.crunchinator.com","--cpus", "2"]
    
    web.vm.provision :chef_solo do |chef|        
      chef.cookbooks_path = "./cookbooks"
      
      chef.add_recipe "ubuntu"
      chef.add_recipe "git"
      chef.add_recipe "postgresql::client"
      chef.add_recipe "postgresql::server"
      
      chef.json = {
        postgresql: {
          password: {
            postgres: 'postgres'
          }
        }
      }
      # chef.roles_path = "./ops/roles"
    end
  end
  
end
