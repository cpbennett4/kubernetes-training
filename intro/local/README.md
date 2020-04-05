Corresponds to the brown bag/course "Introduction to Kubernetes"
* Slides: https://docs.google.com/presentation/d/1_VfudUT3OlX36bZPGEwqYVU2fHY6SPvqA_zcbSePbCo

Prerequisites for trying out locally:

* Access to a cluster
* kubectl
* Some patience, since not all these files have been converted properly for docker

There are two easy ways to install a single node test cluster on your laptop.

Option I: Minikube
----

This is the better more fully featured option. Some people have trouble getting it running though

* Install Docker
* `brew install kubectl`
(Watch for link conflicts with docker and fix them - they give you instructions)
* `brew install minikube`
* `minikube start --vm-driver=virtualbox --cpus=4 --memory=4096 --extra-config=apiserver.runtime-config=settings.k8s.io/v1alpha1=true`

We are giving some cpu and memory headway so we can launch some deployments here of some size
We are pinning the kubernetes version for reproducibility

* `kubectl create ns infra`
* `kubectl apply -f local/minikube/podpreset.yaml`

this is needed for examples

Option II: Docker
-----
Docker itself has a built in single node kubernetes. It's very easy to run. The negatives? It tends
to be more behind the times on the Kubernetes version, and it doesn't support podpresets. We have to fake them, which means only certain converted files (all in the docker directory) work.

* Install Docker
* `brew install kubectl`
(Watch for link conflicts with docker and fix them)
* Go to the docker icon, preferences, and select kubernetes. Turn on the cluster.
* Wait....till it is running
* Go to the docker icon/kubernetes and select the docker in the pull down menu
* `kubectl create ns infra`
* `kubectl apply -f local/docker/podpreset.yaml`

For Docker
----
* use the copies in local instead of their directories

