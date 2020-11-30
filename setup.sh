#!/usr/bin/env bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

echo -e "$BOLD 
 _ _   _   _  _         _  _  _
|_ |  |_  |_ |_|\  / | |  |_ |_  
.  .    . .  .   ..  . .  .    .
|  | _ _| |_ |\  \/  | |_ |_  _| $NORMAL\n\n\n"

sudo apt-get update

#Downolading kubernetes's setup

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
	echo "You need to authorize virtualization in your bios"
	exit
fi

if ! command -v virtualbox > /dev/null
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
	minikube status > /dev/null
	if [ "$?" -ne "85" ]
	then
		minikube stop
		minikube delete --all
		echo "relaunching minikube..."
	else
		echo "starting minikube..."
	fi
	minikube start --driver=virtualbox
}

running_minikube

#point your shell to minikube's docker daemon
eval $(minikube docker-env)

build_and_deploy()	{
	docker build -t $1 srcs/deployments/$1/.
	kubectl apply -f srcs/deployments/$1/$1.yaml
}

build_and_deploy wordpress

#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

#cat srcs/metallab.yaml | kubectl create -f -
#minikube dashboard

exit
