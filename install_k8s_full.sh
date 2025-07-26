#!/bin/bash

set -e

echo "===== Updating system ====="
sudo dnf update -y

echo "===== Installing Docker ====="
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

echo "===== Installing conntrack (Minikube dependency) ====="
sudo dnf install -y conntrack

echo "===== Installing kubectl ====="
sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
echo "kubectl version:"
kubectl version --client

echo "===== Installing Minikube ====="
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
echo "minikube version:"
minikube version

echo "===== Installing Helm ====="
curl -LO https://get.helm.sh/helm-v3.16.1-linux-amd64.tar.gz
tar -zxvf helm-v3.16.1-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64 helm-v3.16.1-linux-amd64.tar.gz
echo "helm version:"
helm version

echo "===== All installations complete ====="
echo "Log out and back in or run: newgrp docker"
echo "Start your Kubernetes cluster with: minikube start --driver=docker"
