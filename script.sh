#!/usr/bin/env bash
rm -rf test

GLOBALCOLOR='\e[34m'
COLOR='\e[92m' #Color
COLORQ='\e[42m'
COLORP='\e[104m'
NC='\e[0m' # No Color

echo -e ""
echo -e "${COLOR}Validation Linux 1${NC}"
echo ""
echo -e "${GLOBALCOLOR}Nous allons procéder à l'installation  de la Vagrant${NC}"
echo ""

nomVariable=0

#Installation de la Vagrant
echo -e "${COLORP}Avez-vous déjà une Vagrant installée ?${NC} "
echo -e "${COLORQ}1-Oui${NC}"
echo -e "${COLORQ}2-Non${NC}"
read -p "Faites un choix :  " choice
if [[ $choice = 2 ]]; then
  sudo apt-get install vagrant #commande d'installation vagrant
fi
echo ""
echo -e "${GLOBALCOLOR}La Vagrant à bien été installée.${NC}"

#Installation de la VirtualBox
echo ""
echo -e "${COLORP}Avez-vous déjà une VirtualBox ?${NC} "
echo -e "${COLORQ}1-Oui${NC}"
echo -e "${COLORQ}2-Non${NC}"
read -p "Faites un choix :  " choice
if [[ $choice = 2 ]]; then
  sudo apt-get install virtualbox #commande d'installation virtualbox
fi
echo ""
echo -e "${GLOBALCOLOR}Votre virtualbox à bien été installée.${NC}"

#Création de la VagrantBox

##Initialisation du vagrantfile
echo ""
read -p "Nous allons maintenant procéder à la création du Vagrantfile, tapez entrer pour continuer"

read -p "Entrez le nom du dossier local " localFolder
echo ""
read -p "Entrez le nom du dossier synchronisé " syncFolder
echo ""
read -p "Entrez l'adresse ip que vous souhaitez utiliser " ipChoice
echo ""
echo -e "${COLORP}Voici une liste des boxes disponibles :${NC} "
echo "ubuntu/xenial64"
echo "ubuntu/xenial64"
read -p "Tapez le choix de votre box :  " choixBox

mkdir $localFolder #crée le dossier local
mkdir $localFolder"/"$syncFolder #place le dosssier synchronisé dans le dossier local

#modification du contenu du vagrantfile
cat > $localFolder"/"Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "$choixBox"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "$ipChoice"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "./$syncFolder", "/var/www/html"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
EOF
cd $localFolder
vagrant up #lancement de la vagrant dans le dossier local

test="# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "base"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end"

#Interaction avec les vagrant
echo ""
echo "Interaction avec les vagrant : "
echo ""

#Affichage de toutes les vagrantes allumées
echo -e "${COLORP}Voulez-vous afficher toutes les vagrantes actives${NC}"
echo -e "${COLORQ}1-Oui${NC}"
echo -e "${COLORQ}2-Non${NC}"
  read -p "Faites un choix" nomVariable
  if [[ $nomVariable = 1 ]]; then
    vagrant global-status
  fi

#Eteindre des vagrantes
echo -e "${COLORP}Voulez-vous supprimer une vagrant ?${NC}"
echo -e "${COLORQ}1-Oui${NC}"
echo -e "${COLORQ}2-Non${NC}"
read -p "Faites un choix" nomVariable
if [[ $nomVariable = 1 ]]; then
  read -p "Entrez l'id de la vagrant à supprimer " idVagrant
  vagrant destroy $idVagrant
fi

#Configuration du ssh
#read -p "Nous allons procéder à l'installation des paquets tapez entrer"
#vagrant ssh
#sudo apt-get install apache2
