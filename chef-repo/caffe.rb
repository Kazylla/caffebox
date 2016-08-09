class CaffeChef
  def CaffeChef.configure(config)
        if Vagrant.has_plugin?("vagrant-cachier")
                config.cache.scope = :box
                config.cache.auto_detect = true
#                config.cache.synced_folder_opts = {
#                        type: :nfs,
#                        mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
#                }
                if Vagrant.has_plugin?("vagrant-cachier")
                        config.omnibus.chef_version = :latest
                end
        end

        if Vagrant.has_plugin?("vagrant-cachier")
                config.omnibus.chef_version = :latest
        end

        config.vm.provision "chef_solo" do |chef|
                chef.cookbooks_path = ["chef-repo/cookbooks", "chef-repo/site-cookbooks"]
                chef.roles_path = "chef-repo/roles"
                chef.data_bags_path = "chef-repo/data_bags"
                chef.add_role("local")
                chef.node_name = "web"
#               chef.log_level = :debug
        end
  end
end
