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
ps -ef | grep docker@127.0.0.1
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

## Terraform
We will need the tool Terraform that will help us create the basic configuration of our cluster.
The lastest version of Terraform is recommanded, you can find it [here](https://www.terraform.io/downloads)

# How to setup
Now that all our tools have been installed, we just need to initialize our cluster with Terraform.
```bash
cd terraform
terraform init
terraform apply
```

When the terraform is done, the setup is already over.
We now have our application running on 2 pods on the cluster, and if a master branch of the repository is pushed and tagged correctly, a new image will be build and then deploy on our cluster.

Congrats !

# Cluster components
In this cluster you will find ArgoCD that is handling the image deployment and the registry scan.
To access the WebUI you can setup a ssh tunnel:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Also you can find the non encrypted password here:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```