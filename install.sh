#!/bin/bash

###################

#instalando Docker-CE

if ! grep -q "docker" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
	echo "Adicionar chave GPG oficial do Docker"
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 

	#Use o seguinte comando para configurar o repositório estável
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
fi

if ! hash docker > /dev/null 2>&1; then
	echo "Instalando Docker-CE"
	#Primeiro remover versões antigas chamadas docker ou docker-engine
	sudo apt-get remove docker docker-engine docker.io

	#Atualize o indice de pacotes com o apt
	sudo apt-get update

	#Instalar pacotes para permitir que o apt use um repositório via HTTPS:
	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

	#Atualize novamente a lista de pacotes:
	sudo apt-get update

	#Finalmente instale a última versão do Docker CE:
	sudo apt-get install docker-ce -y
else
	echo "Docker already installed"
fi


# Install ansible #
if ! grep -q "ansible/ansible" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo "Adding Ansible PPA"
    sudo apt-add-repository ppa:ansible/ansible -y
fi

if ! hash ansible > /dev/null 2>&1; then
    echo "Installing Ansible..."
    sudo apt-get update
    sudo apt-get install software-properties-common ansible git pip python-apt -y
else
    echo "Ansible already installed"
fi

#####################################
# Display real installation process #
echo ""
echo " Altere o playbook playbook.yml de acordo com suas necessidade, em seguinda executar o comando :"
echo " ansible-playbook playbook.yml --ask-become-pass"
echo ""