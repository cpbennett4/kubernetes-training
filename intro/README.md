Corresponds to the brown bag/course "Introduction to Kubernetes"
* Slides: https://docs.google.com/presentation/d/1_VfudUT3OlX36bZPGEwqYVU2fHY6SPvqA_zcbSePbCo

Prerequisites for trying out:

* Access to a cluster
* kubectl

You can install these using brew

* Install Docker
* `brew install kubectl`
(Watch for link conflicts with docker and fix them)
* `brew install minikube`
* `minikube start --kubernetes-version v1.15.2 --cpus=4 --memory=4096`

We are giving some cpu and memory headway so we can launch some deployments here of some size
We are pinning the kubernetes version for reproducibility

* `kubectl create ns infra`

this is needed for examples
