**🔹 STEP 1 — Install containerd**


sudo apt update
sudo apt install -y containerd



**🔹 STEP 2 — Configure containerd properly (VERY IMPORTANT)**


sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

**Now edit config:**

sudo nano /etc/containerd/config.toml

**Find:**

SystemdCgroup = false

**Change to:**

SystemdCgroup = true

**Save and exit.**

**🔹 STEP 3 — Restart containerd**


sudo systemctl restart containerd
sudo systemctl enable containerd

**Check status:**

sudo systemctl status containerd

**It should show: active (running) ✅**

**🔹 STEP 4 — Disable Swap (MANDATORY)**


sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

*Now it should work.*


### important to run this 
# run this scripts#
**hello.bash**

**🔹 STEP 5 — Now Initialize Again**

sudo kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

\\

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.2/manifests/calico.yaml



**💪 After That Check:**

kubectl get nodes
kubectl get pods -n kube-system

**remove taint**

kubectl taint nodes --all node-role.kubernetes.io/control-plane-