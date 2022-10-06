#!/bin/bash
#
# Setup for Control Plane (Master) server

set -euxo pipefail

MASTER_IP="192.168.15.221"
NODENAME=$(hostname -s)
POD_CIDR="10.244.0.0/16"

sudo kubeadm config images pull

echo "Preflight Check Passed: Downloaded All Required Images"

sudo kubeadm init --apiserver-advertise-address=$MASTER_IP --control-plane-endpoint=$MASTER_IP --pod-network-cidr=$POD_CIDR --upload-certs

mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

# Save Configs on directory to share to another hosts access files to join cluster
config_path="/terraform/configs"

if [ -d $config_path ]; then
 sudo rm -f $config_path/*
else
 sudo mkdir -p $config_path
fi

sudo cp -i /etc/kubernetes/admin.conf /terraform/configs/config
sudo touch /terraform/configs/join.sh
sudo chmod 755 /terraform/configs/*
sudo chmod +x /terraform/configs/join.sh

sudo kubeadm token create --print-join-command > /terraform/configs/join.sh

# Install Calico Network Plugin

curl https://docs.projectcalico.org/manifests/calico.yaml -O

kubectl apply -f calico.yaml

# Install Metrics Server

kubectl apply -f https://raw.githubusercontent.com/scriptcamp/kubeadm-scripts/main/manifests/metrics-server.yaml

# Install Kubernetes Dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.1/aio/deploy/recommended.yaml

# Create Dashboard User

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

kubectl -n kubernetes-dashboard get secret "$(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}")" -o go-template="{{.data.token | base64decode}}" >> /terraform/configs/token

sudo -i -u ubuntu bash << EOF
whoami
mkdir -p /home/ubuntu/.kube
sudo cp -i /terraform/configs/config /home/ubuntu/.kube/
sudo chown 1000:1000 /home/ubuntu/.kube/config
EOF


echo "finished the MASTER configuration"