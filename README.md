# Prerequisites

## Kubernetes Cluster
We will need a Kubernetes cluster to deploy our application located at:
[Link to project](https://github.com/farnir/instant-search-demo)

In this example we will use [MiniKube](https://github.com/kubernetes/minikube) because it's easy to use and really fast to setup.

To install minikube you can follow the documentation [here](https://minikube.sigs.k8s.io/docs/start/)
But for Linux on a x86-64 architecture the commands will be:
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

Minikube can use many different driver to run but the most common is Docker.
You can found how to install it [here](https://docs.docker.com/desktop/linux/install/ubuntu/)


Then we need to start our cluster with minikube with the command:
```bash
minikube start
```

### Tips on Minikube
You may have difficulties to access the Cluster IP of Kubernetes cluster and the NodePort open to access the service on Minikube.
The issue may come from Docker in Windows, where the network is limited and this Node IP is not reachable directly. In order to solve that you can create tunnel to the NodeIP directly with minikube with the command:
```bash
minikube service {name_of_your_service} --url
```
Here name_of_your_service is **search-app**.

## Kubectl
We will also need Kubectl in order to control our Kubernetes cluster.

You can install kubectl from [there](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
For example with curl on linux, it will be:
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```
