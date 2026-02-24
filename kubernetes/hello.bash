#!/bin/bash

# Exit on any errors
set -e

# --- 1. System Preparation ---

# Update package index and install prerequisites for the Kubernetes repository
sudo apt-get update
# apt-transport-https may be a dummy package in newer distros; if so, it can be skipped.
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# Disable swap, required for K8s nodes
sudo swapoff -a
# Persistently disable swap on reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Add kernel modules and sysctl settings for Kubernetes networking
sudo modprobe overlay
sudo modprobe br_netfilter

# Setup sysctl parameters for Kubernetes networking
cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Apply sysctl parameters immediately
sudo sysctl --system

# (Optional, but recommended) Install a container runtime (Docker example)
# Note: Ensure the container runtime is properly configured to use the 'systemd' cgroup driver if needed
# sudo apt-get install -y docker.io
# sudo systemctl enable docker
# sudo systemctl start docker

# --- 2. Add Kubernetes APT Repository ---

# Create a directory for the Kubernetes keyring
sudo mkdir -p /etc/apt/keyrings

# Download and add the Kubernetes repository GPG key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# Note: Replace v1.30 with the desired stable version if a newer one is available

# Add the Kubernetes repository to the sources list
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# --- 3. Install kubeadm, kubelet, and kubectl ---

# Update apt package index with the new repository
sudo apt-get update

# Install the components and hold them to prevent automatic updates
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Enable the kubelet service before running kubeadm
sudo systemctl enable --now kubelet

echo "Kubernetes tools (kubelet, kubeadm, kubectl) installed successfully."
