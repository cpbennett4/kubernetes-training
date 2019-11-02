Corresponds to the brown bag/course "Introduction to Kubernetes"
* Slides: https://docs.google.com/presentation/d/1_VfudUT3OlX36bZPGEwqYVU2fHY6SPvqA_zcbSePbCo

Prerequisites for trying out locally:

* Access to a cluster
* kubectl
* Some patience, since not all these files have been converted properly

There are two easy ways to install a single node test cluster on your laptop. Normally I recommend minikube, but it has been ... problematic lately ...

Option I: Minikube
----

* Install Docker
* `brew install kubectl`
(Watch for link conflicts with docker and fix them)
* `brew install minikube`
* `minikube start --kubernetes-version v1.15.2 --cpus=4 --memory=4096`

We are giving some cpu and memory headway so we can launch some deployments here of some size
We are pinning the kubernetes version for reproducibility

* `kubectl apply -f local/podpreset.yaml`

this is needed for examples

Option II: Docker
-----
Docker itself has a built in single node kubernetes

* Install Docker
* `brew install kubectl`
(Watch for link conflicts with docker and fix them)
* Go to the docker icon, preferences, and select kubernetes. Turn on the cluster.
* Wait....till it is running
* Go to the docker icon/kubernetes and select the docker in the pull down menu
* `kubectl apply -f local/podpreset.yaml`

For Both
----
* On a local box. this is still going to result in restarts. Take a look at pod-example for an idea of what to modify - noted in the comments



