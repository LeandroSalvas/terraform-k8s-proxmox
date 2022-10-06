k8s_masters = {
 m1 = { target_node = "pve", vcpu = "2", memory = "4096", disk_size = "15G", name = "k8sm1",notes = "Kubernetes Master", ip = "192.168.15.221", gw = "192.168.15.1" }
}

k8s_workers = {
 w1 = { target_node = "pve", vcpu = "2", memory = "2048", disk_size = "15G", name = "k8sw1",notes = "Kubernetes Worker", ip = "192.168.15.222", gw = "192.168.15.1" },
 w2 = { target_node = "pve", vcpu = "2", memory = "2048", disk_size = "15G", name = "k8sw2",notes = "Kubernetes Worker", ip = "192.168.15.223", gw = "192.168.15.1" }
}