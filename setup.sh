#!/usr/bin/env bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE='\033[0;37m'

echo -e "$BOLD 
 _ _   _   _  _         _  _  _
|_ |  |_  |_ |_|\  / | |  |_ |_  
.  .    . .  .   ..  . .  .    .
|  | _ _| |_ |\  \/  | |_ |_  _| $NORMAL\n\n"

SERVICES=(influxdb grafana nginx mysql wordpress phpmyadmin ftps)

#Downolading kubernetes's setup

sudo apt-get update > /dev/null

if ! command -v curl > /dev/null
then
	echo "Downloading curl..."
	sudo apt-get install curl
fi

if ! command -v snap > /dev/null
then
	echo "Downloading snap..."
	sudo apt-get install snap
fi

if ! grep -E --color 'vmx|svm' /proc/cpuinfo > /dev/null
then
	echo "Virtualization in your bios is not activated"
	echo "Docker driver will be used"
	echo "You may need to execute this command before a reboot of your system: sudo usermod -aG docker $(whoami)"
elif ! command -v virtualbox > /dev/null
then
	echo "Downloading virtualbox..."
	sudo apt-get install virtualbox-6.1
fi

if ! command -v kubectl > /dev/null
then
	echo "Downloading kubectl..."
	snap install kubectl --classic
fi

running_minikube()	{
	if ! command -v minikube > /dev/null
	then
		echo "Downloading minikube..."
 		curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
		sudo install minikube-linux-amd64 /usr/local/bin/minikube
	fi
	minikube status > /dev/null 2> /dev/null
	if [[ "$?" -ne "85" && "$?" -ne "7" ]]
	then
		minikube stop
		minikube delete --all
		echo "relaunching minikube..."
	else
		echo "starting minikube..."
	fi
	if ! grep -E --color 'vmx|svm' /proc/cpuinfo > /dev/null
	then
		sudo chown -R $USER ~/.kube
		sudo chown -R $USER $HOME/.kube $HOME/.minikube
		sudo chmod 600 $HOME/.kube/config
		minikube start --vm-driver=docker
	else
		minikube start --driver=virtualbox
	fi
}

running_minikube

metallb_setup()	{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml > output.log
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml >> output.log
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> output.log
	cat srcs/metallab.yaml | kubectl create -f - >> output.log
	lines=$(cat output.log | grep created | wc -l)
	if [ $lines -eq 17 ]
	then
		echo "Metallab is working"
	fi
}

metallb_setup

#point your shell to minikube's docker daemon
eval $(minikube docker-env)

build_and_deploy()	{
	length=$(echo -n $1 | wc -m)
	echo -n "Building $1 image..."
	docker build -t $1 srcs/$1/. > output.log
	if ! grep Successfully output.log > /dev/null
	then
		echo "Failed"
	else
		for ((i=0; i<11-$length; i++)){
			echo -n ' '
		}
		echo -n "Done!"
		echo -e '\U1F917'
	fi
	kubectl apply -f srcs/$1/$1.yaml > output.log
	if ! grep created output.log > /dev/null
	then
		echo -ne "$RED"
		echo -e "Service not deployed $WHITE"
	else
		echo -ne "$GREEN"
		echo -e "Service $1 deployed $WHITE"
	fi
}

for i in "${SERVICES[@]}"
do
	build_and_deploy $i
done

rm output.log

minikube dashboard

exit
