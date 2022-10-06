#!/bin/bash
#
# Setup for Node servers

set -euxo pipefail

MASTER_IP="192.168.15.221"

mkdir -p /terraform/configs/
sudo wget http://$MASTER_IP:8000/join.sh -P /terraform/configs/
sudo wget http://$MASTER_IP:8000/config -P /terraform/configs/
sudo wget http://$MASTER_IP:8000/token -P /terraform/configs/
chmod +x /terraform/configs/join.sh
/bin/bash /terraform/configs/join.sh -v

sudo -i -u ubuntu bash << EOF
whoami
mkdir -p /home/ubuntu/.kube
sudo cp -i /terraform/configs/config /home/ubuntu/.kube/
sudo chown 1000:1000 /home/ubuntu/.kube/config
NODENAME=$(hostname -s)
kubectl label node $(hostname -s) node-role.kubernetes.io/worker=worker
EOF

echo "WORKER node CONFIG FINISHED"
