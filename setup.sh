#!/usr/bin/env bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

echo -e "$BOLD 
 _ _   _   _  _         _  _  _
|_ |  |_  |_ |_|\  / | |  |_ |_  
.  .    . .  .   ..  . .  .    .
|  | _ _| |_ |\  \/  | |_ |_  _| $NORMAL\n\n\n"

sudo apt-get update

if ! command -v curl > /dev/null
then
	echo "Downloading curl..."
	sudo apt-get install curl
else
	echo "curl is already installed"
fi

if ! command -v snap > /dev/null
then
	echo "Downloading snap..."
	sudo apt-get install snap
else
	echo "snap is already installed"
fi

if ! command -v docker > /dev/null
then
	echo "Downloading docker..."
	sudo apt-get install docker
else
	echo "docker is already installed"
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
else
	echo "virtualbox is already installed"
fi

if ! command -v kubectl > /dev/null
then
	echo "Downloading kubectl..."
	snap install kubectl --classic
else
	echo "kubectl is already installed"
fi

if ! command -v minikube > /dev/null
then
	echo "Downloading minikube..."
 	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube
else
	echo "minikube is already installed"
fi

echo "starting minikube..."
minikube start

kubectl get po -A

exit
