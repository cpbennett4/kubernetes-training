# launch
kubectl apply -f deployment-example.yaml
# adoption of pods via selectors

kubectl -n infra get pods

# here's a sample
# note pods are randomly named! prefix is the deployment name

#deployment-example-858bf896c6-6xsnh           0/1     Running   0          9s
#deployment-example-858bf896c6-77zhh           0/1     Running   0          9s
#deployment-example-858bf896c6-vcrqt           0/1     Running   0          9s

kubectl -n infra get deployment deployment-example
#mbell@sfo17m002839 intro (master) $
#NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
#deployment-example   3/3     3            3           18m

kubectl -n infra describe deployment deployment-example

kubectl -n infra get rs

# deployment-example-858bf896c6
# kubectl -n infra describe rs deployment-example-858bf896c6

# scale up
kubectl -n infra apply -f deployment-example-with-more-replicas.yaml
# look at deployment, podprefix
# change image... watch a rolling deploy

kubectl -n infra apply -f deployment-example-change-image.yaml
# initially...
#Normal  ScalingReplicaSet  13m    deployment-controller  Scaled up replica set deployment-example-858bf896c6 to 3
# then we scaled up...
#  Normal  ScalingReplicaSet  7m38s  deployment-controller  Scaled up replica set deployment-example-858bf896c6 to 6
# now we scaled down AND changed images...
#  Normal  ScalingReplicaSet  2m56s  deployment-controller  Scaled down replica set deployment-example-858bf896c6 to 3
#  Normal  ScalingReplicaSet  2m56s  deployment-controller  Scaled up replica set deployment-example-6b67f989d to 1
#  Normal  ScalingReplicaSet  2m14s  deployment-controller  Scaled down replica set deployment-example-858bf896c6 to 2
#  Normal  ScalingReplicaSet  2m14s  deployment-controller  Scaled up replica set deployment-example-6b67f989d to 2
#  Normal  ScalingReplicaSet  101s   deployment-controller  Scaled down replica set deployment-example-858bf896c6 to 1
#  Normal  ScalingReplicaSet  101s   deployment-controller  Scaled up replica set deployment-example-6b67f989d to 3
#  Normal  ScalingReplicaSet  66s    deployment-controller  Scaled down replica set deployment-example-858bf896c6 to 0

kubectl -n infra delete deployment deployment-example
