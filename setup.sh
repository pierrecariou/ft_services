#!/usr/bin/env bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

echo -e "$BOLD 
 _ _   _   _  _         _  _  _
|_ |  |_  |_ |_|\  / | |  |_ |_  
.  .    . .  .   ..  . .  .    .
|  | _ _| |_ |\  \/  | |_ |_  _| $NORMAL\n\n\n"

SERVICES=(mysql phpmyadmin)

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
	minikube status > /dev/null 2> /dev/null
	if [[ "$?" -ne "85" && "$?" -ne "7" ]]
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

metallb_setup()	{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	cat srcs/metallab.yaml | kubectl create -f -
}

metallb_setup

#point your shell to minikube's docker daemon
eval $(minikube docker-env)

build_and_deploy()	{
	docker build -t $1 srcs/$1/.
	kubectl apply -f srcs/$1/$1.yaml
}

for i in "${SERVICES[@]}"
do
	build_and_deploy $i
done

minikube dashboard

exit
