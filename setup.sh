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
fi

if ! command -v snap > /dev/null
then
	echo "Downloading snap..."
	sudo apt-get install snap
fi

#if ! command -v docker > /dev/null
#then
#	echo "Downloading docker..."
#	sudo apt-get install docker
#fi

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

if ! command -v minikube > /dev/null
then
	echo "Downloading minikube..."
 	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube
elif minikube status > /dev/null
then
	minikube stop
	minikube delete --all
	echo "relaunching minikube..."
else
	echo "starting minikube..."
fi

minikube start --driver=virtualbox

#minikube status

#kubectl get po -A

#point your shell to minikube's docker daemon
eval $(minikube docker-env)

docker build -t test srcs/.
kubectl run test --image=test --image-pull-policy=Never


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

#cat srcs/metallab.yaml | kubectl create -f -
#minikube dashboard

exit
