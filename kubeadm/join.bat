@ECHO OFF
: Delete Kubelet if it exists from a previous failed run
sc delete kubelet
: join the cluster with debugging on (helps to see if kubeadm fails for various reasons)
powershell -ExecutionPolicy Bypass .\KubeCluster.ps1 -join -ConfigFile Kubeclustervxlan.json
