Vagrant.configure("2") do |config|
	BOX_IMAGE = "ubuntu/impish64"
	BASE_NETWORK = "10.10.20"
	PROXY_HTTP = "http://10.0.2.2:5865"
	PROXY_HTTPS = "http://10.0.2.2:5865"
	PROXY_EXCLUDE = "localhost, 127.0.0.1"
	BOX_CHK_UPDATE = false
	SSH_INSERT_KEY = false
	PROXY_ENABLE = true
	VB_CHK_UPDATE = false

	config.vm.define "web" do |webconf|
		webconf.vm.box = BOX_IMAGE
		webconf.vm.network "private_network", ip: "#{BASE_NETWORK}.10",virtualbox__intnet: true
		webconf.vm.hostname = "web-srv"
		webconf.vm.network "forwarded_port", guest: 80, host: 9080
		if PROXY_ENABLE && Vagrant.has_plugin?("vagrant-proxyconf")
			#only use with plugin vagrant-proxy
			#print "setting proxy config"
			webconf.proxy.http = PROXY_HTTP
			webconf.proxy.https = PROXY_HTTPS
			webconf.proxy.no_proxy = PROXY_EXCLUDE
		end
		if Vagrant.has_plugin?("vagrant-vbguest")
			webconf.vbguest.auto_update = VB_CHK_UPDATE
		end
		webconf.vm.box_check_update = BOX_CHK_UPDATE
		webconf.ssh.insert_key = SSH_INSERT_KEY
		webconf.vm.provider "virtualbox" do |vb|
			vb.name = "VMWeb"
			vb.memory = "1024"
			vb.cpus = 1
			#alter connection to the vm for more reliable boot
			vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
			vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
			#vb.gui = true #enable only for debugging
		end
		webconf.vm.provision "shell", path: "./scripts/provision_update.sh"
		webconf.vm.provision "shell", path: "./scripts/provision_apache.sh"
		webconf.vm.provision "shell", path: "./scripts/provision_php.sh"
		webconf.vm.provision "shell", path: "./scripts/provision_phpmyadmin.sh"

	end
	config.vm.define "db" do |dbconf|
		dbconf.vm.box = BOX_IMAGE
		dbconf.vm.network "private_network", ip: "#{BASE_NETWORK}.15",virtualbox__intnet: true
		dbconf.vm.hostname = "db-srv"
		if PROXY_ENABLE && Vagrant.has_plugin?("vagrant-proxyconf")
			#only use with plugin vagrant-proxy
			#print "setting proxy config"
			dbconf.proxy.http = PROXY_HTTP
			dbconf.proxy.https = PROXY_HTTPS
			dbconf.proxy.no_proxy = PROXY_EXCLUDE
		end
		if Vagrant.has_plugin?("vagrant-vbguest")
			dbconf.vbguest.auto_update = VB_CHK_UPDATE
		end
		dbconf.vm.box_check_update = BOX_CHK_UPDATE
		dbconf.ssh.insert_key = SSH_INSERT_KEY
		dbconf.vm.provider "virtualbox" do |vb|
			vb.name = "VMDb"
			vb.memory = "1024"
			vb.cpus = 1
			#alter connection to the vm for more reliable boot
			vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
			vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
			#vb.gui = true #enable only for debugging
		end 	
		dbconf.vm.provision "shell", path: "./scripts/provision_update.sh"
		dbconf.vm.provision "shell", path: "./scripts/provision_mysql.sh"
		dbconf.vm.provision "shell", path: "./scripts/provision_mysql_database.sh"
	end
end
